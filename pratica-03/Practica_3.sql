/*
    Practica en clase No. 20
    Cuarta Generacion III - ORACLE
    Prof: Erick Lopez 
    Estudiante: Juan Carlos Santamaria V.
*/


--------------------------------------------------------------------------------
-- Crear 2 tablespaces:
-- *Ruta va a ser la misma del system que se ubica en ORADATA
    -- 1. tbs_datos	--> tbs_datos01.dbf (20 M)
    -- 	manejo local autoasignado, segmento auto

select *
from dba_data_files;

Create tablespace tbs_datos 
      datafile 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\tbs_datos01.DBF' 
      size 20M 
      EXTENT MANAGEMENT LOCAL AUTOALLOCATE;

    -- 2. tbs_index    --> tbs_index01.dbf (20 M)
    -- 	manejo local uniforme de 256k cada extension
Create tablespace tbs_index 
      datafile 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\tbs_index01.DBF' 
      size 20M 
      EXTENT MANAGEMENT LOCAL 
      UNIFORM SIZE 256k;

--------------------------------------------------------------------------------
-- Crear un usuario llamado test con contrasena abc
    -- Dar los privilegios necesarios (conectar, crear tablas, acceso a tablespaces ilimitado)
CREATE USER TEST IDENTIFIED BY abc;
    GRANT CONNECT       TO test;
    GRANT RESOURCE      TO test;
    GRANT CREATE VIEW   TO test;
    GRANT UNLIMITED TABLESPACE TO test;

--------------------------------------------------------------------------------
-- conectese con el usuario test y realice las siguientes tablas

-- C:\Users\SANTAMARIAVILLEGASJU>sqlplus
-- SQL*Plus: Release 11.2.0.2.0 Production on Sat Oct 2 12:38:32 2021
-- Copyright (c) 1982, 2014, Oracle.  All rights reserved.
-- Enter user-name: test
-- Enter password:
-- Connected to:
-- Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production
-- SQL>

--------------------------------------------------------------------------------
-- Crear 2 tabla con una llave primaria
    -- La primer tabla la graban en el tablespace por default de la BD
CREATE TABLE Carreras (
     IdCarrera  NUMBER(10)  NOT NULL
    ,Carrera    VARCHAR2(30) NOT NULL
    ,constraint pk_IdCarrera Primary Key (IdCarrera)
);

    -- La segunda va al tablespace tbs_datos
CREATE TABLE Cursos (
     IdCurso    NUMBER(10)      NOT NULL
    ,Curso      VARCHAR2(30)    NOT NULL
    ,IdCarrera  NUMBER(10)      NOT NULL
    ,constraint pk_IdCurso Primary Key (IdCurso)
    ,constraint fk_IdCarrera_IdCurso FOREIGN KEY (IdCarrera)
        REFERENCES Carreras(IdCarrera)
        ON DELETE CASCADE
);

ALTER TABLE Cursos move TABLESPACE tbs_datos;


--------------------------------------------------------------------------------
-- Hacer una consulta que muestre el nombre de la tabla y el tablespace
-- donde esta almacenada.
SELECT 
	 SEGMENT_NAME		AS Tabla
	,TABLESPACE_NAME 	AS TableSpace
FROM user_segments
WHERE SEGMENT_TYPE = 'TABLE';

---------------------,>-----------------------------------
--Agregar una tabla copia de la tabla de empleados de la tabla HR
    ALTER TABLE SYSTEM.EMPLOYEES2 MOVE TABLESPACE TBS_DATOS;
    CREATE TABLE EMPLOYEES2 as select * from HR.EMPLOYEES
-- Crear un index a la tabla Employee2
    create index EMPLOYEE_ID on EMPLOYEES2(EMPLOYEE_ID)
-- Poner en modo ofline el tablespace de Index, (fuera de linea)
    alter TABLESPACE tbs_index offline;
--Realizan la consulta para validar si es que se pueda llevar a cabo. 
    select * from system.Employee2
--Luego ponemos online el tablespace de index y ponemos ofline de datos
--Realizan la consulta para validar si es que se pueda llevar a cabo. 
--Ponemos el tablespace en modo lectura y tratamos de realizar un insert
--luego ponemos en modo lectura escritura el tablespace y validan que no se puedan hacer 
--escritura en esa tabla. 

--al terminar.
--Movemos esa tabla a TS_DATOS y la movemos al TableSpace USERS, borramos los registros y verificamos 
-- la marca de agua. 
