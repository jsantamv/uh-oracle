-- Utilice el esquema OE para realizar los ejercicios. 2 pts cada ejercicio correcto. 0 pts incompleto o incorrecto.

-- Recuerde adjuntar evidencia.

-- Inserte en la tabla customers un registro con sus datos, el id del cliente será 999, en el limite de crédito ponga
-- 5000. Confirme los datos
INSERT INTO CUSTOMERS ( CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUST_FIRST_NAME, CUSTOMERS.CUST_LAST_NAME, CUSTOMERS.NLS_LANGUAGE, CUSTOMERS.NLS_TERRITORY, CUSTOMERS.CREDIT_LIMIT, CUSTOMERS.CUST_EMAIL, CUSTOMERS.ACCOUNT_MGR_ID ) 
VALUES ( 999, 'Juan Carlos', 'Santamaria', 'es', 'CENTRAL', 5000, 'jsantamv@gmail.com', 200 )
-- Inserte otro cliente con su nombre, id 888, limite de crédito 2000. Confirme los datos.
INSERT INTO CUSTOMERS ( CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUST_FIRST_NAME, CUSTOMERS.CUST_LAST_NAME, CUSTOMERS.NLS_LANGUAGE, CUSTOMERS.NLS_TERRITORY, CUSTOMERS.CREDIT_LIMIT, CUSTOMERS.CUST_EMAIL, CUSTOMERS.ACCOUNT_MGR_ID ) 
VALUES ( 888, 'Juan Carlos', 'Santamaria', 'es', 'CENTRAL', 2000, 'jsantamv@gmail.com', 200 )
-- Inserte un producto: iPhone 11, id 9999, categoria 11, precio 900, llene los demás datos a su gusto. 
--Confirme los datos.
INSERT INTO PRODUCT_INFORMATION ( PRODUCT_INFORMATION.PRODUCT_ID, PRODUCT_INFORMATION.PRODUCT_NAME, PRODUCT_INFORMATION.PRODUCT_DESCRIPTION, PRODUCT_INFORMATION.CATEGORY_ID, PRODUCT_INFORMATION.WEIGHT_CLASS, PRODUCT_INFORMATION.SUPPLIER_ID, PRODUCT_INFORMATION.PRODUCT_STATUS, PRODUCT_INFORMATION.LIST_PRICE, PRODUCT_INFORMATION.MIN_PRICE, PRODUCT_INFORMATION.CATALOG_URL ) 
		 VALUES ( 9999, 'Iphone 11', 'muy caro para mi gusto', 11, 1, 900, 'orderable', 900, 90, 'http://www.holamundo.com/iphone.html' );

-- Actualice el límite de crédito en 6000 para el cliente 888.
Update CUSTOMERS set CREDIT_LIMIT = 6000 WHERE CUSTOMER_ID = 888;
-- Elimine el cliente 888. Confirme los datos
DELETE FROM CUSTOMERS WHERE CUSTOMER_ID = 888;
-- Inserte nuevamente el cliente 888, con los datos nombre JUAN, limite 3000.
INSERT INTO CUSTOMERS ( CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUST_FIRST_NAME, CUSTOMERS.CUST_LAST_NAME, CUSTOMERS.NLS_LANGUAGE, CUSTOMERS.NLS_TERRITORY, CUSTOMERS.CREDIT_LIMIT, CUSTOMERS.CUST_EMAIL, CUSTOMERS.ACCOUNT_MGR_ID ) 
VALUES ( 888, 'Juan', 'Santamaria', 'es', 'CENTRAL', 3000, 'jsantamv@gmail.com', 200 )
-- Actualice el límite de crédito en un 10% del cliente 888
update CUSTOMERS
set CUSTOMERS.CREDIT_LIMIT = (CUSTOMERS.CREDIT_LIMIT* 0.1)+CUSTOMERS.CREDIT_LIMIT
where CUSTOMERS.CUSTOMER_ID = 888;

select 
 (CUSTOMERS.CREDIT_LIMIT* 0.1)+CUSTOMERS.CREDIT_LIMIT as ho,
 CUSTOMERS.CREDIT_LIMIT
from  CUSTOMERS
where CUSTOMERS.CUSTOMER_ID = 888;
-- Reestablezca y recupere los datos a como estaban en el punto f.
SELECT versions_starttime
     , versions_endtime
     , versions_xid
     , versions_operation
     , CUSTOMERS.CREDIT_LIMIT
FROM CUSTOMERS versions BETWEEN timestamp minvalue AND maxvalue where CUSTOMERS.CUSTOMER_ID = 888 ORDER BY VERSIONS_STARTTIME;
-- Elimine la tabla PRODUCT_DESCRIPTIONS
drop table PRODUCT_DESCRIPTIONS;
-- Recupere la tabla PRODUCT_DESCRIPTIONS
SELECT versions_starttime
     , versions_endtime
     , versions_xid
     , versions_operation
FROM oe.PRODUCT_DESCRIPTIONS versions BETWEEN timestamp minvalue AND maxvalue ORDER BY VERSIONS_STARTTIME;

INSERT INTO PRODUCT_DESCRIPTIONS
	(Select * from PRODUCT_DESCRIPTIONS AS OF TIMESTAMP TO_TIMESTAMP('2022-02-22 21:03')
