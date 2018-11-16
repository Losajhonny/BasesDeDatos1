USE DBP2
-- PARA LOS QUE TIENE LA RESTRICCION UNIQUE
-- NO ES NECESARIO VALIDAR SI EXISTE UNA TUPLA
-- ANTES DE SER INGRESADO YA QUE EL DBMS MOSTRARA
-- UN ERROR DE QUE AL MOMENTO DE INGRESAR EL DATO
-- YA EXISTE LA TUPLA
CREATE PROCEDURE REGISTRAR_GOL
@equipo VARCHAR(50), @nocamisola INTEGER
AS
BEGIN
	DECLARE @ce AS INTEGER = (SELECT codequipo FROM EQUIPO WHERE nombre = @equipo);
	UPDATE JUGADOR
	SET goles=goles+1
	WHERE nocamisola = @nocamisola
	and EQUIPO_codequipo = @ce;
END;

CREATE PROCEDURE INSERTAR_PAIS
@nombre VARCHAR(50)
AS
BEGIN
	BEGIN TRY
	INSERT INTO PAIS ( nombre ) VALUES ( @nombre );
	END TRY
	BEGIN CATCH
	PRINT @nombre + ' ya existe en la tabla PAIS';
	END CATCH;
END;

CREATE PROCEDURE INSERTAR_CONFEDERACION
@nombre VARCHAR(50)
AS
BEGIN
	BEGIN TRY
	INSERT INTO CONFEDERACION ( nombre ) VALUES ( @nombre );
	END TRY
	BEGIN CATCH
	PRINT @nombre + ' ya existe en la tabla CONFEDERACION';
	END CATCH;
END;

CREATE PROCEDURE INSERTAR_CIUDAD
@nombre VARCHAR(50)
AS
BEGIN
	BEGIN TRY
	INSERT INTO CIUDAD ( nombre ) VALUES ( @nombre );
	END TRY
	BEGIN CATCH
	PRINT @nombre + ' ya existe en la tabla CIUDAD';
	END CATCH;
END;

CREATE PROCEDURE INSERTAR_ARBITRO
@nombre VARCHAR(50)
AS
BEGIN
	BEGIN TRY
	INSERT INTO ARBITRO ( nombre ) VALUES ( @nombre );
	END TRY
	BEGIN CATCH
	PRINT @nombre + ' ya existe en la tabla ARBITRO';
	END CATCH;
END;

DROP PROCEDURE CARGAR_CATALOGO;
CREATE PROCEDURE CARGAR_CATALOGO
@fecha DATE, @hora DATE, @sede VARCHAR(50),
@arbitroc VARCHAR(50), @rolc VARCHAR(50),
@arbitro1 VARCHAR(50), @rol1 VARCHAR(50),
@arbitro2 VARCHAR(50), @rol2 VARCHAR(50),
@equipo1 VARCHAR(50), @equipo2 VARCHAR(50)
AS
BEGIN
	EXEC INSERTAR_ARBITRO @arbitroc;
	EXEC INSERTAR_ARBITRO @arbitro1;
	EXEC INSERTAR_ARBITRO @arbitro2;
	EXEC INSERTAR_CIUDAD @sede;

	BEGIN TRY
	EXEC INSERTAR_EQUIPO @equipo1, NULL;
	END TRY
	BEGIN CATCH
	END CATCH;

	BEGIN TRY
	EXEC INSERTAR_EQUIPO @equipo2, NULL;
	END TRY
	BEGIN CATCH
	END CATCH;

	EXEC INSERTAR_PARTIDO @fecha, @hora, NULL, NULL, @equipo1, @equipo2, @sede;
	EXEC ASIGNAR_ARBITRO_PARTIDO @arbitroc, @rolc, @equipo1, @equipo2, @fecha, @hora;
	EXEC ASIGNAR_ARBITRO_PARTIDO @arbitro1, @rol1, @equipo1, @equipo2, @fecha, @hora;
	EXEC ASIGNAR_ARBITRO_PARTIDO @arbitro2, @rol2, @equipo1, @equipo2, @fecha, @hora;
END;

CREATE PROCEDURE ASIGNAR_ARBITRO_PARTIDO
@arbitro VARCHAR(50), @tipo_arbitro VARCHAR(50),
@equipo1 VARCHAR(50), @equipo2 VARCHAR(50),
@fecha DATE, @hora DATE
AS
BEGIN
	DECLARE @carbitro AS INTEGER = (SELECT codarbitro FROM ARBITRO WHERE nombre = @arbitro and nombre IS NOT NULL);
	DECLARE @cequipo1 AS INTEGER = (SELECT codequipo FROM EQUIPO WHERE nombre = @equipo1 and nombre IS NOT NULL);
	DECLARE @cequipo2 AS INTEGER = (SELECT codequipo FROM EQUIPO WHERE nombre = @equipo2 and nombre IS NOT NULL);
	BEGIN TRY
	INSERT INTO ASIGNACION_ARBITRO (ARBITRO_codarbitro, tipo_arbitro, PARTIDO_EQUIPO_codequipo2, PARTIDO_EQUIPO_codequipo1, PARTIDO_fecha, PARTIDO_hora)
	VALUES (@carbitro, @tipo_arbitro, @cequipo2, @cequipo1, @fecha, @hora);
	END TRY
	BEGIN CATCH
	END CATCH;
END;

DROP PROCEDURE INSERTAR_PARTIDO;
CREATE PROCEDURE INSERTAR_PARTIDO
@fecha DATE, @hora DATE, @marcador1 INTEGER,
@marcador2 INTEGER, @equipo1 VARCHAR(50),
@equipo2 VARCHAR(50), @sede VARCHAR(50)
AS
BEGIN
	/*DECLARACIONES*/
	DECLARE @cequipo1 AS INTEGER = (SELECT codequipo FROM EQUIPO WHERE nombre = @equipo1 and nombre IS NOT NULL);
	DECLARE @cequipo2 AS INTEGER = (SELECT codequipo FROM EQUIPO WHERE nombre = @equipo2 and nombre IS NOT NULL);
	DECLARE @csede AS INTEGER = (SELECT codciudad FROM CIUDAD WHERE nombre = @sede and nombre IS NOT NULL);
	BEGIN TRY
	INSERT INTO PARTIDO (fecha, hora, marcador1, marcador2, EQUIPO_codequipo1, EQUIPO_codequipo2, CIUDAD_codciudad, puntos)
	VALUES (@fecha, @hora, @marcador1, @marcador2, @cequipo1, @cequipo2, @csede, 0);
	END TRY
	BEGIN CATCH
	END CATCH;
END;

CREATE PROCEDURE MODIFICAR_MARCADORES_REALES
@fecha DATE, @hora DATE,
@marcador1 INTEGER, @marcador2 INTEGER,
@equipo1 VARCHAR(50), @equipo2 VARCHAR(50)
AS
BEGIN
	DECLARE @cequipo1 AS INTEGER = (SELECT codequipo FROM EQUIPO WHERE nombre = @equipo1 and nombre IS NOT NULL);
	DECLARE @cequipo2 AS INTEGER = (SELECT codequipo FROM EQUIPO WHERE nombre = @equipo2 and nombre IS NOT NULL);
	UPDATE PARTIDO
	SET marcador1 = @marcador1,
	marcador2 = @marcador2
	WHERE fecha = @fecha
	AND hora = @hora
	AND EQUIPO_codequipo1 = @cequipo1
	AND EQUIPO_codequipo2 = @cequipo2;
END;

CREATE PROCEDURE REINICIAR
AS
BEGIN
	UPDATE ASIGNACION_GRUPO
	SET puntos = 0;
END;

CREATE PROCEDURE INSERTAR_PRONOSTICO
@fecha DATE, @hora DATE,
@usuario VARCHAR(50),
@marcador1 INTEGER, @marcador2 INTEGER,
@equipo1 VARCHAR(50), @equipo2 VARCHAR(50)
AS
BEGIN
	DECLARE @cequipo1 AS INTEGER = (SELECT codequipo FROM EQUIPO WHERE nombre = @equipo1 and nombre IS NOT NULL);
	DECLARE @cequipo2 AS INTEGER = (SELECT codequipo FROM EQUIPO WHERE nombre = @equipo2 and nombre IS NOT NULL);
	BEGIN TRY
	INSERT INTO PRONOSTICO (fecha, hora, USUARIO_nombre, EQUIPO_codequipo1, EQUIPO_codequipo2, marcador1, marcador2, apuesta, puntos)
	VALUES (@fecha, @hora, @usuario, @cequipo1, @cequipo2, @marcador1, @marcador2, 0.0, 0);
	END TRY
	BEGIN CATCH
	END CATCH;
END;

CREATE PROCEDURE INSERTAR_GRUPO
@nombre VARCHAR(50)
AS
BEGIN
	BEGIN TRY
	INSERT INTO GRUPO( nombre ) VALUES ( @nombre );
	END TRY
	BEGIN CATCH
	PRINT @nombre + ' ya existe en la tabla GRUPO';
	END CATCH;
END;

CREATE PROCEDURE INSERTAR_USUARIO
@nombre VARCHAR(50), @apellido VARCHAR(50), 
@edad INTEGER, @monto_pagado BIT, 
@rol VARCHAR(50), @pais VARCHAR(50)
AS
BEGIN
	/*VARIABLES DECLARADAS*/
		DECLARE @epais AS INTEGER;
		DECLARE @enombre AS INTEGER = (SELECT nombre FROM USUARIO WHERE nombre = @nombre);
		DECLARE @nnombre AS VARCHAR(50);
	/*EN CASO DE QUE EXISTA SE LE AGREGA EL NOMBRE + APELLIDO + EDAD
	YA QUE ES UNIQUE*/
		IF @enombre IS NULL BEGIN SET @nnombre = @nombre; END;
		ELSE BEGIN SET @nnombre = (@nombre+@apellido+@edad); END;
	/*LLAMAR A PROCEDIMIENTO INSERTAR_PAIS SI NO EXISTE LO CREARA*/
		EXEC INSERTAR_PAIS @pais;
	/*BUSCAR EL CODIGO DEL PAIS*/
		SET @epais = ( SELECT codpais FROM PAIS WHERE nombre = @pais);
	/*INSERTAR UN NUEVO PARTICIPANTE*/
		INSERT INTO USUARIO ( nombre, apellido, edad, monto_pagado, puntos, rol, PAIS_codpais )
		VALUES ( @nnombre, @apellido, @edad, @monto_pagado, 0, @rol, @epais );
END;

CREATE PROCEDURE INSERTAR_EQUIPO
@equipo VARCHAR(50), @confederacion VARCHAR(50)
AS
BEGIN
	/*DECLARACIONES*/
		DECLARE @econf AS INTEGER = NULL;
	/*INSERTANDO PAIS Y CONFEDERACION*/
		IF @confederacion IS NOT NULL BEGIN EXEC INSERTAR_CONFEDERACION @confederacion; END;
	/*BUSCANDO CODIGO PAIS Y CONFEDERACION*/
		IF @confederacion IS NOT NULL
		BEGIN SET @econf = ( SELECT codconfederacion FROM CONFEDERACION WHERE nombre = @confederacion ); END;
	/*INSERTANDO UN EQUIPO*/
		INSERT INTO EQUIPO ( nombre, CONF_codconf ) VALUES ( @equipo, @econf );
END;

drop procedure INSERTAR_JUGADOR
CREATE PROCEDURE INSERTAR_JUGADOR
@nocamisola INTEGER, @posicion VARCHAR(5),
@nombre VARCHAR(50), @fecha DATE, 
@estatura NUMERIC(10,2), @peso NUMERIC(10,2), 
@goles INTEGER , @equipo VARCHAR(50)
AS
BEGIN
	/*DECLARACIONES*/
		DECLARE @eequipo AS INTEGER;
	/*EN CASO DE EL EQUIPO NO EXISTE INSERTAR*/
		BEGIN TRY EXEC INSERTAR_EQUIPO @equipo, NULL;
		END TRY
		BEGIN CATCH
		END CATCH;
	/*BUSCANDO LA SELECCION DONDE PERTENECE*/
		SET @eequipo = ( SELECT codequipo FROM EQUIPO WHERE nombre = @equipo );
	/*INSERTANDO JUGADOR*/
		INSERT INTO JUGADOR ( nocamisola, posicion, nombre, fecha_nac, estatura, peso, goles, EQUIPO_codequipo )
		VALUES ( @nocamisola, @posicion, @nombre, @fecha, @estatura, @peso, @goles, @eequipo );
END;

CREATE PROCEDURE INSERTAR_JUGADOR_CARGA
@nocamisola INTEGER, @posicion VARCHAR(5),
@nombre VARCHAR(50), @fecha DATE, 
@estatura NUMERIC(10,2), @peso NUMERIC(10,2), 
@goles INTEGER , @equipo VARCHAR(50)
AS
BEGIN
	/*DECLARACIONES*/
		DECLARE @eequipo AS INTEGER;
	/*EN CASO DE EL EQUIPO NO EXISTE INSERTAR*/
		BEGIN TRY EXEC INSERTAR_EQUIPO @equipo, NULL;
		END TRY
		BEGIN CATCH
		END CATCH;
	/*BUSCANDO LA SELECCION DONDE PERTENECE*/
		SET @eequipo = ( SELECT codequipo FROM EQUIPO WHERE nombre = @equipo );
	/*INSERTANDO JUGADOR*/
	BEGIN TRY
		INSERT INTO JUGADOR ( nocamisola, posicion, nombre, fecha_nac, estatura, peso, goles, EQUIPO_codequipo )
		VALUES ( @nocamisola, @posicion, @nombre, @fecha, @estatura, @peso, @goles, @eequipo );
	END TRY
	BEGIN CATCH
	END CATCH;
END;

CREATE PROCEDURE ASIGNAR_GRUPO
@equipo VARCHAR(50), @grupo VARCHAR(50)
AS
BEGIN
	/*DECLARACIONES*/
		DECLARE @eequipo AS INTEGER;
		DECLARE @egrupo AS INTEGER;
	/*BUSCAR EQUIPO Y GRUPO*/
		SET @eequipo = ( SELECT codequipo FROM EQUIPO WHERE nombre = @equipo );
		SET @egrupo = ( SELECT codgrupo FROM GRUPO WHERE nombre = @grupo );
	/*REALIZANDO LA ASIGNACION*/
		INSERT INTO ASIGNACION_GRUPO ( puntos, EQUIPO_codequipo, GRUPO_codgrupo )
		VALUES ( 0, @eequipo, @egrupo );
END;

DROP PROCEDURE CARGAR_EQUIPOS

CREATE PROCEDURE CARGAR_EQUIPOS
@equipo VARCHAR(50), @confede VARCHAR(50),
@grupo VARCHAR(50)
AS
BEGIN
	EXEC INSERTAR_CONFEDERACION @confede;
	BEGIN TRY 
	EXEC INSERTAR_EQUIPO @equipo, @confede;
	END TRY
	BEGIN CATCH END CATCH;

	DECLARE @codconfede AS INT = (SELECT codconfederacion FROM CONFEDERACION WHERE nombre = @confede);
	UPDATE EQUIPO SET CONF_codconf = @codconfede WHERE nombre = @equipo;

	BEGIN TRY 
	EXEC INSERTAR_GRUPO @grupo;
	END TRY
	BEGIN CATCH END CATCH;
	BEGIN TRY 
	EXEC ASIGNAR_GRUPO @equipo, @grupo;
	END TRY
	BEGIN CATCH END CATCH;
END;

CREATE PROCEDURE ELIMINAR_EQUIPO
@equipo VARCHAR(50)
AS
BEGIN
	DELETE FROM EQUIPO WHERE nombre = @equipo;
END;


CREATE PROCEDURE ELIMINAR_ASIGNACION_GRUPO
@equipo VARCHAR(50), @grupo VARCHAR(50)
AS
BEGIN
	DECLARE @cequipo AS INTEGER = (SELECT codequipo FROM EQUIPO WHERE nombre = @equipo);
	DECLARE @cgrupo AS INTEGER = (SELECT codgrupo FROM GRUPO WHERE nombre = @grupo);
	DELETE FROM ASIGNACION_GRUPO WHERE EQUIPO_codequipo = @cequipo and GRUPO_codgrupo = @cgrupo;
END;

CREATE PROCEDURE MODIFICAR_EQUIPO
@codequipo INTEGER, @equipo VARCHAR(50),
@confede VARCHAR(50)
AS
BEGIN
	EXEC INSERTAR_CONFEDERACION @confede;
	DECLARE @ncodigo_confede INTEGER = (SELECT codconfederacion FROM CONFEDERACION WHERE nombre = @confede);
	UPDATE EQUIPO 
	SET nombre = @equipo, CONF_codconf = @ncodigo_confede
	WHERE codequipo = @codequipo;
	--Tirara error si no existe la confederacion
END;

CREATE FUNCTION OBTENER_CODIGO_EQUIPO
(@equipo VARCHAR(50))
RETURNS INTEGER
AS
BEGIN
	DECLARE @cod_equipo AS INTEGER = (SELECT codequipo FROM EQUIPO WHERE nombre = @equipo);
	RETURN @cod_equipo;
END;

DROP FUNCTION OBTENER_CODIGO_EQUIPO

CREATE FUNCTION LOGUEAR
(@nombre VARCHAR(50), @rol VARCHAR(50))
RETURNS BIT
AS
BEGIN
	/*DECLARACIONES*/
	DECLARE @euser AS VARCHAR(50) = 
		( SELECT nombre FROM USUARIO WHERE nombre = @nombre and rol = @rol );
	IF @euser IS NULL BEGIN RETURN 0; END;
	RETURN 1;
END;

-- VISTAS
CREATE VIEW CONFEDE_Y_EQUIPOS
AS
SELECT c.nombre as Confederacion, e.nombre as Equipo FROM EQUIPO e
LEFT JOIN CONFEDERACION c ON e.CONF_codconf = c.codconfederacion;

CREATE VIEW VISTA_CONFEDERACION
AS
SELECT nombre FROM CONFEDERACION;

CREATE VIEW VISTA_EQUIPOS
AS
SELECT nombre FROM EQUIPO;

USE dbp2;
DROP TRIGGER MAX_EQUIPO_GRUPO
-- TRIGGERS
DROP TRIGGER GRUPO_PUNTOS
CREATE TRIGGER GRUPO_PUNTOS
ON PARTIDO
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	/*DECLARACIONES DE MARCADORES DE LOS EQUIPOS*/
	DECLARE @marcador1 AS INTEGER, @marcador2 AS INTEGER;
	/*DECLARACIONES DE CODIGOS DE LOS EQUIPOS*/
	DECLARE @eq1 AS INTEGER, @eq2 AS INTEGER;
	/*SELECCIONANDO LOS EQUIPOS*/
	SELECT @eq1=ins.EQUIPO_codequipo1 FROM inserted ins;
	SELECT @eq2=ins.EQUIPO_codequipo2 FROM inserted ins;
	/*DECLARACIONES DE LOS GANADOR ENTRE LOS EQUIPOS*/
	DECLARE @win_eq1 AS BIT = 0, @win_eq2 AS BIT = 0;
	/*SELECCIONANDO LOS MARCADORES*/
	SELECT @marcador1=ins.marcador1 FROM inserted ins;
	SELECT @marcador2=ins.marcador2 FROM inserted ins;
	/*VERIFICANDO EL GANADOR, EMPATE Y PERDEDOR*/
	IF @marcador1 IS NOT NULL AND @marcador2 IS NOT NULL
	BEGIN
		IF @marcador1 > @marcador2 BEGIN SET @win_eq1 = 1; END;
		ELSE IF @marcador1 < @marcador2 BEGIN SET @win_eq2 = 1; END;
		IF @win_eq1 = 1 AND @win_eq2 = 0 
		BEGIN 
		UPDATE ASIGNACION_GRUPO SET
		puntos = puntos+3
		WHERE EQUIPO_codequipo = @eq1;
		END;
		ELSE IF @win_eq1 = 0 AND @win_eq2 = 1
		BEGIN
		UPDATE ASIGNACION_GRUPO SET
		puntos = puntos+3
		WHERE EQUIPO_codequipo = @eq2;
		END;
		ELSE IF @win_eq1 = 0 AND @win_eq2 = 0
		BEGIN
		UPDATE ASIGNACION_GRUPO SET
		puntos = puntos+1
		WHERE EQUIPO_codequipo = @eq1;
		UPDATE ASIGNACION_GRUPO SET
		puntos = puntos+1
		WHERE EQUIPO_codequipo = @eq2;
		END;
	END;
END;

CREATE TRIGGER MAX_EQUIPO_GRUPO
ON ASIGNACION_GRUPO
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @no_equipo AS INT = 0;
	DECLARE @no_caracter AS INT = 0;
	DECLARE @eequipo AS INT = 0;
	DECLARE @nequipo AS VARCHAR(50);
	SET @no_equipo = (
		SELECT COUNT(asig.GRUPO_codgrupo) FROM ASIGNACION_GRUPO asig, inserted ins
		WHERE asig.GRUPO_codgrupo = ins.GRUPO_codgrupo
		GROUP BY asig.GRUPO_codgrupo
	);

	SET @no_caracter = ( SELECT LEN(g.nombre) FROM inserted ins, GRUPO g WHERE ins.GRUPO_codgrupo = g.codgrupo );

	/*CUANDO EL NUMERO DE CARACTER ES 1 VERIFICAR QUE LOS GRUPOS NO HAYA MAS DE 4 EQUIPOS*/
	IF @no_caracter = 1
	BEGIN
		IF @no_equipo > 4
		BEGIN
			/*SI HAY MAS ENTONCES ELIMINAR EL ULTIMO DATO QUE SE INGRESO*/
			DELETE FROM ASIGNACION_GRUPO
			WHERE GRUPO_codgrupo = ( SELECT GRUPO_codgrupo FROM inserted )
			and EQUIPO_codequipo = ( SELECT EQUIPO_codequipo FROM inserted );
		END;
	END;
	/*EN CASO DE QUE ES MAS DE UN CARACTER
	DEJAR QUE INSERTE EL DATO DEBIDO A QUE EL
	GRUPO PODRIA SER OCTAVOS, CUARTOS, SEMI, FINAL*/
END;

CREATE VIEW VISTA_GRUPO
AS
SELECT nombre  FROM GRUPO;


SELECT * FROM ASIGNACION_GRUPO;
DELETE FROM ASIGNACION_GRUPO;

drop function EQUIPOS_POR_GRUPO

CREATE FUNCTION EQUIPOS_POR_GRUPO
(@equipo VARCHAR(50))
RETURNS TABLE
AS RETURN (
	SELECT e.nombre FROM ASIGNACION_GRUPO ag
	INNER JOIN EQUIPO e ON ag.EQUIPO_codequipo = e.codequipo
	INNER JOIN GRUPO g ON ag.GRUPO_codgrupo = g.codgrupo
	WHERE g.nombre = @equipo
);

drop function JUGADORES_POR_EQUIPO_ID
CREATE FUNCTION JUGADORES_POR_EQUIPO
(@equipo VARCHAR(50))
RETURNS TABLE
AS RETURN (
	SELECT 
	j.nocamisola as NoCamisola,
	j.nombre as Nombre,
	j.fecha_nac as Fecha_Nac,
	j.estatura as Estatura,
	j.peso as Peso,
	j.goles as Goles
	FROM JUGADOR j
	INNER JOIN EQUIPO e ON j.EQUIPO_codequipo = e.codequipo
	WHERE e.nombre = @equipo
);

CREATE FUNCTION JUGADORES_POR_EQUIPO_ID
(@equipo VARCHAR(50))
RETURNS TABLE
AS RETURN (
	SELECT 
	j.nocamisola
	FROM JUGADOR j
	INNER JOIN EQUIPO e ON j.EQUIPO_codequipo = e.codequipo
	WHERE e.nombre = @equipo
);

SELECT nombre as Equipo FROM dbo.EQUIPOS_POR_GRUPO('A');

EXEC ELIMINAR_ASIGNACION_GRUPO 'Francia', 'A';

SELECT * FROM dbo.JUGADORES_POR_EQUIPO_ID('Francia')

EXEC INSERTAR_JUGADOR 1, 'GK', 'nombre', '', 12.32, 12.32, 10, 'Argentina';

DELETE FROM PARTIDO;
DELETE FROM ASIGNACION_ARBITRO;
DELETE FROM ARBITRO;
DELETE FROM JUGADOR;
DELETE FROM ASIGNACION_GRUPO;
DELETE FROM CIUDAD;
delete from PRONOSTICO;
delete from EQUIPO;
delete from GRUPO;
delete from CONFEDERACION;
delete from USUARIO WHERE nombre != 'admin123';

DBCC CHECKIDENT (ARBITRO, RESEED,0);
DBCC CHECKIDENT (CIUDAD, RESEED,0);
DBCC CHECKIDENT (CONFEDERACION, RESEED,0);
DBCC CHECKIDENT (EQUIPO, RESEED,0);
DBCC CHECKIDENT (GRUPO, RESEED,0);
DBCC CHECKIDENT (PAIS, RESEED,0);

select * from CONFEDERACION;
select * from GRUPO;
select * from EQUIPO;
select * from JUGADOR;
select * from USUARIO;

select * from PARTIDO
select * from ASIGNACION_ARBITRO;
select * from ARBITRO
select * from PRONOSTICO;

SELECT * FROM ASIGNACION_GRUPO;

SELECT * FROM CONFEDE_Y_EQUIPOS


--RESULTADOS DE UN EQUIPO DADO
DROP FUNCTION VISTA_RESULTADO_EQUIPO;
CREATE FUNCTION VISTA_RESULTADO_EQUIPO
(@equipo VARCHAR(50))
RETURNS TABLE
AS RETURN (
	SELECT e1.nombre as Local, p.marcador1 as '->', p.marcador2 as '<-', e2.nombre as Visita, 
	CONVERT(varchar, p.fecha, 103) as Fecha, CONVERT(varchar, p.hora, 108) as Hora
	FROM PARTIDO p
	INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
	INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
	WHERE (e1.nombre = @equipo OR e2.nombre = @equipo)
	AND (marcador1 IS NOT NULL and marcador2 IS NOT NULL)
);

SELECT * FROM dbo.VISTA_RESULTADO_EQUIPO('Uruguay');

SELECT e1.nombre as Local, 'vs' as vs, e2.nombre as Visita, 
CONVERT(varchar, p.fecha, 103) as Fecha, CONVERT(varchar, p.hora, 108) as Hora
FROM PARTIDO p
INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
INNER JOIN ASIGNACION_GRUPO ag ON e1.codequipo = ag.EQUIPO_codequipo
INNER JOIN GRUPO g ON ag.GRUPO_codgrupo = g.codgrupo
WHERE (marcador1 IS NULL and marcador2 IS NULL) and
g.nombre = 'B'
ORDER BY p.fecha;

EXEC REINICIAR;

	SELECT SUM(p.marcador1)+(
		SELECT SUM(p.marcador2)
		FROM PARTIDO P
		INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
		INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
		WHERE e2.nombre = 'Saudi Arabia'
		AND (marcador1 IS NOT NULL and marcador2 IS NOT NULL)
		GROUP BY e2.codequipo
	)
	FROM PARTIDO P
	INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
	INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
	WHERE e1.nombre = 'Saudi Arabia'
	AND (marcador1 IS NOT NULL and marcador2 IS NOT NULL)
	GROUP BY e1.codequipo;


	SELECT SUM(p.marcador1) OVER (PARTITION BY e1.codequipo),
	SUM(p.marcador2) OVER (PARTITION BY e2.codequipo),
	e1.nombre, p.marcador1, p.marcador2, e2.nombre
	FROM PARTIDO P
	INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
	INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
	WHERE p.marcador1 IS NOT NULL AND p.marcador2 IS NOT NULL
	AND (e1.nombre = 'Uruguay' OR e2.nombre = 'Uruguay');


--VISTA DE EQUIPOS POR GRUPO
	SELECT e.nombre as Equipo,
	(
		SELECT COUNT(*)
		FROM PARTIDO p
		INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
		INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
		INNER JOIN CIUDAD c ON p.CIUDAD_codciudad = c.codciudad
		WHERE (e1.codequipo = e.codequipo OR e2.codequipo = e.codequipo)
		AND (marcador1 IS NOT NULL and marcador2 IS NOT NULL)
	) as PJ,
	(
		SELECT COUNT(*)
		FROM PARTIDO P
		INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
		INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
		WHERE (e1.codequipo = e.codequipo AND p.marcador1 > p.marcador2)
		OR (e2.codequipo = e.codequipo AND p.marcador2 > p.marcador1)
		AND (marcador1 IS NOT NULL and marcador2 IS NOT NULL)
	) as G,
	(
		SELECT COUNT(*)
		FROM PARTIDO P
		INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
		INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
		WHERE (e1.codequipo = e.codequipo OR e2.codequipo = e.codequipo)
		AND p.marcador2 = p.marcador1
		AND (marcador1 IS NOT NULL and marcador2 IS NOT NULL)
	) as E,
	(
		SELECT COUNT(*)
		FROM PARTIDO P
		INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
		INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
		WHERE (e1.codequipo = e.codequipo AND p.marcador1 < p.marcador2)
		OR (e2.codequipo = e.codequipo AND p.marcador2 < p.marcador1)
		AND (marcador1 IS NOT NULL and marcador2 IS NOT NULL)
	) as P,
	ag.puntos as Pts
	FROM ASIGNACION_GRUPO ag
	INNER JOIN EQUIPO e ON ag.EQUIPO_codequipo = e.codequipo
	INNER JOIN GRUPO g ON ag.GRUPO_codgrupo = g.codgrupo
	WHERE g.nombre = 'A'
	ORDER BY puntos DESC;



DROP VIEW LISTA_GOLEADORES;
CREATE VIEW LISTA_GOLEADORES
AS
SELECT TOP 25 ROW_NUMBER() OVER(ORDER BY j.goles DESC) as No, e.nombre as Equipo, j.nocamisola as NoCamisola, j.posicion as Posicion, 
j.nombre as Jugador, j.goles as Goles FROM JUGADOR j
INNER JOIN EQUIPO e ON j.EQUIPO_codequipo = e.codequipo
ORDER BY j.goles DESC;

SELECT * FROM LISTA_GOLEADORES



CREATE PROCEDURE CALCULAR_PUNTOS_PARTICIPANTE
AS
BEGIN
	
END;

DROP PROCEDURE ACTUALIZR_PUNTOS_PRONOSTICO;
CREATE PROCEDURE ACTUALIZR_PUNTOS_PRONOSTICO
AS
BEGIN
	DECLARE @tabla TABLE(id INT, equipo1 INT, equipo2 INT, mar1 INT, mar2 INT);
	INSERT INTO @tabla(id, equipo1, equipo2, mar1, mar2)
	SELECT ROW_NUMBER() OVER (ORDER BY fecha ASC), EQUIPO_codequipo1, EQUIPO_codequipo2, marcador1, marcador2 FROM PRONOSTICO;
	
	/*DECLARANDO VARIABLES*/
	DECLARE @count INT = (SELECT COUNT(*) FROM @tabla);
	DECLARE @estado_pronostico AS VARCHAR(50);
	DECLARE @estado_partido AS VARCHAR(50);
	DECLARE @equ1 AS INT, @equ2 AS INT;
	DECLARE @m1_pro AS INT, @m2_pro AS INT;
	DECLARE @m1_par AS INT, @m2_par AS INT;
	DECLARE @id AS INT;

	WHILE @count > 0
	BEGIN
		SET @id = (SELECT TOP(1) id FROM @tabla ORDER BY id);
		/*OBTENIENDO DATOS DE PRONOSTICOS*/
		SET @equ1 = (SELECT TOP(1) equipo1 FROM @tabla ORDER BY id);
		SET @equ2 = (SELECT TOP(1) equipo2 FROM @tabla ORDER BY id);
		SET @m1_pro = (SELECT TOP(1) mar1 FROM @tabla ORDER BY id);
		SET @m2_pro = (SELECT TOP(1) mar2 FROM @tabla ORDER BY id);
		/*OBTENIENDO DATOS DEL PARTIDO*/
		SET @m1_par = (SELECT marcador1 FROM PARTIDO WHERE EQUIPO_codequipo1 = @equ1 AND EQUIPO_codequipo2 = @equ2);
		SET @m2_par = (SELECT marcador2 FROM PARTIDO WHERE EQUIPO_codequipo1 = @equ1 AND EQUIPO_codequipo2 = @equ2);
		/*MODIFICANDO ESTADOS*/
		IF @m1_par IS NOT NULL AND @m2_par IS NOT NULL
		BEGIN
			IF @m1_par < @m2_par BEGIN SET @estado_partido = 'derrota'; END;
			ELSE IF @m1_par > @m2_par BEGIN SET @estado_partido = 'victoria'; END;
			ELSE IF @m1_par = @m2_par BEGIN SET @estado_partido = 'empate'; END;

			IF @m1_pro < @m2_pro BEGIN SET @estado_pronostico = 'derrota'; END;
			ELSE IF @m1_pro > @m2_pro BEGIN SET @estado_pronostico = 'victoria'; END;
			ELSE IF @m1_pro = @m2_pro BEGIN SET @estado_pronostico = 'empate'; END;

			IF @m1_pro = @m1_par AND @m2_pro = @m2_par 
			BEGIN UPDATE PRONOSTICO SET puntos=3 WHERE EQUIPO_codequipo1 = @equ1 AND EQUIPO_codequipo2 = @equ2 END;
			ELSE
			BEGIN
				IF @estado_partido = @estado_pronostico AND (@estado_partido = 'victoria' OR @estado_partido = 'empate')
				BEGIN UPDATE PRONOSTICO SET puntos=1 WHERE EQUIPO_codequipo1 = @equ1 AND EQUIPO_codequipo2 = @equ2 END;
				ELSE BEGIN UPDATE PRONOSTICO SET puntos=0 WHERE EQUIPO_codequipo1 = @equ1 AND EQUIPO_codequipo2 = @equ2 END;
			END;
		END;
		DELETE @tabla WHERE id = @id;
		SET @count = (SELECT COUNT(*) FROM @tabla);
	END;
END;

EXEC ACTUALIZR_PUNTOS_PRONOSTICO;

SELECT * FROM PRONOSTICO pr
INNER JOIN PARTIDO p ON pr.EQUIPO_codequipo1 = p.EQUIPO_codequipo1
AND pr.EQUIPO_codequipo2 = p.EQUIPO_codequipo2;


SELECT u.nombre as Nombre, SUM(pr.puntos) as Puntos FROM PRONOSTICO pr
INNER JOIN USUARIO u ON pr.USUARIO_nombre = u.nombre
WHERE u.rol = 'participante' AND u.monto_pagado = 1
GROUP BY u.nombre
ORDER BY Puntos DESC;

DROP PROCEDURE ACTUALIZAR_PUNTOS_PARTIDO;
CREATE PROCEDURE ACTUALIZAR_PUNTOS_PARTIDO
AS
BEGIN
	DECLARE @tabla TABLE(id INT, equipo1 INT, equipo2 INT, mar1 INT, mar2 INT);
	INSERT INTO @tabla(id, equipo1, equipo2, mar1, mar2)
	SELECT ROW_NUMBER() OVER (ORDER BY fecha ASC), EQUIPO_codequipo1, EQUIPO_codequipo2, marcador1, marcador2 FROM PARTIDO WHERE marcador1 IS NOT NULL AND marcador2 IS NOT NULL;
	EXEC REINICIAR;
	/*DECLARANDO VARIABLES*/
	DECLARE @count INT = (SELECT COUNT(*) FROM @tabla);
	DECLARE @equ1 AS INT, @equ2 AS INT;
	DECLARE @m1 AS INT, @m2 AS INT;
	DECLARE @id AS INT;
	DECLARE @puntos AS INT = 0;
	WHILE @count > 0
	BEGIN
		SET @id = (SELECT TOP(1) id FROM @tabla ORDER BY id);
		/*OBTENIENDO DATOS DE PRONOSTICOS*/
		SET @equ1 = (SELECT TOP(1) equipo1 FROM @tabla ORDER BY id);
		SET @equ2 = (SELECT TOP(1) equipo2 FROM @tabla ORDER BY id);
		SET @m1 = (SELECT TOP(1) mar1 FROM @tabla ORDER BY id);
		SET @m2 = (SELECT TOP(1) mar2 FROM @tabla ORDER BY id);
		/*MODIFICANDO ESTADOS*/
		IF @m1 IS NOT NULL AND @m2 IS NOT NULL
		BEGIN
			IF @m1 > @m2 
			BEGIN UPDATE ASIGNACION_GRUPO SET puntos=puntos+3 WHERE EQUIPO_codequipo = @equ1; END;
			ELSE IF @m1 = @m2 
			BEGIN
			UPDATE ASIGNACION_GRUPO SET puntos=puntos+1 WHERE EQUIPO_codequipo = @equ1;
			UPDATE ASIGNACION_GRUPO SET puntos=puntos+1 WHERE EQUIPO_codequipo = @equ2;
			END;
			ELSE
			BEGIN UPDATE ASIGNACION_GRUPO SET puntos=puntos+3 WHERE EQUIPO_codequipo = @equ2; END;
		END;
		DELETE @tabla WHERE id = @id;
		SET @count = (SELECT COUNT(*) FROM @tabla);
	END;
END;

EXEC ACTUALIZAR_PUNTOS_PARTIDO;

SELECT * FROM PARTIDO WHERE marcador1 IS NOT NULL AND marcador2 IS NOT NULL;


SELECT e.nombre as Equipo,
	(
		SELECT COUNT(*)
		FROM PARTIDO p
		INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
		INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
		INNER JOIN CIUDAD c ON p.CIUDAD_codciudad = c.codciudad
		WHERE (e1.codequipo = e.codequipo OR e2.codequipo = e.codequipo)
		AND (marcador1 IS NOT NULL and marcador2 IS NOT NULL)
	) as PJ,
	(
		SELECT COUNT(*)
		FROM PARTIDO P
		INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
		INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
		WHERE (e1.codequipo = e.codequipo AND p.marcador1 > p.marcador2)
		OR (e2.codequipo = e.codequipo AND p.marcador2 > p.marcador1)
		AND (marcador1 IS NOT NULL and marcador2 IS NOT NULL)
	) as G,
	(
		SELECT COUNT(*)
		FROM PARTIDO P
		INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
		INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
		WHERE (e1.codequipo = e.codequipo OR e2.codequipo = e.codequipo)
		AND p.marcador2 > p.marcador1
		AND (marcador1 IS NOT NULL and marcador2 IS NOT NULL)
	) as E,
	(
		SELECT COUNT(*)
		FROM PARTIDO P
		INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
		INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
		WHERE (e1.codequipo = e.codequipo AND p.marcador1 < p.marcador2)
		OR (e2.codequipo = e.codequipo AND p.marcador2 < p.marcador1)
		AND (marcador1 IS NOT NULL and marcador2 IS NOT NULL)
	) as P,
	(
		SELECT SUM(p.puntos) FROM PARTIDO p
		INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
		INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
		WHERE (marcador1 IS NOT NULL and marcador2 IS NOT NULL)
		AND p.EQUIPO_codequipo1 = e.codequipo
		GROUP BY p.EQUIPO_codequipo1
	) as Pts
	FROM ASIGNACION_GRUPO ag
	INNER JOIN EQUIPO e ON ag.EQUIPO_codequipo = e.codequipo
	INNER JOIN GRUPO g ON ag.GRUPO_codgrupo = g.codgrupo
	WHERE g.nombre = 'A'
	ORDER BY puntos DESC;


	SELECT e1.codequipo, e1.nombre, SUM(p.puntos) FROM PARTIDO p
	INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
	WHERE (marcador1 IS NOT NULL and marcador2 IS NOT NULL)
	GROUP BY e1.codequipo, e1.nombre;

	SELECT * FROM PARTIDO p
	WHERE p.EQUIPO_codequipo1 = 553 or p.EQUIPO_codequipo2 = 553

	(SELECT nombre as e1 FROM EQUIPO WHERE codequipo = 185)
	UNION
	(SELECT nombre as e2 FROM EQUIPO WHERE codequipo = 530)
	UNION
	(SELECT nombre as e3 FROM EQUIPO WHERE codequipo = 714)
	UNION
	(SELECT nombre as e3 FROM EQUIPO WHERE codequipo = 553)



	select e1.nombre, p.marcador1, p.marcador2, e2.nombre,
	pa.marcador1, pa.marcador2, p.puntos
	from PRONOSTICO p
	inner join USUARIO u on p.USUARIO_nombre = u.nombre
	inner join EQUIPO e1 on p.EQUIPO_codequipo1 = e1.codequipo
	inner join EQUIPO e2 on p.EQUIPO_codequipo2 = e2.codequipo
	inner join PARTIDO pa on (pa.EQUIPO_codequipo1 = e1.codequipo
	and pa.EQUIPO_codequipo2 = e2.codequipo)
	WHERE u.monto_pagado = 1
	and p.puntos > 0;

SELECT * FROM LISTA_GOLEADORES;
SELECT * FROM USUARIO;









SELECT u.nombre as Nombre, SUM(pr.puntos) as Puntos FROM PRONOSTICO pr
INNER JOIN USUARIO u ON pr.USUARIO_nombre = u.nombre
WHERE u.rol = 'participante' AND u.monto_pagado = 1
GROUP BY u.nombre
ORDER BY Puntos DESC;

SELECT u.nombre as Nombre FROM PRONOSTICO pr
INNER JOIN USUARIO u ON pr.USUARIO_nombre = u.nombre

SELECT * FROM PRONOSTICO;
USE dbp2


SELECT NoCamisola FROM JUGADORES_POR_EQUIPO('Spain');

DECLARE @tabla TABLE(nocamisola INT, equipo1 INT);
INSERT INTO @tabla(nocamisola, equipo1)
(SELECT j.nocamisola, j.EQUIPO_codequipo FROM JUGADOR j INNER JOIN EQUIPO e ON j.EQUIPO_codequipo = e.codequipo WHERE e.nombre = 'Spain');


CREATE PROCEDURE AUMENTADO_GOLES
@equipo VARCHAR(50), @nocamisola INTEGER
AS
BEGIN
	DECLARE @cequipo AS INT = (SELECT codequipo FROM EQUIPO WHERE nombre = @equipo);
	UPDATE JUGADOR
	SET goles=goles+1
	WHERE nocamisola = @nocamisola
	AND EQUIPO_codequipo = @cequipo;
END;


DROP VIEW VISTA_PARTIDO_EQUIPOS
CREATE VIEW VISTA_PARTIDO_EQUIPOS
AS
SELECT (e1.nombre+'  vs  '+e2.nombre) as partido FROM PARTIDO p
INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo;

DROP PROCEDURE MODIFICAR_MARCADOR_REAL
CREATE PROCEDURE MODIFICAR_MARCADOR_REAL
@equipo1 VARCHAR(50), @equipo2 VARCHAR(50),
@mar1 INT, @mar2 INT
AS
BEGIN
	DECLARE @ce1 AS INT = (SELECT codequipo FROM EQUIPO WHERE nombre = @equipo1);
	DECLARE @ce2 AS INT = (SELECT codequipo FROM EQUIPO WHERE nombre = @equipo2);
	UPDATE PARTIDO
	SET marcador1 = @mar1,
	marcador2 = @mar2
	WHERE EQUIPO_codequipo1 = @ce1
	AND EQUIPO_codequipo2 = @ce2;
	EXEC ACTUALIZR_PUNTOS_PRONOSTICO;
END;

SELECT * FROM VISTA_PARTIDO_EQUIPOS;


SELECT e1.nombre, p.marcador1, p.marcador2, e2.nombre FROM PARTIDO p
INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo;




SELECT e.nombre as Equipo, (SUM(p.puntos)+(
SELECT SUM(p1.puntos) FROM PRONOSTICO p1
INNER JOIN EQUIPO e1 ON p1.EQUIPO_codequipo2 = e1.codequipo
WHERE e.nombre = e1.nombre
GROUP BY e1.nombre
)) as Puntos FROM PRONOSTICO p
INNER JOIN EQUIPO e ON p.EQUIPO_codequipo1 = e.codequipo
GROUP BY e.nombre
ORDER BY Puntos DESC;


SELECT * FROM PARTIDO p
INNER JOIN EQUIPO e ON p.EQUIPO_codequipo1 = e.codequipo
WHERE ;


SELECT e1.nombre, p.marcador1, p.marcador2, e2.nombre, pa.marcador1, pa.marcador2, p.puntos FROM PRONOSTICO p
INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
INNER JOIN PARTIDO pa ON p.EQUIPO_codequipo1 = pa.EQUIPO_codequipo1 and p.EQUIPO_codequipo2 = pa.EQUIPO_codequipo2;


SELECT e1.nombre, p.marcador1, p.marcador2, e2.nombre, pa.marcador1, pa.marcador2, p.puntos FROM PRONOSTICO p
INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo
INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo
INNER JOIN PARTIDO pa ON p.EQUIPO_codequipo1 = pa.EQUIPO_codequipo1 and p.EQUIPO_codequipo2 = pa.EQUIPO_codequipo2
INNER JOIN ASIGNACION_GRUPO ag ON e1.codequipo = ag.EQUIPO_codequipo
INNER JOIN GRUPO g ON ag.GRUPO_codgrupo = g.codgrupo
WHERE g.nombre = 'F';