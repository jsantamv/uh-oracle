
--Este querie nos ayuda a ver cual es archivo del trace. 
SELECT lower(sys_context('userenv','instance_name')) || '_ora_' || p.spid || '.trc' AS trace_file
FROM v$session s, v$process p
WHERE s.paddr = p.addr
AND s.sid = 66
AND s.serial# = 331

-- Activar el trace a la sesión hacer un par de consultas 
-- Identificar el archivo trace y hacerle el TKPROF.
-- System y la otra con HR

Select USERNAME,sid,SERIAL# from v$session WHERE USERNAME IS NOT NULL;

Exec dbms_system.set_sql_trace_in_session(66,331,true);

SELECT lower(sys_context('userenv','instance_name')) || '_ora_' || p.spid || '.trc' AS trace_file
FROM v$session s, v$process p
WHERE s.paddr = p.addr
AND s.sid = 66
AND s.serial# = 331

Exec dbms_system.set_sql_trace_in_session(66,331,false);

--para ubicar la ruta
-- select SID, SERIAL#,mACHINE,TERMINAL,PROGRAM 
-- FROM SYS.V_$SESSION 
-- WHERE USERNAME = 'SYSTEM';

--ubicamos la ruta
Show parameter dump

TKPROF ora11gdeskto_ora_17768.trc trace_tuanis.txt