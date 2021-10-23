-- 1. Construya el tablespace EXAMEN, manejado localmente, 
-- con el archivo de datos EXAMEN01.dbf, con un tamaño de 1M. con manejo uniforme de 128k.
create tablespace EXAMEN
datafile 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\EXAMEN01.dbf'
size 1M
extent MANAGEMENT local UNIFORM SIZE 128K;

-- 2. Construya 2 tablas (TABLA01, TABLA02) de 256K sobre dicho tablespace. (Campo1 varchar2(4000))

CREATE TABLE TABLA01 (
     Campo1 varchar2(4000)
)
TABLESPACE EXAMEN
   STORAGE ( INITIAL 256K);

CREATE TABLE TABLA02 (
     Campo1 varchar2(4000)
)
   TABLESPACE EXAMEN
   STORAGE ( INITIAL 256K);

-- 3. Borra la tabla TABLA02 y crea una nueva tabla TABLA03 de 352K. 
--¿Explique qué ocurre y por qué?. (Campo1 varchar2(4000))
DROP TABLE TABLA02;
CREATE TABLE TABLA03 (
     Campo1 varchar2(4000)
)
   TABLESPACE EXAMEN
   STORAGE ( INITIAL 352K);

-- 4. Establezca el tablespace EXAMEN en modo solo lectura.
    alter tablespace EXAMEN read only;

-- 5. Ponga fuera de línea en modo NORMAL el tablespace EXAMEN
alter TABLESPACE EXAMEN offline NORMAL;

-- 6. Agregue un nuevo datafile al tablespace. EXAMEN02.dbf con el mismo tamaño del anterior.
--ACA NO ME DEJO POR LO QUE TUVE QUE RESTABLECERLO
alter tablespace EXAMEN read write;
alter tablespace EXAMEN online;
ALTER TABLESPACE EXAMEN
ADD DATAFILE 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\EXAMEN02.dbf' size 1M;

-- 7. Establezca el tablespace EXAMEN
alter tablespace EXAMEN read write;

-- 8. Amplie el tamaño del datafile EXAMEN01.dbf a 3 mb.
ALTER DATABASE 
    DATAFILE 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\EXAMEN01.dbf' 
RESIZE 3M;

-- 9. Verifique que la tablas tabla02 y la tabla03 estén en el tablespace EXAMEN, 
--sino lo están muévalas ahi.

--la tabla02 se borro previamente en el paso 3
select TABLE_NAME from DBA_Tables where tablespace_name = 'EXAMEN';

-- 10. Compacte el tablespace EXAMEN para reducir la fragmentación.
ALTER TABLE TABLA01 MOVE;
ALTER TABLE TABLA01 ENABLE ROW MOVEMENT;
alter table TABLA01 SHRINK SPACE COMPACT;

ALTER TABLE TABLA03 MOVE;
ALTER TABLE TABLA03 ENABLE ROW MOVEMENT;
alter table TABLA03 SHRINK SPACE COMPACT;

-- 11. Construya un nuevo tablespace temporal llamado TEMP2 y sustituya el que está en uso actualmente (coloque todos los pasos).
ALTER DATABASE DEFAULT TEMP TABLESPACE TEMP2;