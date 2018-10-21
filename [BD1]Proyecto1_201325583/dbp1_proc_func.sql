CREATE FUNCTION loguear
(@usuario VARCHAR(50), @dominio VARCHAR(50), @pass VARCHAR(50))
RETURNS BIT
AS
BEGIN
	DECLARE @existe AS INT = 0;
	SET @existe = (
		SELECT COUNT(*) FROM CUENTA
		WHERE ident = @usuario and dominio = @dominio
		and pass = @pass
	);
	IF @existe IS NULL
		BEGIN
		RETURN 0;
		END;
	RETURN @existe;
END;

CREATE FUNCTION existe_usuario
(@usuario VARCHAR(50))
RETURNS BIT
AS
BEGIN
	DECLARE @existe AS INT = 0;
	SET @existe = (
		SELECT COUNT(*) FROM CUENTA
		WHERE ident = @usuario
	);
	IF @existe IS NULL
		BEGIN
		RETURN 0;
		END;
	RETURN @existe;
END;

CREATE FUNCTION existe_correo
(@usuario VARCHAR(50), @dominio VARCHAR(50))
RETURNS BIT
AS
BEGIN
	DECLARE @existe AS INT = 0;
	SET @existe = (
		SELECT COUNT(*) FROM CUENTA
		WHERE ident = @usuario and dominio = @dominio
	);
	IF @existe IS NULL
		BEGIN
		RETURN 0;
		END;
	RETURN @existe;
END;

CREATE FUNCTION obtener_mensaje
(@asunto VARCHAR(50), @texto VARCHAR(256))
RETURNS INT
AS
BEGIN
	DECLARE @codigo AS INT = -1;
	SET @codigo = (
		SELECT codigo FROM MENSAJE
		WHERE asunto = @asunto and texto = @texto
	);
	IF @codigo IS NULL
		BEGIN
		RETURN -1;
		END;
	RETURN @codigo;
END;

CREATE FUNCTION obtener_carpeta
(@nombre VARCHAR(50), @usuario VARCHAR(50), @padre VARCHAR(50), @nivel INTEGER)
RETURNS INT
BEGIN
	--Retorna el codigo de la carpeta
	DECLARE @existe AS INT;
	DECLARE @num_padre AS INT = 0;
	DECLARE @cod_padre AS INT;
	--Verificar si la carpeta padre existe en el nivel y usuario dado
	SET @num_padre = (
		SELECT COUNT(*) FROM CARPETA
		WHERE nombre = @padre and CUENTA_ident = @usuario and nivel = @nivel
	);

	IF @num_padre = 0
		--Es por que padre no existe entonces la carpeta esta el raiz
		BEGIN
		SET @existe = (
			SELECT codigo FROM CARPETA
			WHERE nombre = @nombre and CUENTA_ident = @usuario and nivel = @nivel
		);
		IF @existe IS NULL
			BEGIN
			RETURN -1;
			END;
		ELSE
			BEGIN
			RETURN @existe;
			END;
		END;
	ELSE
		--Es por que padre si existe y buscar su codigo
		BEGIN
		IF @num_padre = 1
			BEGIN
			--Buscar el codigo de la carpeta padre
			SET @cod_padre = (
				SELECT codigo FROM CARPETA
				WHERE nombre = @padre and CUENTA_ident = @usuario and nivel = @nivel
			);
			SELECT @existe = NULL;
			SET @existe = (
				SELECT codigo FROM CARPETA
				WHERE nombre = @nombre and CUENTA_ident = @usuario and nivel = (@nivel+1) and CARPETA_codigo = @cod_padre
			);
			IF @existe IS NULL
				BEGIN
				RETURN -1;
				END;
			ELSE
				BEGIN
				RETURN @existe;
				END;
			END;
		END;
	RETURN -1;
END;

CREATE PROCEDURE asignar_archivo
@ruta VARCHAR(100), @mensaje INT
AS
BEGIN
	INSERT INTO ARCHIVO (ruta, MENSAJE_codigo) VALUES (@ruta, @mensaje);
END;

CREATE PROCEDURE crear_mensaje
@asunto VARCHAR(50), @texto VARCHAR(256)
AS
BEGIN
	INSERT INTO MENSAJE (asunto, texto) VALUES (@asunto, @texto);
END;

CREATE PROCEDURE crear_carpeta
@nombre VARCHAR(50),
@tipo VARCHAR(50),
@usuario VARCHAR(50),
@padre VARCHAR(50),
@nivel INTEGER
AS
BEGIN
	DECLARE @existe AS INT = 0;
	DECLARE @num_padre AS INT = 0;
	DECLARE @cod_padre AS INT;
	--Verificar si la carpeta padre existe en el nivel y usuario dado
	SET @num_padre = (
		SELECT COUNT(*) FROM CARPETA
		WHERE nombre = @padre and CUENTA_ident = @usuario and nivel = @nivel
	);
	--Si el @num_padre = 0 es porque la carpeta padre es NULL o no existe
	--En este caso buscar por si existe la carpeta en este nivel
	IF @num_padre = 0
		BEGIN
		SET @existe = (
			SELECT COUNT(*) FROM CARPETA
			WHERE nombre = @nombre and CUENTA_ident = @usuario and nivel = @nivel
		);
		IF @existe = 0
			BEGIN
				INSERT INTO CARPETA (nivel, nombre, tipo, CUENTA_ident, CARPETA_codigo)
				VALUES (0, @nombre, @tipo, @usuario, NULL);
				PRINT 'Carpeta creado en raiz';
			END;
		ELSE
			PRINT 'La carpeta existe';
		END;
	ELSE
		BEGIN
		--Se el @num_padre = 1 es porque la carpeta padre si existe y se encontro
		IF @num_padre = 1
			BEGIN
			--Buscar el codigo de la carpeta padre
			SET @cod_padre = (
				SELECT codigo FROM CARPETA
				WHERE nombre = @padre and CUENTA_ident = @usuario and nivel = @nivel
			);
			--Ahora buscar la carpeta si ya existe en padre
			SELECT @existe = 0;
			SET @existe = (
				SELECT COUNT(*) FROM CARPETA
				WHERE nombre = @nombre and CUENTA_ident = @usuario and nivel = (@nivel+1) and CARPETA_codigo = @cod_padre
			);
			--En caso de que existe insertar la nueva carpeta
			IF @existe = 0
				BEGIN
				INSERT INTO CARPETA (nivel, nombre, tipo, CUENTA_ident, CARPETA_codigo)
				VALUES ((@nivel+1), @nombre, @tipo, @usuario, @cod_padre);
				PRINT 'Carpeta creado en la carpeta padre ' + @padre;
				END;
			ELSE
				PRINT 'La carpeta ya existe';
			END;
		ELSE
			PRINT 'No se creo la carpeta';
		END;
END;

CREATE PROCEDURE crear_usuario
@ident VARCHAR(50),
@nombre VARCHAR(100),
@empresa VARCHAR(50),
@dominio VARCHAR(50),
@pass VARCHAR(50)
AS
BEGIN
	--declaracion para saber si existe el usuario
	DECLARE @existe AS INT = 0;
	SET @existe = (
		SELECT COUNT(*) FROM CUENTA
		WHERE ident = @ident
	);

	IF @existe = 0
		BEGIN
		INSERT INTO CUENTA(ident, nombre, empresa, dominio, pass)
		VALUES (@ident, @nombre, @empresa, @dominio, @pass);

		EXEC crear_carpeta 'Entrada', 'privado', @ident, '', 0;
		EXEC crear_carpeta 'Enviados', 'privado', @ident, '', 0;
		EXEC crear_carpeta 'Borradores', 'privado', @ident, '', 0;
		EXEC crear_carpeta 'Eliminados', 'privado', @ident, '', 0;
		PRINT 'Usuario "' + @ident + '" creado';
		END;
	ELSE
		PRINT 'El usuario existe';
END;

CREATE PROCEDURE asignar_msg
@tipo VARCHAR(50),
@fecha DATETIME,
@cod_msg INT,
@cod_carpeta INT,
@cuenta VARCHAR(50)
AS
BEGIN
	INSERT INTO MSG(fecha, estado, tipo, CUENTA_ident, CARPETA_codigo, MENSAJE_codigo)
	VALUES (@fecha, 0, @tipo, @cuenta, @cod_carpeta, @cod_msg);
END;

CREATE FUNCTION obtener_carpeta
(@padre VARCHAR(50), @nivel INT, @nombre VARCHAR(50), @usuario VARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @existe AS INT = -1;
	IF @padre IS NULL
		BEGIN
		SET @existe = (
			SELECT c.codigo FROM CARPETA C
			LEFT JOIN CARPETA P ON C.CARPETA_codigo = P.codigo
			WHERE C.CUENTA_ident  = P.CUENTA_ident OR P.CUENTA_ident IS NULL AND 
			C.CUENTA_ident = @usuario AND p.nombre IS NULL AND c.nombre = @nombre
			AND C.nivel = @nivel
		);
		END;
	ELSE
		BEGIN
		SET @existe = (
			SELECT c.codigo FROM CARPETA C
			LEFT JOIN CARPETA P ON C.CARPETA_codigo = P.codigo
			WHERE C.CUENTA_ident  = P.CUENTA_ident OR P.CUENTA_ident IS NULL AND 
			C.CUENTA_ident = @usuario AND p.nombre = @padre AND c.nombre = @nombre
			AND p.nivel = @nivel
		);
		END;
	IF @existe IS NULL
		BEGIN
		RETURN -1;
		END;
	RETURN @existe;
END;

select * from CARPETA;

SELECT dbo.obtener_carpeta (NULL, 0, 'raiz', 'id1');


CREATE PROCEDURE crear_carpeta
@nombre VARCHAR(50),
@tipo VARCHAR(50),
@usuario VARCHAR(50),
@padre VARCHAR(50),
@nivel INTEGER
AS
BEGIN
	--Verificar si existe la carpeta
	DECLARE @codigo AS INT;
	SET @codigo = (
		SELECT dbo.obtener_carpeta (@padre, @nivel, @nombre, @usuario)
	);
	DECLARE @codpadre AS INT;
	SET @codpadre = (
		SELECT codigo FROM CARPETA
		WHERE nombre = @padre and nivel = @nivel 
		and CUENTA_ident = @usuario
	);
	IF @codigo = -1
		BEGIN
		IF @codpadre IS NULL
			BEGIN
			INSERT INTO CARPETA (nivel, nombre, tipo, CUENTA_ident, CARPETA_codigo)
			VALUES (@nivel, @nombre, @tipo, @usuario, @codpadre);
			END;
		ELSE
			BEGIN
			INSERT INTO CARPETA (nivel, nombre, tipo, CUENTA_ident, CARPETA_codigo)
			VALUES ((@nivel+1), @nombre, @tipo, @usuario, @codpadre);
			END;
		END;
END;

CREATE PROCEDURE actualizar_estado
@estado INT,
@codigo INT
AS
BEGIN
	UPDATE MSG SET
	estado = @estado
	WHERE codigo = @codigo;
END;

CREATE PROCEDURE actualizar_carpeta
@carpeta INT,
@codigo INT
AS
BEGIN
	UPDATE MSG SET
	CARPETA_codigo = @carpeta
	WHERE codigo = @codigo;
END;

CREATE PROCEDURE eliminar_msg
@codigo INT
AS
BEGIN
	DELETE FROM MSG
	WHERE codigo = @codigo;
END;

SELECT * FROM MSG;