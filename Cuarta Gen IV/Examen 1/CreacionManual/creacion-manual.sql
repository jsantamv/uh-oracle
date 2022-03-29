-- Crear de manera manual una base de datos llamada CG4
--oradim -DELETE -SID cg4 
--paso 1
oradim -NEW -SID cg4 -STARTMODE manual -PFILE "C:\ORA4G\admin\cg4\pfile\init.ora"
SET ORACLE_SID=cg4

--paso 2
sqlplus /nolog
conn /as sysdba
startup nomount pfile=C:\ORA4G\admin\cg4\pfile\init.ora
--Puede que se ocupe este paso SHUTDOWN IMMEDIATE

--paso 3 Creacion de la base de datos. 
CREATE DATABASE cg4
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
DATAFILE 'C:\ORA4G\oradata\cg4\system01.dbf' SIZE 700M REUSE AUTOEXTEND ON NEXT  10240K MAXSIZE UNLIMITED
EXTENT MANAGEMENT LOCAL
SYSAUX DATAFILE 'C:\ORA4G\oradata\cg4\sysaux01.dbf' SIZE 600M REUSE AUTOEXTEND ON NEXT  10240K MAXSIZE UNLIMITED
SMALLFILE DEFAULT TEMPORARY TABLESPACE TEMP TEMPFILE 'C:\ORA4G\oradata\cg4\temp01.dbf' SIZE 20M REUSE AUTOEXTEND ON NEXT  640K MAXSIZE UNLIMITED
SMALLFILE UNDO TABLESPACE "UNDOTBS1" DATAFILE 'C:\ORA4G\oradata\cg4\undotbs01.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT  5120K MAXSIZE UNLIMITED
CHARACTER SET WE8MSWIN1252
NATIONAL CHARACTER SET AL16UTF16
LOGFILE GROUP 1 ('C:\ORA4G\oradata\cg4\redo01.log') SIZE 51200K,
GROUP 2 ('C:\ORA4G\oradata\cg4\redo02.log') SIZE 51200K,
GROUP 3 ('C:\ORA4G\oradata\cg4\redo03.log') SIZE 51200K
USER SYS IDENTIFIED BY a123 USER SYSTEM IDENTIFIED BY a123;

--describe v$Instance;
-- select INSTANCE_NAME from v$Instance;
-- select NAME from v$DATABASE;

--paso 4
--Correr los archivos C:\ORA\product\11.2.0\dbhome_1\RDBMS\ADMIN


--CON SYS  SQLPLUS SYS/dba as sysdba
START C:\ORA\product\11.2.0\dbhome_1\RDBMS\ADMIN\catalog.sql;
START C:\ORA\product\11.2.0\dbhome_1\RDBMS\ADMIN\catblock.sql;
START C:\ORA\product\11.2.0\dbhome_1\RDBMS\ADMIN\catproc.sql;
START C:\ORA\product\11.2.0\dbhome_1\RDBMS\ADMIN\catoctk.sql;
START C:\ORA\product\11.2.0\dbhome_1\RDBMS\ADMIN\owminst.plb;

--CON SYSTEM SQLPLUS SYSTEM/dba as sysdba
START C:\ORA\product\11.2.0\dbhome_1\sqlplus\admin\pupbld.sql;
START C:\ORA\product\11.2.0\dbhome_1\sqlplus\admin\help\helpbld.sql;
START C:\ORA\product\11.2.0\dbhome_1\sqlplus\admin\help\helpus.sql;