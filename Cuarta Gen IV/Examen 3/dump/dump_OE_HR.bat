
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

