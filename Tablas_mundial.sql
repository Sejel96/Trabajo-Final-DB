CREATE DATABASE Mundial2022
USE Mundial2022

-- ADMINISTRADOR:

-- TABLAS:
---------------------------------
-- tabla sedes
CREATE TABLE sedes(
id_sede INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre VARCHAR(50),
ciudad VARCHAR(50),
capacidad INT (20)
);
---------------------------------
-- tabla equipos
CREATE TABLE equipos (
id_equipo INT PRIMARY KEY AUTO_INCREMENT NOT NULL ,
nombre VARCHAR(50),
continente VARCHAR(50),
federacion VARCHAR(50),
grupo  CHAR(1) CHECK (grupo IN('A','B','C','D','E','F','G','H'))
);
---------------------------------
-- tabla jugadores
CREATE TABLE jugadores (
	id_jugador INT PRIMARY KEY AUTO_INCREMENT NOT NULL ,
	id_equipo INT ,
	apellidos VARCHAR (50),
	nombres VARCHAR (50),
	edad INT(2),
	numero_camiseta INT CHECK(numero_camiseta <100),
	posicion VARCHAR (20),
	club_actual VARCHAR (50),
	FOREIGN KEY (id_equipo) REFERENCES equipos(id_equipo)
	);
------------------------------------
-- tabla fechas
CREATE TABLE fechas (
id_fecha INT PRIMARY KEY AUTO_INCREMENT NOT NULL ,
id_local INT ,
id_visitante INT,
id_sede INT,
fecha_hora TIMESTAMP CHECK (fecha_hora BETWEEN '2022-11-21 13:00:00' AND '2022-12-18 18:00:00'),
goles_local INT,
goles_visita INT,
puntos_local INT CHECK (puntos_local <= 3 AND puntos_local != 2),
puntos_visita INT CHECK (puntos_local <= 3 AND puntos_local != 2),
FOREIGN KEY (id_local) REFERENCES equipos(id_equipo),
FOREIGN KEY (id_visitante) REFERENCES equipos(id_equipo),
FOREIGN KEY (id_sede) REFERENCES sedes(id_sede)
)
-----------------------------------

-- PROCEDIMIENTOS ALMACENADOS CON CRUD:

-- PROCEDIMIENTOS DE AGREGAR REGISTROS EN LAS TABLAS

delimiter $
CREATE PROCEDURE sp_agregar_sedes(IN nom VARCHAR(50),IN ciu VARCHAR(50) ,IN cap INT (20))
BEGIN
	INSERT INTO sedes(nombre,ciudad,capacidad)
	VALUES (nom,ciu,cap);
END $
-----------------------------------
delimiter $
CREATE PROCEDURE sp_agregar_equipos(IN nom VARCHAR(50),IN con VARCHAR(50),IN fed VARCHAR(50),
IN gru CHAR (1))
BEGIN 
	INSERT INTO equipos(nombre,continente,federacion,grupo)
	VALUES (nom,con,fed,gru);
END $
-----------------------------------
delimiter $
CREATE PROCEDURE sp_agregar_jugadores(IN equi INT,IN ape VARCHAR(50),IN nom VARCHAR(50),
IN ed INT(2),IN nc INT,IN pos VARCHAR(20),IN club VARCHAR(50))
BEGIN
	INSERT INTO jugadores(id_equipo,apellidos,nombres,edad,numero_camiseta,posicion,club_actual)
	VALUES (equi,ape,nom,ed,nc,pos,club);
END $
-----------------------------------
delimiter $
CREATE PROCEDURE sp_agregar_fechas(IN loc INT,IN vis INT,IN sed INT,
IN 	fh TIMESTAMP, IN gl INT, IN gv INT,IN pl INT,IN pv INT)
BEGIN
	INSERT INTO fechas(id_local,id_visitante,id_sede,fecha_hora,goles_local,
		goles_visita,puntos_local,puntos_visita)
	VALUES (loc,vis,sed,fh,gl,gv,pl,pv);
END $
-----------------------------------

-- PROCEDIMIENTOS DE ACTUALIZAR REGISTROS EN LAS TABLAS
delimiter $
CREATE PROCEDURE sp_actualizar_sedes(IN nom VARCHAR(50),IN ciu VARCHAR(50) ,
	IN cap INT (20),IN id INT)
BEGIN
	UPDATE sedes
	SET nombre = nom, ciudad = ciu, capacidad = cap 
	WHERE id_sede = id;
END $
-----------------------------------

delimiter $
CREATE PROCEDURE sp_actualizar_equipos(IN nom VARCHAR(50),IN con VARCHAR(50),IN fed VARCHAR(50),
	IN gru CHAR (1),IN id INT)
BEGIN
	UPDATE equipos
	SET nombre = nom, continente = con, federacion = fed, grupo = gru
	WHERE id_equipo = id;
END $
-----------------------------------
delimiter $
CREATE PROCEDURE sp_actualizar_jugadores(IN equi INT,IN ape VARCHAR(50),IN nom VARCHAR(50),
	IN ed INT(2),IN nc INT,IN pos VARCHAR(20),IN club VARCHAR(50), IN id INT)
BEGIN
	UPDATE jugadores
	SET id_equipo = equi, apellidos = ape, nombres = nom, edad = ed, numero_camiseta = nc,
	posicion = pos, club_actual = club
	WHERE id_jugador = id;
END $
-------------------------------------
delimiter $
CREATE PROCEDURE sp_actualizar_fechas(IN loc INT,IN vis INT,IN sed INT,
IN 	fh TIMESTAMP, IN gl INT, IN gv INT,IN pl INT,IN pv INT, IN id INT )
BEGIN
	UPDATE fechas
	SET id_local = loc, id_visitante = vis, id_sede = sed, fecha_hora = fh,
	goles_local = gl, goles_visita = gv, puntos_local = pl, puntos_visita = pv
	WHERE id_fecha = id;
END $
-------------------------------------

-- PROCEDIMIENTOS DE ELIMINAR REGISTROS EN LAS TABLAS:

delimiter $
CREATE PROCEDURE sp_eliminar_sedes(IN id INT)
BEGIN
	DELETE FROM sedes
	WHERE id_sede = id;
END $
-------------------------------------
delimiter $
CREATE PROCEDURE sp_eliminar_equipos(IN id INT)
BEGIN
	DELETE FROM equipos
	WHERE id_equipo = id;
END $
-------------------------------------
delimiter $
CREATE PROCEDURE sp_eliminar_jugadores(IN id INT)
BEGIN
	DELETE FROM jugadores
	WHERE id_jugador = id;
END $
-------------------------------------
delimiter $
CREATE PROCEDURE sp_eliminar_fechas(IN id INT)
BEGIN
	DELETE FROM fechas
	WHERE id_fecha = id;
END $
-------------------------------------

-- PROCEDIMIENTOS DE MOSTRAR REGISTROS EN LAS TABLAS:
delimiter $
CREATE PROCEDURE sp_mostrar_sedes()
BEGIN
	SELECT * FROM sedes;
END $
CALL sp_mostrar_sedes()
-------------------------------------
delimiter $
CREATE PROCEDURE sp_mostrar_equipos()
BEGIN
	SELECT * FROM equipos;
END $
CALL sp_mostrar_equipos()
-------------------------------------
delimiter $
CREATE PROCEDURE sp_mostrar_jugadores()
BEGIN
	SELECT * FROM jugadores;
END $
CALL sp_mostrar_jugadores()
-------------------------------------
delimiter $
CREATE PROCEDURE sp_mostrar_fechas()
BEGIN
	SELECT * FROM fechas;
END $
CALL sp_mostrar_fechas()
-------------------------------------

-- Probando
CALL sp_agregar_sedes('Estadio Icónico de Lusail','Lusail',94500);
CALL sp_agregar_sedes('Estadio Al Janoub', 'Al Wakrah',  40000);
CALL sp_agregar_sedes('Estadio Al Bayt','Jor',60000);
CALL sp_agregar_sedes('Estadio Al Thumama','Doha',40000);
SELECT*FROM sedes
-----------------------------------
CALL sp_agregar_equipos('Argentina','America','CONMEBOL','C')
CALL sp_agregar_equipos('Qatar','Asia','AFC','A')
CALL sp_agregar_equipos('Portugal','Europa','UEFA','H')
CALL sp_agregar_equipos('Ecuador','America','CONMEBOL','A')
CALL sp_agregar_equipos('Senegal','Africa','CAF','A')
CALL sp_agregar_equipos('Países Bajos','Europa','UEFA','A')
SELECT*FROM equipos
-----------------------------------
SELECT*FROM jugadores
CALL sp_agregar_jugadores('1','Messi Cuccittini','Lionel Andrés',35,10,'Delantero','Paris Saint-Germain')
CALL sp_agregar_jugadores('2','Dos Santos Aveiro','Cristiano Ronaldo',37,7,'Delantero','Manchester United')
-----------------------------------
SELECT*FROM fechas
CALL sp_agregar_fechas(2,4,3,'2022-11-21 13:00:00',1,2,0,3)
CALL sp_agregar_fechas(5,6,4,'2022-11-21 16:00:00',1,1,1,1)
DROP PROCEDURE sp_agregar_fechas
DROP TABLE fechas
DELETE FROM  fechas
	WHERE id_fecha = 1;
-----------------------------------
call sp_actualizar_sedes('Estadio Icónico de Lusail','Lusail',94500,1)
SELECT * FROM sedes
-----------------------------------
CALL sp_actualizar_equipos('Países bajos','Europa','UEFA','A',6)
DROP PROCEDURE sp_actualizar_equipos
SELECT * FROM equipos
-----------------------------------
CALL sp_mostrar_fechas()
CALL sp_mostrar_equipos()
CALL sp_mostrar_sedes()
CALL sp_agregar_fechas(2,5,4,'2022-11-25 16:00:00',2,2,1,1)
