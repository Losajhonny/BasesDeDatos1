use PROYECTO1;

-----------------------------------------------------------------------
--Disparador de trigger utilizada para crear las carpetas principales--
-------------como entrada, borrador, enviados y eliminados-------------
-----------------------------------------------------------------------
CREATE TRIGGER insertar_cuenta
ON CUENTA AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	--Se creo una cuenta por lo que se crea las
	--carpetas de entrada, enviado, borrador y eliminado
	
	--Se declara la variable cod_cuenta para insertarlo a la CARPETA
	DECLARE @cod_cuenta AS VARCHAR(50);
	SET @cod_cuenta = (SELECT ident FROM inserted);

	IF @cod_cuenta IS NOT NULL
		BEGIN
			EXEC crear_carpeta ('entrada', 'privado', @cod_cuenta, '');
			EXEC crear_carpeta ('borrador', 'privado', @cod_cuenta, '');
			EXEC crear_carpeta ('enviados', 'privado', @cod_cuenta, '');
			EXEC crear_carpeta ('eliminados', 'privado', @cod_cuenta, '');
		END;
END;

-----------------------------------------------------------------------
--------------------Procedure para crear una cuenta--------------------
-----------------------------------------------------------------------
CREATE PROCEDURE crear_cuenta
@ident VARCHAR(50),
@nombre_completo VARCHAR(100),
@nombre_empresa VARCHAR(50),
@dominio VARCHAR(50),
@pass VARCHAR(50)
AS
BEGIN
	--variable para verificar si existe o no
	DECLARE @ident_cuenta AS VARCHAR(50);
	--buscar ident_cuenta
	SET @ident_cuenta = (
		SELECT ident FROM CUENTA
		WHERE ident = @ident
	);
	IF @ident_cuenta IS NULL
		BEGIN
			INSERT INTO CUENTA (ident, nombre_completo, nombre_empresa, dominio, pass)
			VALUES (@ident, @nombre_completo, @nombre_empresa, @dominio, @pass);
		END;
	ELSE
		PRINT 'La cuenta ' + @ident + ' ya existe';
END;

-----------------------------------------------------------------------
---------------------Procedure para crear carpeta----------------------
-----------------------------------------------------------------------
CREATE PROCEDURE crear_carpeta
@carpeta_hijo VARCHAR(50),
@tipo VARCHAR(30),
@cuenta_ident VARCHAR(50),
@carpeta_padre VARCHAR(50)
AS
BEGIN
	--variable para tener el codigo de la carpeta padre
	DECLARE @padre_cod AS INT;
	--variable para tener el codigo de la carpeta hijo
	DECLARE @hijo_cod AS INT;
	--buscar el padre_cod
	SET @padre_cod = (
		SELECT codigo FROM CARPETA
		WHERE nombre = @carpeta_padre
	);
	--buscar el hijo_cod y que este en cuenta_ident
	SET @hijo_cod = (
		SELECT codigo FROM CARPETA
		WHERE nombre = @carpeta_hijo AND CUENTA_ident = @cuenta_ident
		AND CARPETA_codigo = @padre_cod
	);
	--si el hijo_cod es null entonces se puede insertar
	IF @hijo_cod IS NULL
		BEGIN
			INSERT INTO CARPETA (nombre, tipo_carpeta, CUENTA_ident, CARPETA_codigo)
			VALUES (@carpeta_hijo, @tipo, @cuenta_ident, @padre_cod);
		END;
	ELSE
		IF @padre_cod IS NULL
			PRINT 'La carpeta ' + @carpeta_hijo + ' ya existe en la raiz';
		ELSE
			PRINT 'La carpeta ' + @carpeta_hijo + ' ya existe en la ' + @carpeta_padre;
END;

-----------------------------------------------------------------------
------------------Procedure para importar un archivo-------------------
-----------------------------------------------------------------------
CREATE PROCEDURE crear_archivo
@path VARCHAR(50),
@msg_cod INTEGER
AS
BEGIN
	DECLARE @cod AS INT;
	SET @cod = (
		SELECT codigo FROM ARCHIVO
		WHERE ruta = @path AND MENSAJE_codigo = @msg_cod
	);
	IF @cod IS NULL
		BEGIN
			INSERT INTO ARCHIVO (ruta, MENSAJE_codigo)
			VALUES (@path, @msg_cod);
		END;
	ELSE
		PRINT 'El archivo ya existe en el mensaje';
END;