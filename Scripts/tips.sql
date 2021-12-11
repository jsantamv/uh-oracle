SELECT * FROM DBA_Objects WHERE rownum <= 10 AND OBJECT_name = 'EMPLOYEES2';
SELECT * FROM DBA_SEGMENTS WHERE rownum <=10;

SELECT * FROM EMPLOYEES2



alter database close;
Database altered.

select open_mode from v$database;

OPEN_MODE
--------------------
MOUNTED

alter database dismount;

Database altered.

select open_mode from v$database;
select open_mode from v$database



---Conectarse como sys en sqlplus
SQLPLUS SYS/dba as sysdba

--para mayor espacion en la pantalla
set linesize 200

--desbloquear el usuario OE
ALTER USER OE IDENTIFIED BY password ACCOUNT UNLOCK;

------------------------------------------------------------
--Creacion del schema
CREATE USER OE IDENTIFIED BY password;

GRANT conect, resource, CREATE TABLE TO OE;

SELECT username, account_status FROM dba_users WHERE username = 'OE';
ALTER USER OE IDENTIFIED BY 123;