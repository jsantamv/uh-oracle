--PARTE 1
-- 1. Generar un querie entre las tablas emplados y departamentos del* schema HR (nombre, 
-- empleado, salario, fecha de ingreso)
-- 2. Generar un plan de ejecucion. 
-- 3. Verificar que se este utilizando alguna llave
-- 4. en caso de no use crear una para verificar que utilice los indeces

--PARTE 2
-- Ejecutar ese querie unas 5 veces y posteriormente vamos a la VISTA
-- que almacena las sentencias y validamos el numero de ejecuciones 
-- que realiza esas sentencias. 


SELECT 
	 CONCAT(FIRST_NAME,LAST_NAME) AS Nombre
	,e.Hire_date	
	,e.Salary
	,d.department_name
FROM HR.EMPLOYEES E 
INNER JOIN HR.DEPARTMENTS D
	ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; 
	

explain plan for
SELECT 
	 CONCAT(FIRST_NAME,LAST_NAME) AS Nombre
	,e.Hire_date	
	,e.Salary
	,d.department_name
FROM HR.EMPLOYEES E 
INNER JOIN HR.DEPARTMENTS D
	ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; 
	
SELECT * 
FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Plan hash value: 1343509718
 
-- --------------------------------------------------------------------------------------------
-- | Id  | Operation                    | Name        | Rows  | Bytes | Cost (%CPU)| Time     |
-- --------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT             |             |   106 |  4876 |     6  (17)| 00:00:01 |
-- |   1 |  MERGE JOIN                  |             |   106 |  4876 |     6  (17)| 00:00:01 |
-- |   2 |   TABLE ACCESS BY INDEX ROWID| DEPARTMENTS |    27 |   432 |     2   (0)| 00:00:01 |
-- |   3 |    INDEX FULL SCAN           | DEPT_ID_PK  |    27 |       |     1   (0)| 00:00:01 | --- Ful Index Scan.
-- |*  4 |   SORT JOIN                  |             |   107 |  3210 |     4  (25)| 00:00:01 |
-- |   5 |    TABLE ACCESS FULL         | EMPLOYEES   |   107 |  3210 |     3   (0)| 00:00:01 |
-- --------------------------------------------------------------------------------------------
 
-- Predicate Information (identified by operation id):
-- ---------------------------------------------------
 
--    4 - access("E"."DEPARTMENT_ID"="D"."DEPARTMENT_ID")
--        filter("E"."DEPARTMENT_ID"="D"."DEPARTMENT_ID")



SELECT * FROM "V$SQLAREA" WHERE SQL_TEXT LIKE '%FIRST_NAME%';


