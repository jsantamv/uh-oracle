-- Realice la construcción de un cluster table entre las tablas 
--     departments 
--     locations 
-- del esquema HR 
-- (realice una copia a cada tabla, departamentos y localizaciones, respectivamente y trabaje sobre las copias).


-------------------------------------------------------------------------------------------

CREATE CLUSTER c_locations(location_id number(10));
CREATE INDEX IDX_location_id ON CLUSTER c_locations;

CREATE TABLE localizaciones  
    ( location_id    NUMBER(10)   
    , street_address VARCHAR2(40)  
    , postal_code    VARCHAR2(12)  
    , city           VARCHAR2(30)
    , state_province VARCHAR2(25)  
    , country_id     CHAR(2)  
    )  CLUSTER c_locations  (location_id);

INSERT INTO localizaciones
SELECT * FROM locations


-------------------------------------------------------------------------------------------
CREATE table DEPARTAMENTOS
( 
      DEPARTMENT_ID    NUMBER(10) 
    , department_name  VARCHAR2(30) 
    , manager_id       NUMBER(6)  
    , location_id      NUMBER(4)  
 )  CLUSTER c_locations  (location_id);

 INSERT INTO DEPARTAMENTOS
 SELECT * FROM departments;
 



-- CREATE table ordenes_detalle(order_id number(10), order_line varchar2(100)) cluster  c_ordenes  (order_id);