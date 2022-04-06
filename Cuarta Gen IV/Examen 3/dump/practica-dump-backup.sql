
-- 1. Realizar un script que permita generar todos los dias un backup del schema OE y HR
-- Pero del Schema HR a la tabla Empleados solo los empleados que ganan mas de 2000.
-- El nombre del archivo export debara de crearse de manera automatica yyyy_MM_dd.dmp
-- utilizar un archivo .par para generar o ejecutarlo desde un .bat

-- 1. Creacion de los directorios

SQLPLUS SYS/dba as sysdba
CREATE OR REPLACE DIRECTORY backups AS 'C:\ORA\backup'
GRANT READ,WRITE ON DIRECTORY backups TO system;

-- 2. Script para el archivo PAR 
DIRECTORY=backups
CONTENT=DATA_ONLY
SCHEMAS=HR,OE
QUERY=HR.EMPLOYEES:"WHERE SALARY > 2000"


-- 3. archivo bat

:: adapted from http://stackoverflow.com/a/10945887/1810071
@echo off
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
for /f %%x in ('wmic path win32_localtime get /format:list ^| findstr "="') do set %%x
set fmonth=00%Month%
set fday=00%Day%
set hour=%time:~0,2%
set min=%time:~3,2%
set secs=%time:~6,2%

set today=%Year%_%fmonth:~-2%_%fday:~-2%_%hour%_%min%_%secs%.dmp
echo %today%

expdp system/123 PARFILE='D:\Personal\1. Universidad\UH\Cuarta Gen III\uh-oracle\Cuarta Gen IV\Examen 3\dump\respaldo-diario-oehr.par' FILE=%today%
