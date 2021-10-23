
-- Construya un tablespace llamado TS_PRACTICA. 
-- El tablespace será de manero automático por segmento. 
-- Tendrá un datafile llamado TS_PRACTICA01.dbf de 10 Mb.
create tablespace TS_PRACTICA
datafile 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\TS_PRACTICA01.DBF'
size 10M
extent MANAGEMENT local AUTOALLOCATE;

-- Agregue otro datafile de 10 Mb llamado TS_PRACTICA02.dbf
-- Realice un usuario llamado PRACTICA 
-- asigne los permisos necesiarios y 
-- asígnelo al tablespace TS_PRACTICA.
create tablespace TS_PRACTICA02
datafile 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\TS_PRACTICA02.DBF'
size 10M
extent MANAGEMENT local AUTOALLOCATE;

CREATE USER PRACTICA IDENTIFIED BY abc;
    GRANT CONNECT       TO PRACTICA;
    GRANT RESOURCE      TO PRACTICA;
    GRANT CREATE VIEW   TO PRACTICA;
    GRANT UNLIMITED TABLESPACE TO PRACTICA;



-- Realice una tabla llamada EMPLEADOS 
-- con los datos de HR.EMPLOYEES.
-- Genere un índice a la tabla EMPLEADOS al 
-- campo EMPLOYEE_ID, la llave se llamará EMP_ID_PK. 
CREATE TABLE EMPLEADOS as select * from HR.EMPLOYEES;
ALTER TABLE SYSTEM.EMPLEADOS MOVE TABLESPACE TS_PRACTICA02;
select TABLE_NAME from DBA_Tables where tablespace_name = 'TS_PRACTICA02';

--para validar el index
select index_name, TABLESPACE_NAME
from dba_indexes 
where table_name = 'EMPLEADOS' 
and  rownum <= 2;

create index EMP_ID_PK on empleados(EMPLOYEE_ID);
Alter index EMP_ID_PK rebuild tablespace TS_PRACTICA02;

--Pongo fuera de línea el datafile TS_PRACTICA02.dbf
alter TABLESPACE TS_PRACTICA02 offline;

--Realice un tablespace llamado TS_INDEX con un datafile TS_INDEX01.dbf
create tablespace TS_INDEX
datafile 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\TS_INDEX01.DBF'
size 10M
extent MANAGEMENT local AUTOALLOCATE;

--Mueva el índice a este último tablespace.
alter TABLESPACE TS_PRACTICA02 ONLINE;
Alter index EMP_ID_PK rebuild tablespace TS_INDEX;

-- Realice una tabla llamada TESTING con el usuario PRACTICA, 
-- la tabla tendrá dos campos ID numérico de 10 y FECHA date.
connect PRACTICA/abc;

CREATE TABLE TESTING (
    Id NUMBER(10) not null,
    fecha date,
    constraint pk_idtesting Primary Key (id)
);


-- Conectese con el usuario TEST Realice un bloque de PLSQL 
-- que inserte 500,000 registros en esa tabla del ID 
-- con un valor numérico y la FECHA con el valor del 
-- día con formato de fecha dd/mm/yyyy hh:mi

ALTER USER test IDENTIFIED BY 123
connect test/123

select * from v$tables;