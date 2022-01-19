--pregunta 9

-- a. Realice una partición por rango por
    -- id de escuela y 
        --3 subparticiones.  
         --Las subparticiones se llamarán 
         --TEMPLATE, MASCULINO y FEMENINO por el campo SEXO. 
-- b. Realice una consulta a la subparticion MASCULINO 5pts
CREATE TABLE ESTUDIANTES 
( 
    CEDULA VARCHAR2(10) not null, 
    NOMBRES VARCHAR2(40), 
    APELLIDOS VARCHAR2(40), 
    SEXO CHAR(1), 
    ID_ESCUELA INTEGER, 
    constraint PK_ESTUDIANTES primary key (CEDULA)
)
PARTITION BY RANGE (ID_ESCUELA)   
    PARTITION BY HASH (SEXO)
    (   
        SUBPARTITION TEMPLATE 
        (             
            SUBPARTITION MASCULINO VALUES  ('M'),
            SUBPARTITION FEMENINO VALUES   ('F')
        )
    );


SELECT * FROM ESTUDIANTES PARTITION(TEMPLATE.MASCULINO)
