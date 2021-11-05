

/*Enumera los blokeos que actualmente tiene oracle y las solicitudes pendientes*/
SELECT * FROM V$LOCK 

--Informacion sobre los procesos activos
SELECT * FROM "V$PROCESS" 

--Lista la informacion de cada session 
SELECT * FROM "V$SESSION" WHERE sid = 2

SELECT username,SID,Serial#,Status
FROM "V$SESSION" 
WHERE username = 'SYSTEM'

--PARA MATAR UNA SESSION ESTA PEGADA ESTADO = BLOKED. 
--ESTO GENERA UN CUARTO ESTADO = KILLED
ALTER SYSTEM KILL SESSION '122,1021'

--SNIPED: Este estado es misma base de datos desconecta sessiones activas, lo auto mata.

--Ver las sentencias que ha ejecutado una session en especifico QUE SE ENCUENTRAN EN MEMORIA
--Esta nos ayuda cuales queries se ejecutan mas
SELECT * FROM "V$SQLAREA" WHERE sid = 2


---- Practica 
	SELECT SUBSTR(username, 1, 10),    sid,    serial#,status FROM "V$SESSION" WHERE username IS NOT NULL;
	SET lines 120 --- esto es para SQL plus 



