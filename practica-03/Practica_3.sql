/*
    Practica en clase No. 3
    Cuarta Generacion III - ORACLE
    Prof: Erick Lopez 
    Estudiante: Juan Carlos Santamaria V.
    Fecha: 10-10-2021
*/

---------------------,>-----------------------------------
--Agregar una tabla copia de la tabla de empleados de la tabla HR

    CREATE TABLE EMPLOYEES2 as select * from HR.EMPLOYEES;
    ALTER TABLE SYSTEM.EMPLOYEES2 MOVE TABLESPACE TBS_DATOS;
-- Crear un index a la tabla Employee2
    create index EMPLOYEE_ID on EMPLOYEES2(EMPLOYEE_ID)
-- Poner en modo ofline el tablespace de Index, (fuera de linea)
    alter TABLESPACE tbs_index offline;
--Realizan la consulta para validar si es que se pueda llevar a cabo. 
    select * from system.Employee2
--Luego ponemos online el tablespace de index y ponemos ofline de datos
    alter TABLESPACE tbs_index online;
    alter TABLESPACE TBS_DATOS offline;
--Realizan la consulta para validar si es que se pueda llevar a cabo. 
    select * from system.Employees2
    --Result
    /*
        select * from system.Employees2                     *
        ERROR at line 1:
        ORA-00376: file 5 cannot be read at this time
        ORA-01110: data file 5: 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\TBS_DATOS01.DBF'
    */
--Ponemos el tablespace en modo lectura y tratamos de realizar un insert
    alter TABLESPACE TBS_DATOS online; --primero hacemos esto para poder ponerlo en modo lectura.
    alter tablespace TBS_DATOS read only;
   
INSERT INTO SYSTEM.EMPLOYEES2(
		  EMPLOYEE_ID		, FIRST_NAME		, LAST_NAME
		, EMAIL				, PHONE_NUMBER	    , HIRE_DATE
		, JOB_ID			, SALARY			, COMMISSION_PCT
		, MANAGER_ID		, DEPARTMENT_ID)
VALUES( ------<data dummy>---
           300              , 'JC'              , 'santa'
        , 'BERNST'          , '1'               , SYSDATE 
        , '1'               , 10                , null
        , 100               , 90);
--luego ponemos en modo lectura escritura el tablespace y validan que no se puedan hacer 
--escritura en esa tabla. 
    alter tablespace TBS_DATOS read write;

--al terminar.
--Movemos esa tabla de TBS_DATOS y la movemos al TableSpace USERS, borramos los registros y verificamos 
-- la marca de agua. 
    ALTER TABLE SYSTEM.EMPLOYEES2 MOVE TABLESPACE USERS;

    --para ver los indexes
    SELECT * 
    FROM DBA_INDEXES 
    WHERE TABLE_NAME = 'EMPLOYEES2'

    TRUNCATE TABLE EMPLOYEES2

    ALTER INDEX SYSTEM.EMPLOYEE_ID rebuild online

