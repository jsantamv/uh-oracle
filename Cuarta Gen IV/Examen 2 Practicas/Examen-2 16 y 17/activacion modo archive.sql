-- Ver pagina https://orasite.com/tutoriales/instalacion/configurar-base-datos-modo-archivelog

--Activación del modo archivelog
--Para que el modo archivelog esté activado, el init.ora debe de estar arrancado con los siguientes parámetros.
log_archive_start = true
log_archive_dest_1 = "location=/database/archivelog/bbdd REOPEN=5"
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