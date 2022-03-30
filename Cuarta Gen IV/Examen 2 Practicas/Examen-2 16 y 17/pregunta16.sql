--1. Realice un Exp COMPLETO llamado Full_exp.dmp.
    exp system/123 full=y inctype=complete constraints=Y file=C:\ORA\exports\Full_exp.dmp log=C:\ORA\exports\Full_exp.log compress=y

--2. Usando EXP, exporte solo la estructura del esquema OE, adjunte los permisos y constraints, llame al archivo EXP01.dmp    
    exp system/123 owner=OE constraints=y grants=y file=C:\ORA\exports\EXP01.dmp 

--3. Usando IMP, realice la importación de la tabla CUSTOMERS al esquema  scott
    imp system/123 FROMUSER=OE touser=scott ignore=y tables=CUSTOMERS full=n FILE=C:\ORA\exports\EXP01.dmp

--4.  Realice una exportación de los esquemas SCOTT y HR, y luego realice la importación de solo las tablas EMP y DEPT 
--    del esquema SCOTT a un esquema nuevo llamado CG4. Guarde el dmp como EXP04.dmp 

    Exp system/123 owner=OE, SCOTT constraints=y grants=y file=C:\ORA\exports\EXP04.dmp 
    
    SQLPLUS SYS/dba as sysdba
    CREATE USER CG4 IDENTIFIED BY cg4;
    GRANT CONNECT, CREATE TABLE TO CG4;

    imp system/123 FROMUSER=SCOTT touser=CG4 ignore=y tables=EMP, DEPT full=n FILE=C:\ORA\exports\EXP04.dmp


--5. Realice un export incremental tomando como referencia el export realizado en el ejercicio 1.  
    exp userid=system/123 full=y inctype=incremental constraints=Y file= C:\ORA\exports\Full_Incre1.dmp


--Adjunte el word con las 5 respuestas.  2 pts cada respuesta




