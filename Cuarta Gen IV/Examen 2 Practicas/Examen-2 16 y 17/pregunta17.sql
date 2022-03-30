-- Utilizando RMAN realice lo que se le solicita a continuación, adjunte la evidencia en un archivo de Word.

-- 1. Realizar un respaldo total de la base de datos mediante RMAN con un tag " Completo "      
    BACKUP AS BACKUPSET TAG'COMPLETO' DATABASE;

-- 2. Realice un backup del tablespace USERS asígnele un TAG llamado TBS_USERS y comprima el backup      
    BACKUP AS COMPRESSED BACKUPSET TAG 'TBS_USERS' TABLESPACE USERS;


-- 3. Realice un backup incremental, coloque el TAG ‘INCREMENTAL UH'
    backup incremental level 0 tag 'INCREMENTAL UH' database;


-- 4. Crear un tablespace llamado DATOS con un datafile DATOS01.DBF      
          Create tablespace DATOS 
            datafile 'C:\ORA\oradata\orcl\DATOS01.DBF' 
            size 10M 
            EXTENT MANAGEMENT LOCAL AUTOALLOCATE;


-- 5. Hacer copia de la tabla hr.employees al tablespace DATOS
    ALTER TABLE HR.EMPLOYEES MOVE TABLESPACE DATOS;

-- 6. Configurar la politica de retencion a 5 días
    CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 5 DAYS;


-- 7. Hacer RESPALDO del tablespace DATOS TAG 'tbs datos'  
    BACKUP AS BACKUPSET TAG 'tbs_datos' TABLESPACE DATOS;

-- 8. Hacer respaldo de la base de datos completa con un TAG ' -COMPLETE- '      
    BACKUP AS BACKUPSET TAG'-COMPLETE-' DATABASE;


-- 9. Reporte de los backups      
    list backup summary;


-- 10. Corromper el datafile DATOS01.dbf
    alter tablespace DATOS offline;
    --rman
    restore tablespace DATOS;
    recover tablespace DATOS;
    --sql
    alter tablespace DATOS online;


-- 11. Recuperar el DataFile

    alter tablespace DATOS offline;
    --rman
    restore tablespace DATOS;
    recover tablespace DATOS;
    --sql
    alter tablespace DATOS online;

    select TABLE_NAME from DBA_Tables where tablespace_name = 'DATOS';
    -- pasos adicionales de validacion. 
    select status from v$instance;