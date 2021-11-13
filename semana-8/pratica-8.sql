/*
Practica Particionamiento

1. Realizar una tabla particionada basandose en los objetos que existen en la base de datos.
  La tabla se llamara OBJETOS_DB
  La partician sera por tipo de objeto.
  Las tablas, vistas y vistas materializadas iran a una particion llamada   PART_TABLES
  Los procedimientos, funciones y paquetes a PART_PROCEDURES
  Los indices a PART_INDEX
  Los triggers a PART_TRIGG
  y el resto a una por default

  Llenar esa tabla con la informacian solicitada
  */
  

select * from dba_objects


CREATE TABLE OBJETOS_DB (
    OBJECT_ID  NUMBER(10) NOT NULL,
    OBJECT_TYPE VARCHAR2(30) not null,
)
PARTITION BY list (OBJECT_TYPE) (
    PARTITION PART_TABLES VALUES ('TABLE','INDEX','VIEW'),
    PARTITION PART_PROCEDURES VALUES ('PROCEDURE','FUNCTION','PACKAGE'),
    PARTITION PART_INDEX VALUES ('INDEX'),
    PARTITION PART_TRIGG VALUES ('TRIGGER'),
    PARTITION PART_RESTO values (DEFAULT)
);


/*

2. Construya una tabla particionada llamada EMPLEADOS
   El particionamiento sera en primer nivel por fecha de contratacian
 	Si la fecha de ingreso es menor al 01-01-1990 coloque los valores en la partician llamada PART1.
 	Si la fecha de ingreso es menor al 01-01-1995 coloque los valores en la partician llamada PART2.
 	Si la fecha de ingreso es menor al 01-01-1998 coloque los valores en la partician llamada PART3.
 	Si la fecha de ingreso es menor al 01-01-2000 coloque los valores en la partician llamada PART4.
	Por cada partician habra una supartician por departamentos
		La subparticion PARTX_SPART1 departamentos 10,20,30
		La subparticion PARTX_SPART2 departamentos 40,50,60
		La subparticion PARTX_SPART3 departamentos 70,80,90
		La subparticion PARTX_SPART4 departamentos 100,100
  */

CREATE TABLE EMPLEADOS (
    ID_empleado  integer NOT NULL,
    Fecha_Contratacian DATE not null,
    departamentos VARCHAR2(20) NOT NULL
)
PARTITION by rage(Fecha_Contratacian)
  SUBPARTITION BY LIST (departamentos)
    (
      PARTITION    Fecha_Ingreso VALUES LESS THAN ('1990-01-01')
      (
        SUBPARTITION  PARTX_SPART1 VALUES (10,20,30),
        SUBPARTITION  PARTX_SPART1 VALUES (40,50,60),
        SUBPARTITION  PARTX_SPART1 VALUES (70,80,90),
        SUBPARTITION  PARTX_SPART1 VALUES (100,100)
      ),
      PARTITION    Fecha_Ingreso VALUES LESS THAN ('1995-01-01')
      (
        SUBPARTITION  PARTX_SPART1 VALUES (10,20,30),
        SUBPARTITION  PARTX_SPART1 VALUES (40,50,60),
        SUBPARTITION  PARTX_SPART1 VALUES (70,80,90),
        SUBPARTITION  PARTX_SPART1 VALUES (100,100)
      ),
      PARTITION    Fecha_Ingreso VALUES LESS THAN ('1998-01-01')
      (
        SUBPARTITION  PARTX_SPART1 VALUES (10,20,30),
        SUBPARTITION  PARTX_SPART1 VALUES (40,50,60),
        SUBPARTITION  PARTX_SPART1 VALUES (70,80,90),
        SUBPARTITION  PARTX_SPART1 VALUES (100,100)
      ),
      PARTITION    Fecha_Ingreso VALUES LESS THAN ('2000-01-01'),
      (
        SUBPARTITION  PARTX_SPART1 VALUES (10,20,30),
        SUBPARTITION  PARTX_SPART1 VALUES (40,50,60),
        SUBPARTITION  PARTX_SPART1 VALUES (70,80,90),
        SUBPARTITION  PARTX_SPART1 VALUES (100,100)
      ),
    );
