-- 1. Verificar que tipo de archivo está usando la bd para levantar
-- Para saber a cual base de datos conectarme debeo de indicar el siguiente paso 
SET ORACLE_SID=cg4
--Luego nos conectamos 
SQLPLUS SYS/dba as sysdba
Show parameter spfile

-- 2. Crear el SPFile a partir del PFIle
CREATE spfile from pfile='C:\ORA4G\admin\cg4\pfile\init.ora'

-- 3. Levantar la BD con el SPFile
    --pRIMERO BAJAR LA BASE DE DATOS EN MODO NORMAL 
SHUTDOWN IMMEDIATE;

startup;

-- 4. Verificar que esté trabajando con SPFile
Show parameter spfile;

--------------------------------------------------------------------------------------------------------------
----------------------------------< COMO SE VERIA EN LA CONSOLA >---------------------------------------------
--------------------------------------------------------------------------------------------------------------
                                --SE DEBE DE VER ASI. 
                                SQL> CREATE spfile from pfile='C:\ORA4G\admin\cg4\pfile\init.ora';

                                File created.

                                SQL> startup;
                                ORACLE instance started.

                                Total System Global Area 6814535680 bytes
                                Fixed Size                  2188688 bytes
                                Variable Size            3539995248 bytes
                                Database Buffers         3254779904 bytes
                                Redo Buffers               17571840 bytes
                                Database mounted.
                                Database opened.
                                SQL> Show parameter spfile;

                                NAME                                 TYPE        VALUE
                                ------------------------------------ ----------- ------------------------------
                                spfile                               string      C:\ORA\PRODUCT\11.2.0\DBHOME_1
                                                                                \DATABASE\SPFILECG4.ORA

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

