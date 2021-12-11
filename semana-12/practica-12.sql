--------------------------------------------------------------------------------------------------------------------------------------------------------
                                        -- Generar Dos tablas  los memorias
--------------------------------------------------------------------------------------------------------------------------------------------------------

create table tablas_db_5pc PCTFREE 5
as SELECT * FROM DBA_TABLES;


create table tablas_db_40pc PCTFREE 40
as SELECT * FROM DBA_TABLES;

--validacion
select segment_name
    ,bytes/1024/1024 mb
    ,blocks
    ,segment_type
from DBA_SEGMENTS
where segment_type='TABLE'
and segment_name like '%TABLAS_DB%';

-- SEGMENT_NAME                                                                              MB     BLOCKS SEGMENT_TYPE
-- --------------------------------------------------------------------------------- ---------- ---------- ------------------
-- TABLAS_DB_5PC                                                                            .75         96 TABLE
-- TABLAS_DB_40PC                                                                             2        256 TABLE

-- en la primera tabla se observa que son solo .75 mb se le establecio un 5%
-- ,para la segunda segunda se establecio 40% se observa que los datos hay mas MB y por ende mas bloques. 

--------------------------------------------------------------------------------------------------------------------------------------------------------
            -- Generar una tabla temporal con dos usuarios diferentes se note que no se puede la información de uno con otro. 
--------------------------------------------------------------------------------------------------------------------------------------------------------

Create GLOBAL temporary TABLE tabla_temp1(
    id number,
    descripcion varchar2(20)
);

INSERT INTO tabla_temp1 (ID,descripcion) VALUES (1, 'DATOS 1');
-----------------------------------------------------------------------------------------------

SELECT * FROM tabla_temp1;



Create GLOBAL  temporary TABLE tabla_temp2(
    id number,
    descripcion varchar2(20)
);
SELECT * FROM tabla_temp2;


INSERT INTO tabla_temp2 (ID,descripcion) VALUES (40, 'DATOS 40');