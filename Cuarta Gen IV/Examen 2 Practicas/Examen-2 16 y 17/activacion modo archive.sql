-- Ver pagina https://orasite.com/tutoriales/instalacion/configurar-base-datos-modo-archivelog

--Activación del modo archivelog
--Para que el modo archivelog esté activado, el init.ora debe de estar arrancado con los siguientes parámetros.
log_archive_start = true
log_archive_dest_1 = "C:\proyectooracle\archive REOPEN=5"
log_archive_format = arch_%t_%s.arc
log_archive_dest_1= es el destino donde vas a archivar los .arc

--Si la base de datos está funcionando y esos parámetros están en el init.ora paramos la base de datos con un
shutdown immediate
--Previamente habría que haberse conectado a la base de datos sobre la que se quiere realizar el cambio.

--A continuación montamos la base de datos:
startup mount
--Después de haber montado la base de datos ejecutamos el siguiente comando:
alter database archivelog
--Y después abrimos la base de datos:
alter database open
--Para finalizar, activamos el archivado automático:
alter system archive log start
--Con esto ya tendríamos configurado el modo archivelog de una base de datos ORACLE.


-- forma jefffrey
shutdown immediate
archive log start;

alter database archivelog;
create spfile from pfile='C:\proyectooracle\admin\DBSERV01\pfile\init.ora'

--alter database open;
startup mount
alter database archivelog;
show parameter spfile;
alter system set db_recovery_file_dest_size=1G SCOPE=BOTH;
alter system set DB_RECOVERY_FILE_DEST='C:\ora\archive_dbserv01' scope=both;
ALTER SYSTEM SET LOG_ARCHIVE_DEST_1 ='LOCATION=USE_DB_RECOVERY_FILE_DEST';



alter system set db_recovery_file_dest_size=2g SCOPE=BOTH;
alter system set DB_RECOVERY_FILE_DEST='C:\ora\archive_dbserv01' SCOPE = BOTH;
ALTER SYSTEM SET LOG_ARCHIVE_DEST_1 ='LOCATION=USE_DB_RECOVERY_FILE_DEST';



alter system set archive_lag_target = 3600;
select log_mode from v$database;

--tnsnames

PROD =
(DESCRIPTION = (ADDRESS = (PROTOCOL = tcp)(HOST = localhost )(PORT = 1521)) (CONNECT_DATA = (SID = DBSERV01)))

PRODSBY =
(DESCRIPTION = (ADDRESS = (PROTOCOL = tcp)(HOST = 172.31.202.49 )(PORT = 1521)) (CONNECT_DATA = (SID = DBSERV01)))