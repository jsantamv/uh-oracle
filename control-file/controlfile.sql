
STARTUP NOMOUNT;
SHUTDOWN IMMEDIATE;

select * from DBA_database
 
show parameter control  --Mejor utilizar este parametro para ver mis archivos
SELECT * FROM V$PARAMETER WHERE NAME = 'control_files'; --ojo tener cuidado con las mayusculas. 

--documentacion https://docs.oracle.com/cd/B19306_01/server.102/b14231/control.htm
   
select * from V$LOGFILE;
select * from V$DATAFILE; 


CREATE CONTROLFILE
   SET DATABASE prod
   LOGFILE GROUP 1 ('C:\ORACLEXE\APP\ORACLE\FAST_RECOVERY_AREA\XE\ONLINELOG\O1_MF_2_JNF4DG2X_.LOG',                  
           GROUP 2 ('C:\ORACLEXE\APP\ORACLE\FAST_RECOVERY_AREA\XE\ONLINELOG\O1_MF_1_JNF4DFX9_.LOG',                   
   NORESETLOGS
   DATAFILE '/u01/oracle/prod/system01.dbf' SIZE 3M,
            '/u01/oracle/prod/rbs01.dbs' SIZE 5M,
            '/u01/oracle/prod/users01.dbs' SIZE 5M,
            '/u01/oracle/prod/temp01.dbs' SIZE 5M
   MAXLOGFILES 50
   MAXLOGMEMBERS 3
   MAXLOGHISTORY 400
   MAXDATAFILES 200
   MAXINSTANCES 6
   ARCHIVELOG;
   
   
