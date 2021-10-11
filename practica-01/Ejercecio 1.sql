----------------------< #1 >-------------------------------
--cantidad de usuarios en la base de datos ------
--Select * from dba_users;
Select count(1) from dba_users;

----------------------< #2 >-------------------------------
--#2 cantidad de tablas por usuarios
select usr.UserName
      ,Count(1)  as Cantidad  
from dba_objects obj
inner join dba_users usr
    on usr.UserName = obj.Owner
where obj.object_type = 'TABLE'
group by usr.UserName;

----------------------< #3 >-------------------------------
--#3 CONUSLTA DE USUARIOS CONETADOS POR SESSION
--select *  FROM v$session;
--los userNull son procesos background

SELECT UserName, count(1) 
FROM v$session
where Status = 'ACTIVE'
GROUP BY UserName;

----------------------< #4 >-------------------------------
--#5 para tamanio en megas ocupado por la base de datos
select tablespace_name, --Esto es por Table Space
        (bytes/1024)/1024 as MB 
from dba_data_files

select Sum((bytes/1024)/1024) as MB 
from DBA_Segments

----------------------< #5 >-------------------------------
--#6 que muestre por tipo de objeto de base de datos el 
--nombre y la cantidad

select OBJECT_TYPE
      ,COUNT(1) AS CANTIDAD
from dba_objects
GROUP BY OBJECT_TYPE
order by 2 desc

----------------------< #6 >-------------------------------
/*Consulta SQL para conocer el tamano en MB ocupado por una
tabla en especifico sin incluir los indices de la misma. */
--SELECT  * from DBA_Segments WHERE ROWNUM <= 10

SELECT 
      SEGMENT_NAME
     ,SUM((BYTES/1024)/1024) AS MB
FROM DBA_Segments
where SEGMENT_TYPE = 'TABLE'
AND SEGMENT_NAME = 'SOURCE$'
GROUP BY SEGMENT_NAME
ORDER BY 2 DESC

----------------------< #7 >-------------------------------
/* Consulta SQL para conocer el tamaño ocupado por una tabla 
en específico incluyendo los índices de la misma */
--SELECT  * from DBA_oBJECTS WHERE ROWNUM <= 10 AND OBJECT_NAME = 'I_CON2';
--SELECT  * from DBA_oBJECTS WHERE ROWNUM <= 10 AND OBJECT_NAME = 'UNDO$';
--SELECT * FROM dba_indexes WHERE TABLE_NAME = 'APEX$_ACL'
--SELECT  * from DBA_SEGMENTS WHERE segment_name = 'APEX$_ACL'
--SELECT  * from DBA_SEGMENTS WHERE ROWNUM <= 10 AND SEGMENT_TYPE = 'INDEX';

/*  para saber los indexes de una tabla
SELECT 
         SEG.SEGMENT_NAME
        ,ind.index_name
        ,SEG.BYTES/1024/1024
FROM DBA_Segments SEG
INNER JOIN dba_indexes IND 
    ON SEG.SEGMENT_NAME = IND.TABLE_NAME
WHERE SEGMENT_TYPE in ('TABLE') 
AND IND.TABLE_NAME = 'SOURCE$'
--GROUP BY SEGMENT_NAME
ORDER BY 2 DESC
*/

SELECT 
      SEGMENT_NAME
     ,SUM((BYTES/1024)/1024) AS MB
FROM DBA_Segments
where SEGMENT_TYPE IN ('TABLE','INDEX')
AND SEGMENT_NAME = 'SOURCE$'
GROUP BY SEGMENT_NAME
ORDER BY 2 DESC


----------------------< #8 >-------------------------------
--Consulta SQL para conocer el espacio ocupado por todos 
--los objetos de la base de datos, muestra los objetos que 
--más ocupan primero

SELECT 
      SEGMENT_NAME
    ,SEGMENT_TYPE
     ,SUM((BYTES/1024)/1024) AS MB
FROM DBA_Segments
GROUP BY SEGMENT_NAME,SEGMENT_TYPE
ORDER BY 3 DESC

----------------------< #9 >-------------------------------
--Consulta que determine cuales son los tablespaces que 
--existen en la bd y cual es su datafile asociado así como 
--el tamaño asignado

select 
     tablespace_name
    ,fILE_NAME
    ,bYTES/1024/1024 AS MB
from dba_data_files

----------------------< #10 >-------------------------------
--¿Cómo puedo extraer el DDL de un procedimiento almacenado 
--desde el diccionario de datos?

select 
     name AS sp_NAME
    ,line AS lIENA
    ,text AS ddl
from dba_source
where owner = 'SYSTEM' 
and NAME ='ORA$_SYS_REP_AUTH'
order by name,line
