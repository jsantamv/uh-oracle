-- Crear de manera manual una base de datos llamada CG4
--oradim -DELETE -SID DBSERV01 
--paso 1
oradim -NEW -SID DBSERV01 -STARTMODE manual -PFILE "C:\proyectooracle\admin\DBSERV01\pfile\init.ora"
SET ORACLE_SID=DBSERV01

--paso 2
sqlplus /nolog
conn /as sysdba
startup nomount pfile=C:\proyectooracle\admin\DBSERV01\pfile\init.ora
startup mount pfile=C:\proyectooracle\admin\DBSERV01\pfile\init.ora

startup mount pfile=C:\ORA\product\11.2.0\admin\DBSERV01\pfile
--Puede que se ocupe este paso SHUTDOWN IMMEDIATE

--paso 3 Creacion de la base de datos. 
CREATE DATABASE DBSERV01
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
DATAFILE 'C:\proyectooracle\oradata\DBSERV01\system01.dbf' SIZE 700M REUSE AUTOEXTEND ON NEXT  10240K MAXSIZE UNLIMITED
EXTENT MANAGEMENT LOCAL
SYSAUX DATAFILE 'C:\proyectooracle\oradata\DBSERV01\sysaux01.dbf' SIZE 600M REUSE AUTOEXTEND ON NEXT  10240K MAXSIZE UNLIMITED
SMALLFILE DEFAULT TEMPORARY TABLESPACE TEMP TEMPFILE 'C:\proyectooracle\oradata\DBSERV01\temp01.dbf' SIZE 20M REUSE AUTOEXTEND ON NEXT  640K MAXSIZE UNLIMITED
SMALLFILE UNDO TABLESPACE "UNDOTBS1" DATAFILE 'C:\proyectooracle\oradata\DBSERV01\undotbs01.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT  5120K MAXSIZE UNLIMITED
CHARACTER SET WE8MSWIN1252
NATIONAL CHARACTER SET AL16UTF16
LOGFILE GROUP 1 ('C:\proyectooracle\oradata\DBSERV01\redo01.log') SIZE 51200K,
GROUP 2 ('C:\proyectooracle\oradata\DBSERV01\redo02.log') SIZE 51200K,
GROUP 3 ('C:\proyectooracle\oradata\DBSERV01\redo03.log') SIZE 51200K
USER SYS IDENTIFIED BY 123 USER SYSTEM IDENTIFIED BY 123;

--describe v$Instance;
-- select INSTANCE_NAME from v$Instance;
-- select NAME from v$DATABASE;

--paso 4
--Correr los archivos C:\ORA\product\11.2.0\dbhome_1\RDBMS\ADMIN

SQLPLUS SYS/dba as sysdba
--CON SYS  SQLPLUS SYS/dba as sysdba
START C:\ORA\product\11.2.0\dbhome_1\RDBMS\ADMIN\catalog.sql;
START C:\ORA\product\11.2.0\dbhome_1\RDBMS\ADMIN\catblock.sql;
START C:\ORA\product\11.2.0\dbhome_1\RDBMS\ADMIN\catproc.sql;
START C:\ORA\product\11.2.0\dbhome_1\RDBMS\ADMIN\catoctk.sql;
START C:\ORA\product\11.2.0\dbhome_1\RDBMS\ADMIN\owminst.plb;
EXIT

SQLPLUS SYSTEM SQLPLUS SYSTEM
--CON SYSTEM SQLPLUS SYSTEM
START C:\ORA\product\11.2.0\dbhome_1\sqlplus\admin\pupbld.sql;
START C:\ORA\product\11.2.0\dbhome_1\sqlplus\admin\help\hlpbld.sql;
START C:\ORA\product\11.2.0\dbhome_1\sqlplus\admin\help\helpus.sql;