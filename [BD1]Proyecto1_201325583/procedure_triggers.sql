CREATE PROCEDURE crear_carpeta
@nombre VARCHAR(50),
@tipo VARCHAR(30),
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
				INSERT INTO CARPETA (nivel, nombre, tipo, CUENTA_ident, CARPETA_cod)
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
				WHERE nombre = @nombre and CUENTA_ident = @usuario and nivel = (@nivel+1) and CARPETA_cod = @cod_padre
			);
			--En caso de que existe insertar la nueva carpeta
			IF @existe = 0
				BEGIN
				INSERT INTO CARPETA (nivel, nombre, tipo, CUENTA_ident, CARPETA_cod)
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
		INSERT INTO CUENTA(ident, nombre_completo, nombre_empresa, dominio, pass)
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

CREATE PROCEDURE crear_mensaje
@texto VARCHAR(256), @asunto VARCHAR(50)
AS
BEGIN
	DECLARE @codigo AS INT;
	SET @codigo = (
		SELECT codigo FROM MENSAJE
		WHERE texto = @texto and asunto = @asunto
	);

	IF @codigo IS NULL
		BEGIN
		INSERT INTO MENSAJE (texto, asunto) VALUES (@texto, @asunto);
		END;
END;

CREATE FUNCTION obtener_mensaje
(@texto VARCHAR(256), @asunto VARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @codigo AS INT;
	SET @codigo = (
		SELECT codigo FROM MENSAJE
		WHERE texto = @texto and asunto = @asunto
	);
	IF @codigo IS NULL
		BEGIN
		RETURN (-1);
		END;
	RETURN (@codigo);
END;

CREATE FUNCTION logear
(@user VARCHAR(50), @dominio VARCHAR(50), @password VARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @existe AS INT = 0;
	SET @existe = (
		SELECT COUNT(*) FROM CUENTA
		WHERE ident = @user and dominio = @dominio and pass = @password
	);
	--RETORNA 1 SI EXISTE EL LOGEO
	--RETORNA 0 CUANDO NO EXISTE
	RETURN (@existe)
END;

CREATE FUNCTION verificar_usuario
(@user VARCHAR(50))
RETURNS BIT
AS
BEGIN
	DECLARE @existe AS BIT = 0;
	SET @existe = (
		SELECT COUNT(*) FROM CUENTA
		WHERE ident = @user
	);
	RETURN (@existe)
END;

CREATE FUNCTION existe_usuario
(@user VARCHAR(50), @dominio VARCHAR(50))
RETURNS BIT
AS
BEGIN
	DECLARE @existe AS BIT = 0;
	SET @existe = (
		SELECT COUNT(*) FROM CUENTA
		WHERE ident = @user and dominio = @dominio
	);
	RETURN (@existe)
END;

CREATE FUNCTION buscar_carpeta
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
			RETURN (-1)
			END;
		ELSE
			BEGIN
			RETURN (@existe)
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
				WHERE nombre = @nombre and CUENTA_ident = @usuario and nivel = (@nivel+1) and CARPETA_cod = @cod_padre
			);
			IF @existe IS NULL
				BEGIN
				RETURN (-1)
				END;
			ELSE
				BEGIN
				RETURN (@existe)
				END;
			END;
		END;
	RETURN (-1)
END;

CREATE PROCEDURE asignar_msg
@tipo VARCHAR(30),
@fecha DATETIME,
@cod_msg INT,
@cod_carpeta INT,
@cuenta VARCHAR(50)
AS
BEGIN
	INSERT INTO USRMSG (tipo_envio, fecha, estado, MENSAJE_codigo, CARPETA_codigo, CUENTA_ident)
	VALUES (@tipo, @fecha, 0, @cod_msg, @cod_carpeta, @cuenta);
END;

CREATE PROCEDURE asignar_archivos
@ruta VARCHAR(50), @codmsg INT
AS
BEGIN
	DECLARE @existe AS INT;
	SET @existe = (
		SELECT codigo FROM ARCHIVO
		WHERE ruta = @ruta and MENSAJE_codigo = @codmsg
	);
	IF @existe IS NULL
		BEGIN
		INSERT INTO ARCHIVO (ruta, MENSAJE_codigo) VALUES (@ruta, @codmsg);
		END;
END;

SELECT dbo.buscar_carpeta ('Entrada', 'id2', '', 0);

select * from CUENTA;
select * from CARPETA;

select umsg.estado, umsg.fecha, msg.asunto from USRMSG umsg, MENSAJE msg
where CARPETA_codigo = 58 and CUENTA_ident = 'id1' and msg.codigo = MENSAJE_codigo;