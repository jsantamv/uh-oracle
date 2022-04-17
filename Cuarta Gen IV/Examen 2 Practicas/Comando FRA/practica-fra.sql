-- 1. Configurar el FRA

      --Primero activar el modo ARCHIVELOG
      SQLPLUS SYS/123 as sysdba

      --Con esto validamos si estamos en modo archive
      archive log list;

-- 2. Espacio de 500 megas.
      alter system set DB_RECOVERY_FILE_DEST_SIZE=5024m scope = both;
      
      alter system set DB_RECOVERY_FILE_DEST='C:\ora\archivelog\dbserv01' scope = both;
      ALTER SYSTEM SET LOG_ARCHIVE_DEST_1 ='LOCATION=USE_DB_RECOVERY_FILE_DEST';

-- 3 Configurar en arc cada 10 min
      alter system set ARCHIVE_LAG_TARGET = 3600;

-- 4 Crear un full back UP
      SET ORACLE_SID=DBSERV01
      rman target /

      backup database spfile plus archivelog;

-- 5 Crear un Table Space (TE) llamadio TBS_PRUEBAS 
-- con un Data File (DF) llamado Pruebas.dbf tamano de 10 megas
      -- DROP TABLESPACE TBS_PRUEBAS INCLUDING CONTENTS AND DATAFILES;{xtypo_code}
      Create tablespace TBS_PRUEBAS 
            datafile 'C:\ORA\oradata\orcl\Pruebas.dbf' 
            size 10M 
            EXTENT MANAGEMENT LOCAL AUTOALLOCATE;

-- 6 Crear tabla eEstudiantes en TE TBS_PRUEBAS  cedula varchar(20) nombre varchar(20)

      CREATE TABLE ESTUDIANTES (
            cedula varchar(20),
            nombre varchar(20)
      ) TABLESPACE TBS_PRUEBAS;

      -- para validar que la tabla se crea en el etable space
      select TABLE_NAME from DBA_Tables where tablespace_name = 'TBS_PRUEBAS';

-- 7 Realizar backup del TE con TAG: tbs_pruebas_bk -- lo vamos a comprimir
      BACKUP AS COMPRESSED BACKUPSET TAG 'tbs_pruebas_bk' TABLESPACE TBS_PRUEBAS;
      backup incremental level 0 tablespace TBS_PRUEBAS; 
      BACKUP TAG 'TBS_PRUEBAS_bk2' TABLESPACE TBS_PRUEBAS INCLUDE CURRENT CONTROLFILE;

      --validamos la lista de 
      list backup summary;

-- 8 Realizar un Incremental de la base de datos. 

      backup incremental level 0 tag 'INC_ORCL' database;

-- 9 Corrompa el TE TBS_PRUEBAS y pruebe que realmente lo corrompio
      --limpiamos el cache
      alter system flush buffer_cache;
      -- para validar que la tabla se crea en el etable space
      select TABLE_NAME from DBA_Tables where tablespace_name = 'TBS_PRUEBAS';
      -- pasos adicionales de validacion. 
      select status from v$instance;

      --STARTUP NOMOUNT;
	SHUTDOWN IMMEDIATE;
	STARTUP MOUNT;
      ALTER DATABASE OPEN;

      --validamos la lista de 
      list backup summary;


-- 10 Restaure y recupere el TE tbs_pruebas
      --sql
      alter tablespace TBS_PRUEBAS offline
      --rman
      restore tablespace TBS_PRUEBAS;
      recover tablespace TBS_PRUEBAS;
      --sql
      alter tablespace TBS_PRUEBAS online;

-- 11 muestre la informacion de los backups realizados
      list backup summary;

-- 12 Realice otro backup completo con el TAG: Full_BACKUP
      BACKUP DATABASE TAG = 'Full_backup';

      backup incremental level 0 tag 'Full_BACKUP' database;

-- 13 Borre el backup hecho en el paso 4
      report obsolete;
      delete force noprompt obsolete;
      
      list backup summary;
      DELETE BACKUPSET 23;
      saca el numero del backup que quiere eliminar




