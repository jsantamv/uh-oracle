-- Multiplexar controlfile
-- Les dejo el paso a paso para realizar una copia de controlfile
-- Nota: Para realizar esta actividad es necesario el reinicio del motor de base de datos Oracle


-- 1) Bajar BDD
-- 2) Poner BDD en modo nomount
-- 3) Con rman sacar una copia al controlfile existente 

- rman target / RMAN> restore controlfile to '+FRA/' from '+DATA2/P01/CONTROLFILE/control01.ctl';

--4) Con sqlplus / as sysdba registrar en el spfile el control file nuevo

alter system set control_files='+fra2/P013BANS1/CONTROLFILE/controlfile.ctl','+DATA2/P01/CONTROLFILE/control01.ctl' scope=spfile;

--5) startup force


-- Total System Global Area 3.4360E+11 bytes
-- Fixed Size                  6956784 bytes
-- Variable Size            2.2012E+10 bytes
-- Database Buffers         3.2105E+11 bytes
-- Redo Buffers              529911808 bytes
-- Database mounted.
-- Database opened.

-- 5) Validar

select name from v$controlfile;

-- NAME
-- --------------------------------------------------------------------------------
-- +FRA/P01/CONTROLFILE/control01.ctl
-- +DATA/P01/CONTROLFILE/control01.ctl