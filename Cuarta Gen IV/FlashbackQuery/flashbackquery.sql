-- Configurando la base de datos
-- SET ORACLE_SID=cg4 en caso de que queramos estar en otro squema
SQLPLUS SYS/dba as sysdba
Show parameter spfile

--FLASHBACK QUERY CONFG

Alter system set undo_management=auto scope=spfile;
Alter system set undo_retention=3600;
Grant flashback any table to SCOTT;

--Configurando Oralce FlashBack Transaction QUERY
alter database add supplemental log data;
GRANT THE SELECT ANY TRANSACTION PRIVILEGE; --- NO SE

CREATE TABLE EMPLEADO (
     EMPNO  NUMBER(10)  NOT NULL
    ,EMPNAME    VARCHAR2(16) NOT NULL
    ,SALARY NUMBER NOT NULL
    ,constraint PK_EMPNO Primary Key (EMPNO)
);

INSERT INTO EMPLEADO(EMPNO,EMPNAME,SALARY) VALUES (111,'MIKE',555);
COMMIT WORK;

CREATE TABLE DEPTO (
     DEPTONO  NUMBER(10)  NOT NULL
    ,NAME    VARCHAR2(32) NOT NULL    
    ,constraint PK_DEPTONO Primary Key (DEPTONO)
);

INSERT INTO DEPTO(DEPTONO,NAME) VALUES (10,'Accounting ');
COMMIT WORK;

-- 2.	Suponga que por error vamos a eliminar el empleado 111 de la tabla emp después de haber realizado una actualización:
    -- 2.1	Actualice el salario del empleado 111, incremente el salario en $100
    -- 2.2	Inserte otro departamento llamado Finance con código 20
    -- 2.3	Elimine el empleado 111
-- Confirme las transacciones.

update EMPLEADO set SALARY = 100 where EMPNO = 111;
INSERT INTO DEPTO(DEPTONO,NAME) VALUES (20,'Finance ');
delete EMPLEADO where EMPNO = 111;
COMMIT;


-- 3.	Inserte un nuevo empleado llamado Tom con salario 777 y código 111
-- Actualice el salario de ese empleado 111 incrementando el salario en $100
-- Vuelva a incrementar el salario del empleado 111 en $50
-- Confirme las transacciones

INSERT INTO EMPLEADO(EMPNO,EMPNAME,SALARY) VALUES (111,'Tom',777);
update EMPLEADO set SALARY = 100 where EMPNO = 111;
update EMPLEADO set SALARY = 150 where EMPNO = 111;
COMMIT;
select * from EMPLEADO;

-- El administrador detecta un error en la aplicación y debe diagnosticar el problema. 
-- 4.	Realice un query mediante Oracle Flashback Version Query para obtener las operaciones realizadas sobre el empleado 111

SELECT versions_starttime
     , versions_endtime
     , versions_xid
     , versions_operation
     , salary
FROM EMPLEADO versions BETWEEN timestamp minvalue AND maxvalue where EMPNO = 111 ORDER BY VERSIONS_STARTTIME;

SELECT versions_startscn
     , versions_starttime
     , versions_endscn
     , versions_endtime/
     , versions_xid
     , versions_operation
     , EMPNAME  
FROM   EMPLEADO 
       VERSIONS BETWEEN TIMESTAMP TO_TIMESTAMP('2022-02-08 21:18:00', 'YYYY-MM-DD HH24:MI:SS')
                        AND TO_TIMESTAMP('2022-02-08 21:30:00', 'YYYY-MM-DD HH24:MI:SS')
WHERE  EMPNO = 111
order by versions_endtime desc;


SELECT versions_startscn
     , versions_xid
     , versions_operation
     , EMPNAME
     , SALARY  
     , versions_starttime
     , versions_endtime
FROM   EMPLEADO 
       VERSIONS BETWEEN TIMESTAMP TO_TIMESTAMP('2022-02-08 21:18:00', 'YYYY-MM-DD HH24:MI:SS')
                        AND TO_TIMESTAMP('2022-02-08 21:30:00', 'YYYY-MM-DD HH24:MI:SS')
WHERE  EMPNO = 111
order by versions_endtime desc;

set linesize 300;


-- El resultado obtenido se muestra en forma descendente cronológicamente. 
-- 5.	Identifique cual es la transacción errónea mediante el xid 
--      y extraiga el XID el SCN con que comenzó, el commit, la operación 
--      dml que se realizó, el usuario y la sentencia SQL

-- xid= 04001600D2020000
-- scn=1409841


SELECT xid, operation, start_scn, commit_scn, logon_user, undo_sql
FROM flashback_transaction_query
WHERE xid = HEXTORAW('0A000D004D070000');

SELECT xid, logon_user
FROM flashback_transaction_query
WHERE xid IN (
  SELECT versions_xid FROM EMPLEADO VERSIONS BETWEEN TIMESTAMP
  TO_TIMESTAMP('2022-02-08 21:18:00', 'YYYY-MM-DD HH24:MI:SS') AND
  TO_TIMESTAMP('2022-02-08 21:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

no tengo permisos
