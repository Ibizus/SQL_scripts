drop table if exists empleados;
drop table if exists proveedores;
drop table if exists categorias;
drop table if exists clientes;
drop table if exists pedidos;
drop table if exists detalle_ordenes;
drop table if exists productos;
drop table if exists reposiciones;

CREATE TABLE EMPLEADOS(
EMPLEADO_ID int NOT NULL PRIMARY KEY,
NOMBRE char(30) NULL,
APELLIDO char(30) NULL,
FECHA_NAC date NULL,
REPORTA_A int NULL,
EXT int NULL);

CREATE TABLE PROVEEDORES(
PROVEEDOR_ID int NOT NULL PRIMARY KEY,
NOMBREPROV char(50) NOT NULL,
CONTACTO char(50) NOT NULL,
CELUPROV char(12) NULL,
FIJOPROV char(12) NULL);

CREATE TABLE CATEGORIAS(
CATEGORIA_ID int NOT NULL PRIMARY KEY,
NOMBRECAT char(50) NOT NULL);

CREATE TABLE CLIENTES(
CLIENTE_ID int NOT NULL PRIMARY KEY,
CEDULA_RUC char(10) NOT NULL,
NOMBRECIA char(30) NOT NULL,
NOMBRECONTACTO char(50) NOT NULL,
DIRECCIONCLI char(50) NOT NULL,
FAX char(12) NULL,
EMAIL char(50) NULL,
CELULAR char(12) NULL,
FIJO char(12) NULL);

CREATE TABLE PEDIDOS(
PEDIDO_ID int NOT NULL PRIMARY KEY,
EMPLEADO_ID int NOT NULL,
CLIENTE_ID int NOT NULL,
FECHAPEDIDO date NOT NULL,
DESCUENTO int NULL);

CREATE TABLE DETALLE_ORDENES(
PEDIDO_ID int NOT NULL,
DETALLE_ID int NOT NULL,
PRODUCTO_ID int NOT NULL,
CANTIDAD int NOT NULL,
PRIMARY KEY (PEDIDO_ID,DETALLE_ID ));

CREATE TABLE PRODUCTOS(
PRODUCTO_ID int NOT NULL PRIMARY KEY,
PROVEEDOR_ID int NOT NULL,
CATEGORIA_ID int NOT NULL,
DESCRIPCION char(50) NULL,
PRECIOUNIT numeric NOT NULL,
EXISTENCIA int NOT NULL );

CREATE TABLE reposiciones(
PRODUCTO_ID int NOT NULL PRIMARY KEY,
cantidad_pedida int);

select*from detalle_ordenes;

/* CARGA INICIAL DE LA BD  */
insert into categorias values (100, 'CARNICOS');
insert into categorias values (200, 'LACTEOS');
insert into categorias values (300, 'LIMPIEZA');
insert into categorias values (400, 'HIGINE PERSONAL');
insert into categorias values (500, 'MEDICINAS');
insert into categorias values (600, 'COSMETICOS');
insert into categorias values (700, 'REVISTAS');

insert into proveedores values 
(10, 'DON DIEGO', 'MANUEL ANDRADE', '099234567','2124456');
insert into proveedores values 
(20, 'PRONACA', 'JUAN PEREZ', '0923434467','2124456');
insert into proveedores values 
(30, 'TONY', 'JORGE BRITO', '099234567','2124456');
insert into proveedores values 
(40, 'MIRAFLORES', 'MARIA PAZ', '098124498','2458799');
insert into proveedores values 
(50, 'ALMAY', 'PEDRO GONZALEZ', '097654567','2507190');
insert into proveedores values 
(60, 'REVLON', 'MONICA SALAS', '099245678','2609876');
insert into proveedores values 
(70, 'YANBAL', 'BETY ARIAS', '098124458','2450887');
insert into proveedores values 
(120, 'JURIS', 'MANUEL ANDRADE', '099234567','2124456');
insert into proveedores values 
(80, 'CLEANER', 'MANUEL ANDRADE', '099234567','2124456');
insert into proveedores values 
(90, 'BAYER', 'MANUEL ANDRADE', '099234567','2124456');
insert into proveedores values 
(110, 'PALMOLIVE', 'MANUEL ANDRADE', '099234567','2124456');

INSERT INTO PRODUCTOS VALUES (1,10,100,'SALCHICHAS VIENESAS',2.60,200);
INSERT INTO PRODUCTOS VALUES (2,10,100,'SALAMI DE AJO',3.60,300);
INSERT INTO PRODUCTOS VALUES (3,10,100,'BOTON PARA ASADO',4.70,400);
INSERT INTO PRODUCTOS VALUES (4,20,100,'SALCHICHAS DE POLLO',2.90,200);
INSERT INTO PRODUCTOS VALUES (5,20,100,'JAMON DE POLLO',2.80,100);
INSERT INTO PRODUCTOS VALUES (6,30,200,'YOGURT NATURAL',4.30,80);
INSERT INTO PRODUCTOS VALUES (7,30,200,'LECHE CHOCOLATE',1.60,90);
INSERT INTO PRODUCTOS VALUES (8,40,200,'YOGURT DE SABORES',1.60,200);
INSERT INTO PRODUCTOS VALUES (9,40,200,'CREMA DE LECHE',3.60,30);
INSERT INTO PRODUCTOS VALUES (10,50,600,'BASE DE MAQUILLAJE',14.70,40);
INSERT INTO PRODUCTOS VALUES (11,50,600,'RIMMEL',12.90,20);
INSERT INTO PRODUCTOS VALUES (13,60,600,'SOMBRA DE OJOS',9.80,100);
-- set datestyle to dmy;

INSERT INTO EMPLEADOS VALUES (1,'JUAN', 'CRUZ', '18/01/67',null, 231);
INSERT INTO EMPLEADOS VALUES (2,'MARIO', 'SANCHEZ', '01/03/79',1,144);
INSERT INTO EMPLEADOS VALUES (3,'VERONICA', 'ARIAS', '23/06/77',1, 234);
INSERT INTO EMPLEADOS VALUES (4,'PABLO', 'CELY', '28/01/77',2, 567);
INSERT INTO EMPLEADOS VALUES (5,'DIEGO', 'ANDRADE', '15/05/70',2, 890);
INSERT INTO EMPLEADOS VALUES (6,'JUAN', 'ANDRADE', '17/11/76',3, 230);
INSERT INTO EMPLEADOS VALUES (7,'MARIA', 'NOBOA', '21/12/79',3, 261);

INSERT INTO CLIENTES VALUES (1,'1890786576','SUPERMERCADO ESTRELLA','JUAN ALBAN','AV.AMAZONAS',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (2,'1298765477','EL ROSADO','MARIA CORDERO','AV.AEL INCA',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (3,'1009876567','DISTRIBUIDORA PRENSA','PEDRO PINTO','EL PINAR',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (4,'1876090006','SU TIENDA','PABLO PONCE','AV.AMAZONAS',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (5,'1893456776','SUPERMERCADO DORADO','LORENA PAZ','AV.6 DICIEMBRE',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (6,'1678999891','MI COMISARIATO','ROSARIO UTRERAS','AV.AMAZONAS',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (7,'1244567888','SUPERMERCADO DESCUENTO','LETICIA ORTEGA','AV.LA PRENSA',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (8,'1456799022','EL DESCUENTO','JUAN TORRES','AV.PATRIA',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (9,'1845677777','DE LUISE','JORGE PARRA','AV.AMAZONAS',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (10,'183445667','YARBANTRELLA','PABLO POLIT','AV.REPUBLICA',NULL,NULL,NULL,NULL);

INSERT INTO PEDIDOS VALUES(1,3,4,'17/06/07', 5);
INSERT INTO PEDIDOS VALUES(2,3,4,'02/06/07', 10);
INSERT INTO PEDIDOS VALUES(3,4,5,'05/06/07', 6);
INSERT INTO PEDIDOS VALUES(4,2,6,'06/06/07', 2);
INSERT INTO PEDIDOS VALUES(5,2,7,'09/06/07', NULL);
INSERT INTO PEDIDOS VALUES(6,4,5,'12/06/07', 10);
INSERT INTO PEDIDOS VALUES(7,2,5,'14/06/07', 10);
INSERT INTO PEDIDOS VALUES(8,3,2,'13/06/07', 10);
INSERT INTO PEDIDOS VALUES(9,3,2,'17/06/07', 3);
INSERT INTO PEDIDOS VALUES(10,2,2,'18/06/07', 2);

INSERT INTO DETALLE_ORDENES VALUES(1,1,1,2);
INSERT INTO DETALLE_ORDENES VALUES(1,2,4,1);
INSERT INTO DETALLE_ORDENES VALUES(1,3,6,1);
INSERT INTO DETALLE_ORDENES VALUES(1,4,9,1);
INSERT INTO DETALLE_ORDENES VALUES(2,1,10,10);
INSERT INTO DETALLE_ORDENES VALUES(2,2,13,20);
INSERT INTO DETALLE_ORDENES VALUES(3,1,3,10);
INSERT INTO DETALLE_ORDENES VALUES(4,1,9,12);
INSERT INTO DETALLE_ORDENES VALUES(5,1,1,14);
INSERT INTO DETALLE_ORDENES VALUES(5,2,4,20);
INSERT INTO DETALLE_ORDENES VALUES(6,1,3,12);
INSERT INTO DETALLE_ORDENES VALUES(7,1,11,10);
INSERT INTO DETALLE_ORDENES VALUES(8,1,2,10);
INSERT INTO DETALLE_ORDENES VALUES(8,2,5,14);
INSERT INTO DETALLE_ORDENES VALUES(8,3,7,10);
INSERT INTO DETALLE_ORDENES VALUES(9,1,11,10);
INSERT INTO DETALLE_ORDENES VALUES(10,1,1,5);

/*EL PROCEDURE QUE VA DENTRO DE la base de BBDD*/
CREATE OR REPLACE FUNCTION producto_bajominimos()
  RETURNS trigger AS
$BODY$
BEGIN
    IF NEW.existencia < 5 THEN
        INSERT INTO reposiciones VALUES(old.producto_id, 500);
    END IF;
    RETURN NEW;
END;
$BODY$
language plpgsql;

/*Parte del trigger que se le asocia a la tabla y lanza el procedure declarado*/
CREATE TRIGGER producto_bajominimos
  AFTER INSERT
  ON productos
  FOR EACH ROW
  EXECUTE PROCEDURE producto_bajominimos();

update productos set existencia = 3 where producto_id = 1;
select*from reposiciones;