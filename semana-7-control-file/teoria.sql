/*----------------< CONTROL FILE > ---------------------
 * - Nombre de la base de datos asociada
 * - Ubicacion fisica dentro del sistema operativo
 * - Tiempo de creacion
 * - Lleva la secuencia de los log (numero de log)
 * - Checkpoint Information
 * - Es binario
 * ----------------------------------------------------*/

-- Etapas MOUNT para Montar la base de datos ==> starup
-- 1. Shutdown
-- 2. Nomount 	--Instace Started
-- 3. Mount   	--Control file opened for this instance
-- 4. Open		--allfiles opened as describied by the control files for this instace

-- Etapas NOMOUNT para des Montar la base de datos ==> shutdown
-- 1. Open		--allfiles opened as describied by the control files for this instace
-- 2. Mount   	--Control file opened for this instance
-- 3. Nomount 	--Instace Started
-- 4. Shutdown

-- Multiplexado: Genere o tener copias del archivo en varios lados. Copia fidedigna. 

--Cuando se crea un control File? 
    -- 1. Cuando se pone erroneo, es poco probable pero es bueno tener copias del control file. 
    -- 2. Redos.log se trabaja por grupos.

select name from v$controlfile;

--------------------------------------------------------------------------------------------
						--< PASOS CREATE CONTROL FILES > --
--------------------------------------------------------------------------------------------

-- 1. hacer una lista de todos los datafiles y online redo log de la base de datos
	-- 1.1 Los redo logs files se basa en la siguiente vista
	SELECT MEMBER FROM "V$LOGFILE"
	-- 1.2 LOS DATAFILES
	SELECT NAME FROM "V$DATAFILE" 
	-- 1.3 LOS PARAMETROS SALEN DE LA VISTA 
	SELECT VALUE FROM V$PARAMETER WHERE NAME = 'control_files';

-- 2. PARA PODER CREAR UNO -- NUEVO -- LA BASE DE DATOS DEBE DE ESTAR SHUTDOWN
	STARTUP NOMOUNT;
	SHUTDOWN IMMEDIATE;

-- 3. Realizamos un backup de todos los data files y los redo log files de la base de datos
	-- copy y paste 
	-- segun las rutas de los paso 1

-- 4. Levatantamos la instacia pero no montada o Open de la base de datos 
	STARTUP NOMOUNT;

-- 5. Creamos un nuevo control file para la base de datos usando el siguiente comando
	CREATE CONTROLFILE -- ESTO EN EL CASO DE QUE NO TENGAMOS UN RESPALDO DEL CONTROL FILE. 	
	--Por lo general en todas las bases de datos no venia multiplexado el control file.
	CREATE CONTROLFILE
	   SET DATABASE prod
	   LOGFILE GROUP 1 ('C:\ORACLEXE\APP\ORACLE\FAST_RECOVERY_AREA\XE\ONLINELOG\O1_MF_2_JNF4DG2X_.LOG',                  
	           GROUP 2 ('C:\ORACLEXE\APP\ORACLE\FAST_RECOVERY_AREA\XE\ONLINELOG\O1_MF_1_JNF4DFX9_.LOG',                   
	   NORESETLOGS
	   DATAFILE '/u01/oracle/prod/system01.dbf' SIZE 3M, --estas rutas son de OS basados en UNIX
	            '/u01/oracle/prod/rbs01.dbs' SIZE 5M,
	            '/u01/oracle/prod/users01.dbs' SIZE 5M,
	            '/u01/oracle/prod/temp01.dbs' SIZE 5M
	   MAXLOGFILES 50
	   MAXLOGMEMBERS 3
	   MAXLOGHISTORY 400
	   MAXDATAFILES 200
	   MAXINSTANCES 6
	   ARCHIVELOG;
	
-- 6. Storage a Backup of the new control File on a offline storage device
	

--------------------------------------------------------------------------------------------
						--< PASOS Backing Up CONTROL FILES > --
--------------------------------------------------------------------------------------------
-- Usar el comando ALTER DATABASE BACKUP CONTROLFILE
	  
--1. Back Up de Control File a un archivo Binario. 
	  ALTER DATABASE BACKUP CONTROLFILE TO 'C:\ORACLEXE\APP\ORACLE\BACKUP\control.bkp';
	 --o puede ser COPY Paste
	 
--2. Produzaca una sentencia SQL que despues puede ser usada para recrear nuestro control file
	 ALTER DATABASE BACKUP CONTROLFILE TO TRACE AS 'C:\ORACLEXE\APP\ORACLE\BACKUP\restore.sql';
	
--3. Donde puedo obtener informacion CONTROL FILE
	SELECT 
		 REMOTE_ARCHIVE
		,OPEN_MODE 
		,OPEN_RESETLOGS 
		,CONTROLFILE_TYPE 		 
	FROM v$database

	select name from v$controlfile;
	select TYPE from v$controlfile_RECORD_SECTION;
	
	-- ME TRAE CUAL ES EL PARAMETRO ASOCIADO AL CONTRO FILE
	-- Y DONDE SE UBICA. 
	SELECT VALUE FROM V$PARAMETER WHERE NAME = 'control_files';  

--------------------------------------------------------------------------------
							--PRACTICA
--------------------------------------------------------------------------------
SHOW parameter control;

SHUTDOWN IMMEDIATE;
STARTUP NOMOUNT;

--Hacer script de base de datos para restaurar
ALTER DATABASE BACKUP CONTROLFILE TO TRACE AS 'C:\ORACLEXE\APP\ORACLE\BACKUP\restore.sql';
-- o pudo ser copy paste.

--hacer un respaldo de la base de datos y/o agregar uno nuevo. 
ALTER DATABASE BACKUP CONTROLFILE TO 'C:\ORACLEXE\APP\ORACLE\BACKUP\control_backup.ctl';

--para modificar el parametro control al que apunta
SHUTDOWN IMMEDIATE;
STARTUP NOMOUNT;
alter system set control_files = 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\CONTROL.DBF','C:\oraclexe\app\oracle\oradata\XE\CTL\CONTROL01.CTL','C:\ORACLEXE\APP\ORACLE\BACKUP\control_backup_03.ctl' scope=spfile;


--En caso de que de error la base de datos basta con poner otra vez el respaldo dentro de la carpeta 
-- XE con el respectivo nombre. 

