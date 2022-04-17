
-- 1 poner en modo archive 
shutdown immediate
archive log start;

alter database archivelog;
create spfile from pfile='C:\proyectooracle\admin\DBSERV01\pfile\init.ora'

--alter database open;
startup mount
show parameter spfile;
alter system set db_recovery_file_dest_size=1G SCOPE=BOTH;

alter system set DB_RECOVERY_FILE_DEST='C:\proyectooracle\archive' scope=both;

alter system set archive_lag_target = 600;
select log_mode from v$database;

--tnsnames

DBSERV01 =
(DESCRIPTION = (ADDRESS = (PROTOCOL = tcp)(HOST = localhost )(PORT = 1521)) (CONNECT_DATA = (SID = DBSERV01)))

DBSERST1 =
(DESCRIPTION = (ADDRESS = (PROTOCOL = tcp)(HOST = 172.31.202.49 )(PORT = 1521)) (CONNECT_DATA = (SID = DBSERV01)))


alter system set log_archive_config='dg_config=(DBSERV01,DBSERST1)' scope=both;


alter system set log_archive_dest_1='location=C:\proyectooracle\archive valid_for=(all_logfiles,all_roles) db_unique_name=DBSERV01' scope=both;

---log_archive_dest_2 parameter defines the archive destination of standby
--- ASYNC - This is used for maximum performance mode(DEFAULT) .Means redo logs generated in primary need not be shipped/applied in standby
--- paso que no vamos hacer. 
alter system set log_archive_dest_2='SERVICE=PRODSBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=PRODSBY' scope=BOTH;

alter system set log_archive_dest_state_2='ENABLE' scope=BOTH;
alter system set log_archive_dest_state_1='ENABLE' scope=BOTH;

--- Tns entry name for primary
alter system set fal_client='PROD' scope=BOTH;

--- tns entry name for primary -- i.e It will fetch the archives from standby .
alter system set fal_server='PRODSBY' scope=BOTH;



alter system set log_archive_dest_2='SERVICE=DBSERST1 LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=DBSERST1' scope=BOTH;
alter system set log_archive_dest_state_2='ENABLE' scope=BOTH;
alter system set log_archive_dest_state_1='ENABLE' scope=BOTH;


alter system set fal_client='DBSERV01' scope=BOTH;


alter system set fal_server='DBSERST1' scope=BOTH;




