--Realizar una exportacion completa de la base de datos. 
exp system/123 full=Y file=C:\Users\jsant\Downloads\RespOracle\ejercicio01.dmp log=C:\Users\jsant\Downloads\RespOracle\Log\ejercicio01.log rows=y
--el nombre del archivo de respaldo <ejercicio01.dmp>
exp system/123 file=C:\app\DEPARTMENTS.dmp constraints=Y tables=HR.DEPARTMENTS rows=y

-- 2. Vamos a insertar un registro en la tabla EMPLEADOS HR
        -- Realizamos un exportar Incremental.
insert into hr.employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id,salary, commission_pct, manager_id, department_id)Values(210, 'Janette', 'sssss', 'sss@W', '650.555.8880', '25-MAR-2009', 'SA_REP',3500, 0.25, 145, 80);

-- 3. Hacer una exportacion de las tablas CUSTOMER, PRODUCT_INFORMATION 
-- del schema OE, que inclya indices, datos, y constrarint.
exp system/123 file=C:\app\ejercicio02.dmp constraints=Y tables=OE.CUSTOMERS,OE.PRODUCT_INFORMATION rows=y
exp system/123 file=C:\app\ejercicio07.dmp constraints=Y tables=OE.CUSTOMERS,OE.PRODUCT_INFORMATION rows=y

-- 4. Crear un Schema Nuevo llamado BackUp, pass B
-- vamos a impoortar la tabla departamentos del primer backuo

SQLPLUS SYS/dba as sysdba

CREATE USER BACKUP IDENTIFIED BY 123;
GRANT UNLIMITED TABLESPACE TO BACKUP;
GRANT ALL PRIVILEGES TO BACKUP;
GRANT CONNECT TO BACKUP;

--- cONECTARME
CONN BACKUP/123;
--- salir
DISC;
EXIT

--Importamos los usuarios
IMP SYSTEM/123 file=C:\app\ejercicio01.dmp rows=Y Tables=DEPARTMENTS FROMUSER=HR TOUSER=BACKUP

-- 5. Hacer la importacion en el Schema BackUp de la tabla deparpament
-- del segundo backup y 
IMP SYSTEM/123 file=C:\app\ejercicio01.dmp rows=Y Tables=DEPARTMENTS FROMUSER=HR TOUSER=BACKUP

-- 6 Importar las dos talbas COSTUMER, PRODUCTS SIN DATOS
IMP SYSTEM/123 file=C:\app\ejercicio02.dmp rows=n Tables=CUSTOMERS,PRODUCT_INFORMATION FROMUSER=OE TOUSER=BACKUP
IMP SYSTEM/123 file=C:\app\ejercicio07.dmp rows=n Tables=CUSTOMERS,PRODUCT_INFORMATION FROMUSER=OE TOUSER=BACKUP
IMP SYSTEM/123 file=C:\app\ejercicio07.dmp rows=n INDEXES=n IMP-00017: following statement failed with ORACLE error 2304:
 "CREATE TYPE "PHONE_LIST_TYP" TIMESTAMP '2022-01-29:18:12:36' OID '82A4AF6A4"
 "CD2656DE034080020E0EE3D'      Tables=CUSTOMERS FROMUSER=OE TOUSER=BACKUP
