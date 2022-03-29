SHOW ALL;

CONFIGURE RETENTION POLICY CLEAR;
CONFIGURE RETENTION POLICY NONE;
CONFIGURE RETENTION POLICY 2;

BACKUP DATABASE;
BACKUP AS BACKUPSET DATABASE;

BACKUP AS BACKUPSET TABLESPACE ____;
BACKUP AS BACKUPSET TAG 'TBS SYSTEM' TABLESPACE SYSTEM;

BACKUP AS COMPRESSED BACKUPSET TAG '' TABLESPACE ____;

LIST BACKUP SUMMARY;

BACKUP COMPLETO CON SPFILE Y ARCHIVES
 backup database spfile plus archivelog;

Incremental:
	backup incremental level 0 tablespace users; 
	
	backup incremental level 0 tag �INC_L0� database ;
	backup incremental level 1 for recover of copy tag �INC_L0� database ;

Diferencial:
	backup incremental level 1 tablespace users;

Acumulativo:
	 backup incremental level 1 cumulative tablespace users;

Respaldar los respaldos:
	backup recovery area ;


Borrar todos Backups:
	delete backup;

Ver obsoletos:
	report obsolete;

Eliminar los backups obsoletos:
	delete obsolete;
	delete force noprompt obsolete;


Backup de toda la base de datos:
	 backup database; 

Backup de un tablespace:
	backup tablespace tbs_name;

Backup de un esquema:
	backup user username; 

Reportes o listados:
   report schema;
   list backup summary;
   list backup by datafile;
   list backup of database;
   list backup of archivelog all;
   list backup of controlfile;
   report obsolete ;
   report need backup;

-- Recuperaci�n:
1. Recuperaci�n completa de la base de datos cuando se tiene el controlfile y 
la base de datos est� montada:

RMAN> restore database ;
RMAN> recover database ;

2. Se tiene la situaci�n del caso 1 pero se desea recuperar a un punto pasado en el tiempo:

RMAN> run {set until time = '18-MAR-17 12:00:00';
2> restore database ;
3> recover database ;
4> }


3. Recuperaci�n de un datafile

Identificar el n�mero de datafile:
SQL> select file#, name from v$datafile ;

Poner offline el datafile, ya sea desde SQL*Plus o desde RMAN:
RMAN> sql 'alter database datafile # offline' ;

Recuperar el datafile:
RMAN> run {restore datafile # ;
2> recover datafile 8 ;
3> sql 'alter database datafile # online' ;
4> }


4. Recuperaci�n de un tablespace.

RMAN> run {sql 'alter tablespace users offline' ;
2> restore tablespace users ;
3> recover tablespace users ;
4> sql 'alter tablespace users online' ;
5> }


SCRIPT 
RMAN> RUN
2> {
3> ALLOCATE CHANNEL CH1 DEVICE TYPE DISK
4>  FORMAT '/mount/copy01/prod/oracle/prod/incr/%d_HOT_%M%D%Y_%p_%s';
5>  BACKUP AS COMPRESSED BACKUPSET
6>  INCREMENTAL LEVEL = 0
7>  DATABASE TAG prod_HOTINCR_1124_2321;
8>  BACKUP FORMAT '/mount/copy01/prod/oracle/prod/control/%d_%M_%D_%Y_%t.ctl'
9>  CURRENT CONTROLFILE
10>  TAG prod_CONTROLFILE_1124_2321;
11>  BACKUP AS COMPRESSED BACKUPSET ARCHIVELOG ALL TAG prod_ARCH_1124_2321 DELETE INPUT;
12>  BACKUP SPFILE;
13> }



Recuperar Datafile:
list backup of tablespace system;
shutdown abort;
startup mount;
RMAN> restore datafile 1;

SQL> 
select
 file#,checkpoint_change#, status, recover 
from
 v$datafile_header;

recover datafile 1;

SQL>
alter
 database open;
Database altered.



SQLPLUS:

SELECT OPERATION, STATUS, MBYTES_PROCESSED, START_TIME, END_TIME from V$RMAN_STATUS;