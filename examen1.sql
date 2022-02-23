-- Realice cada uno de los siguientes enunciados.
-- 2 pts cada respuesta correcta, 0 pts respuesta incorrecta.
-- Recuerde cargar el archivo Word con la evidencia de este ejercicio.
SET TIME ON;
set sqlprompt "SQL _USER _DATE>";

-- Cómo administrador de la base de datos se le solicita 
--      crear un usuario llamado EX, asigne la contraseña X
CREATE USER EX IDENTIFIED BY X;
ALTER USER EX IDENTIFIED BY X
-- Construya un rol llamado EXA y asigne los permisos de crear sesión, 
--      crear tablas, crear secuencias, crear triggers, 
--      crear vistas al rol EXA (2 pts), asigne el rol al usuario EX.
CREATE ROLE EXA NOT IDENTIFIED;
GRANT CREATE SESSION, 
    CREATE ANY TABLE, 
    CREATE ANY SEQUENCE, 
    CREATE ANY TRIGGER, 
    CREATE ANY VIEW TO EXA; 
GRANT UNLIMITED TABLESPACE TO EXA;
GRANT EXA TO EX;
-- Habilite y configure la auditoría en modo extendido.
alter system set AUDIT_TRAIL=db, extended scope=spfile;
alter system set audit_sys_operations=true scope=spfile; 
-- Habilite el flashback en la base de datos
ALTER SYSTEM SET UNDO_MANAGEMENT=auto SCOPE=SPFILE;
ALTER SYSTEM SET UNDO_RETENTION = 3600;

-- Cargue los scripts del archivo Tablas.zip en el esquema EX
-- Aplique la auditoría para las siguientes acciones:
-- 6.1. Logueo del usuario EX
AUDIT SESSION BY EX;
-- 6.2. Operaciones administrativas del usuario SYS
AUDIT SYSADM BY SYS;
-- 6.3. Creación de tablas para el usuario EX
AUDIT CREATE ANY TABLE BY EX;
-- 6.4. Borrados sobre la tabla CUSTOMERS y ORDER_ITEMS por cada intento logrado
AUDIT DELETE ON EX.CUSTOMERS WHENEVER SUCCESSFUL;
AUDIT DELETE ON EX.ORDER_ITEMS WHENEVER SUCCESSFUL;

DELETE from CUSTOMERS where Customer_Id = 924;
delete from ORDER_ITEMS where ORDER_ID = 2355;
-------------------------------------------------------------
-------------------------------------------------------------
-- 6.5. Borrado de tablas
AUDIT DROP ANY TABLE;
-- 6.6. Actualización de datos sobre la tabla ORDER_ITEMS
AUDIT UPDATE ON EX.ORDER_ITEMS;
-- 6.7. Inserciones sobre las tablas 
    --customers, product_information, orders y order_items
AUDIT INSERT ON EX.CUSTOMERS;
AUDIT INSERT ON EX.PRODUCT_INFORMATION;
AUDIT INSERT ON EX.ORDERS;
AUDIT INSERT ON EX.ORDER_ITEMS;

-- 7. Extraiga la siguiente información de la auditoría:

-- 7.1 Inserciones, actualizaciones y borrados de datos del usuario EXA.
SELECT 
    SUBSTR(OBJ_NAME,1,20) AS OBJ_NAME, 
    SESSIONID, 
    USERNAME, 
    TIMESTAMP,
    SES_ACTIONS 
FROM DBA_AUDIT_TRAIL 
WHERE USERNAME = 'EX';
-- 7.2 Logueos y deslogueos del usuario EXA
SELECT 
    ACTION#, 
    SUBSTR(OBJ$NAME,1,20) as OBJ_NAME, 
    SESSIONID, 
    USERID, 
    SQLBIND, 
    NTIMESTAMP# 
FROM SYS.AUD$ 
WHERE USERID = 'EX' 
AND ACTION# IN(100,101); 

-- 7.3 Borrado de tablas que llevó a cabo

drop table ORDER_ITEMS;

SELECT 
ACTION#, 
OBJ$NAME, 
SESSIONID, 
USERID, 
NTIMESTAMP# 
FROM SYS.AUD$ 
WHERE USERID = 'EX' 
AND ACTION# IN(12);

-- 7.4 Cuando y cuál fue el último DML realizado por ese usuario
SELECT ACTION#, 
SUBSTR(OBJ$NAME,1,20) as OBJ_NAME,  
SESSIONID, 
USERID, 
NTIMESTAMP# 
FROM SYS.AUD$ 
WHERE USERID = 'EX' 
ORDER BY NTIMESTAMP# DESC;