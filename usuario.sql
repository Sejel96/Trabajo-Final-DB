-- Usuario
-- Visualizar las fechas
SELECT f.fecha_hora,l.nombre AS 'Local' , ' vs ',v.nombre AS 'Visitante'
FROM fechas f
	INNER JOIN equipos l ON f.id_local=l.id_equipo
	INNER JOIN equipos v ON f.id_visitante=v.id_equipo
	INNER JOIN sedes s ON f.id_sede=s.id_sede
--------------------------------------------------------------------------


SELECT * FROM equipos
SELECT * FROM fechas
 
 -- estadisticas locales del equipo

SELECT all l.nombre, SUM(f.puntos_local) AS 'puntos locales', 
	SUM(f.goles_local) AS 'puntos visitantes'
FROM fechas f
	 INNER JOIN equipos l ON f.id_local=l.id_equipo
	 
	 WHERE id_local = 2
	 
 -- estadisticas visitanes del equipo
 
SELECT v.nombre, SUM(f.puntos_visita) AS 'puntos visitante', 
	SUM(f.goles_visita) AS 'goles visitante'
FROM fechas f
	 INNER JOIN equipos v ON f.id_visitante=v.id_equipo
	 WHERE id_visitante = 4
 
 
 -- tabla de jugadores
 
 SELECT j.apellidos AS 'Apellidos', j.nombres AS 'nombres', e.nombre AS 'equipo',
 	j.posicion AS 'Posición', e.grupo  
 FROM jugadores j
 	INNER JOIN equipos e ON j.id_equipo = e.id_equipo

 
