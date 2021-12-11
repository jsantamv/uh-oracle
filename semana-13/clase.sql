
--Creacion del schema
CREATE USER OE IDENTIFIED BY password;

GRANT conect, resource, CREATE TABLE TO OE;

SELECT username, account_status FROM dba_users WHERE username = 'OE';
ALTER USER OE IDENTIFIED BY 123;


---------------< EJERCICIO >----------------------
-- Un clúster con la información de las tablas del Schema del OE
-- Ordenes detalle de las órdenes. Y tratar de meter una tercer tabla Cliente.

------------< --Crea una tabla cliente > -------------------------
CREATE CLUSTER c_clientes(customer_id number(10)) SIZE 512;
CREATE INDEX IDX_ORDER_ID ON CLUSTER c_clientes;
CREATE table cliente(customer_id number(10), customer_name varchar2(100)) cluster  c_clientes (customer_id);

------------< --Crea una tabla Ordenes > -------------------------
CREATE CLUSTER c_ordenes(order_id number(10)) SIZE 512;
CREATE INDEX IDX_ORDENES_ID ON CLUSTER c_ordenes;

CREATE table ordenes(order_id number(10),customer_number number) CLUSTER c_ordenes  (order_id);
CREATE table ordenes_detalle(order_id number(10), order_line varchar2(100)) cluster  c_ordenes  (order_id);


--REVISION DE LA VISTAS
SELECT TABLESPACE_NAME, CLUSTER_NAME,PCT_FREE FROM dba_clusters;


-- Una tabla ORDENES quedaria con un solo cluster. No se puede crear un segundo CLUSTER

