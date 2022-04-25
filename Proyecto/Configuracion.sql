 -------------------------------------------------------------------------
--					    SERVIDOR PRINCIPAL                              --
--------------------------------------------------------------------------
0. Crear la base de datos
1. Modo archive
2. create pfile from spfile

3. rman 
   RMAN> backup database plus archivelog;
   RMAN> copy current controlfile for standby to '/u01/app/oracle/bkp/stndby_ctrl01.ctl';
   
4. Enviarlos al servidor de stand by. 
 
 create spfile from pfile='C:\CuartaGeneracionIV\BDProyecto\DBSERV01\admin\DBSERV01\pfile\init.ora'
 -------------------------------------------------------------------------
-					PARA RESTAURAR 	servidor PRINCIPAL A PATA            -
--------------------------------------------------------------------------

--paso 1 en el CMD
oradim -NEW -SID DBSERV01 -STARTMODE manual -PFILE "C:\CuartaGeneracionIV\BDProyecto\DBSERV01\admin\DBSERV01\pfile\init.ora"
SET ORACLE_SID=DBSERV01

sqlplus /nolog
conn /as sysdba
startup nomount pfile='C:\CuartaGeneracionIV\BDProyecto\DBSERV01\admin\DBSERV01\pfile\init.ora';
   
--paso 3 Creacion de la base de datos.
CREATE DATABASE DBSERV01
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
DATAFILE 'C:\CuartaGeneracionIV\BDProyecto\DBSERV01\oradata\DBSERV01\system01.dbf' SIZE 700M REUSE AUTOEXTEND ON NEXT 10240K MAXSIZE UNLIMITED
EXTENT MANAGEMENT LOCAL
SYSAUX DATAFILE 'C:\CuartaGeneracionIV\BDProyecto\DBSERV01\oradata\DBSERV01\sysaux01.dbf' SIZE 600M REUSE AUTOEXTEND ON NEXT 10240K MAXSIZE UNLIMITED
SMALLFILE DEFAULT TEMPORARY TABLESPACE TEMP TEMPFILE 'C:\CuartaGeneracionIV\BDProyecto\DBSERV01\oradata\DBSERV01\temp01.dbf' SIZE 20M REUSE AUTOEXTEND ON NEXT 640K MAXSIZE UNLIMITED
SMALLFILE UNDO TABLESPACE "UNDOTBS1" DATAFILE 'C:\CuartaGeneracionIV\BDProyecto\DBSERV01\oradata\DBSERV01\undotbs01.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT 5120K MAXSIZE UNLIMITED
CHARACTER SET WE8MSWIN1252
NATIONAL CHARACTER SET AL16UTF16
LOGFILE GROUP 1 ('C:\CuartaGeneracionIV\BDProyecto\DBSERV01\oradata\DBSERV01\redo01.log') SIZE 51200K,
GROUP 2 ('C:\CuartaGeneracionIV\BDProyecto\DBSERV01\oradata\DBSERV01\redo02.log') SIZE 51200K,
GROUP 3 ('C:\CuartaGeneracionIV\BDProyecto\DBSERV01\oradata\DBSERV01\redo03.log') SIZE 51200K
USER SYS IDENTIFIED BY admin USER SYSTEM IDENTIFIED BY admin;

CONN SYS as sysdba

START C:\ORACLE\product\11.2.0\dbhome_1\RDBMS\ADMIN\catalog.sql
START C:\ORACLE\product\11.2.0\dbhome_1\RDBMS\ADMIN\catblock.sql
START C:\ORACLE\product\11.2.0\dbhome_1\RDBMS\ADMIN\catproc.sql
START C:\ORACLE\product\11.2.0\dbhome_1\RDBMS\ADMIN\catoctk.sql
START C:\ORACLE\product\11.2.0\dbhome_1\RDBMS\ADMIN\owminst.plb

conn SYSTEM/admin

START C:\ORACLE\product\11.2.0\dbhome_1\sqlplus\admin\pupbld.sql;
START C:\ORACLE\product\11.2.0\dbhome_1\sqlplus\admin\help\hlpbld.sql;
START C:\ORACLE\product\11.2.0\dbhome_1\sqlplus\admin\help\helpus.sql;


-------------------------------------------------------------------------
-------------------------------------------------------------------------
-				PREPARAR ARCHIVOS SERVER << PRINCIPAL >>        		-
-------------------------------------------------------------------------
-------------------------------------------------------------------------
SET ORACLE_SID=DBSERV01
---SQL PLUS: esto es el control file que requiere para stanby
SHUTDOWN IMMEDIATE
startup mount
ALTER DATABASE CREATE STANDBY CONTROLFILE AS '/oracle/dbs/stbycf.ctl';

-------------------------------------------------------------------------
-------------------------------------------------------------------------
-				PARA RESTAURAR 	SERVER << STANDBY >>	                -
-------------------------------------------------------------------------
-------------------------------------------------------------------------
------------------------------------< sqlplus >--------------------------
SHUTDOWN IMMEDIATE
startup nomount pfile='C:\CuartaGeneracionIV\BDProyecto\DBSERV01\admin\DBSERV01\pfile\init.ora';

------------------------------------< rman >--------------------------
restore controlfile from 'C:\Users\jsant\Downloads\STNDBY_CTRL02.CTL';

------------------------------------< sqlplus >--------------------------
ALTER DATABASE MOUNT STANDBY DATABASE;

------------------------------------< rman >--------------------------                    
catalog start with 'C:\CuartaGeneracionIV\BDProyecto\DBSERV01\archive\BACKUPSET\2022_04_17\';

restore database;
​
recover database;
------------------------------------< sqlplus >--------------------------
alter database activate standby database;
alter DATABASE OPEN READ ONLY;

----------------------< EN CASO DE ... >------------------------------------
--ALTER DATABASE RECOVER MANAGED STANDBY DATABASE  DISCONNECT FROM SESSION;
--alter database open resetlogs;
--alter database activate standby database;
----------------------------------------------------------------------------


-------------------------------------------------------------------------
-------------------------------------------------------------------------
-				PARA RESTAURAR 	SERVER << PRINCIPAL >>	                -
-------------------------------------------------------------------------
-------------------------------------------------------------------------


--SERVER STANDBY EN RMAN
backup as copy datafile 1 format 'C:\CuartaGeneracionIV\BK_DATAFILE\%U.rman';

--SERVER PRAL RMAN
catalog datafilecopy '/home/oracle/backup/data_D-DG10G_I-3174575825_TS-SYSTEM_FNO1_1akc44pg.rman';
restore datafile 1
recover datafile 1;

select file_id, status, blocks, tablespace_name, user_blocks, from dba_data_files;



--------------------------------------------------------------------------------------
--- ESTO ES PARA PONER LA STANDBY TO PRINCIPAL.
--ALTER DATABASE COMMIT TO SWITCHOVER TO PHYSICAL STANDBY;
RECOVER MANAGED STANDBY DATABASE FINISH;
alter database commit to switchover to primary with session shutdown;
ALTER DATABASE OPEN;
--ALTER DATABASE COMMIT TO SWITCHOVER TO PRIMARY;

