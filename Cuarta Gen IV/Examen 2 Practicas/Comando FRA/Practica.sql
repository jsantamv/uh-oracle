-- 1. Configurar el FRA

--Primero activar el modo ARCHIVELOG

SQLPLUS SYS/dba as sysdba

--Con esto validamos
archive log list;

-- 2. Espacio de 500 megas.
alter system set DB_RECOVERY_FILE_DEST_SIZE=1024m scope = both;
alter system set DB_RECOVERY_FILE_DEST='C:\ORA\archivelog' scope = both;
alter system set ARCHIVE_LAG_TARGET = 600;

3-- Realizar un full backup
rman target /

backup database spfile plus archivelog;


