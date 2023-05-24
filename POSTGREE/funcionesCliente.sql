/*22/05/2023 PARA HACER EN POSTGRESQL*/
/*En estos ejercicios ya no está el descuento a nivel de cliente, 
 está en la tabla ofertas*/
drop table if exists ofertas;
create table ofertas (
id_producto int primary key,
descuento decimal(4,2)
);
drop table if exists ivas;
create table ivas (
	id_iva int primary key,
	descripcion varchar(20),
	valor decimal(4,2)
);
drop table if exists productos;
create table productos (
	id_producto int primary key,
	nombre varchar(30),
	precio_base decimal(5,2),
	id_iva int
);
drop table if exists clientes;
create table clientes (
	id_cliente int primary key,
	nombre varchar(30)
);
drop table if exists cab_facturas;
create table cab_facturas (
	id_factura int primary key,
	id_cliente int,
	fecha_hora date
);
drop table if exists lin_facturas;
create table lin_facturas (
	id_factura int,
	id_linea int,
	id_producto int,
	cantidad int,
	primary key (id_factura, id_linea)
);


insert into ivas values (1,'Super Reducido', 4.00);
insert into ivas values (2,'Reducido', 10.00);
insert into ivas values (3,'Normal', 16.00);
insert into ivas values (4,'Lujo', 20.00);

insert into clientes values (1,'Rocío Carrasco');
insert into clientes values (2,'José L. García');
insert into clientes values (3,'Andrés Sánchez');
insert into clientes values (4,'Luisa Palomares');
insert into clientes values (5,'Ana Jiménez');
insert into clientes values (6,'Julio Torres');

insert into productos  values (1, 'Barra de pan', 0.75, 1);
insert into productos  values (2, 'Litro leche', 0.90, 1);
insert into productos  values (3, 'Paquete café', 1.20, 2);
insert into productos  values (4, 'Kg. patatas', 0.60, 2);
insert into productos  values (5, 'Kg. naranjas', 1.50, 3);
insert into productos  values (6, 'Kg. tomates', 1.80, 3);
insert into productos  values (7, 'Pantalón vaquero', 45.50, 4);
insert into productos  values (8, 'Reloj Casio', 22.00, 4);

insert into cab_facturas values (1, 1,'2023-10-01');
insert into cab_facturas values (2, 5,'2023-10-02');
insert into cab_facturas values (3, 1,'2023-10-03');


insert into lin_facturas values (1,1,2, 1);
insert into lin_facturas values (1,2,3, 2);
insert into lin_facturas values (1,3,4, 3);
insert into lin_facturas values (1,4,1, 2);
insert into lin_facturas values (2,1,5, 3);
insert into lin_facturas values (2,2,6, 1);
insert into lin_facturas values (2,3,7, 2);
insert into lin_facturas values (3,1,2, 3);
insert into lin_facturas values (3,2,6, 2);
insert into lin_facturas values (3,3,7, 1);
insert into lin_facturas values (3,4,8, 1);

insert into ofertas  values (5,50);


/*Escribir una función cliente_producto() a la que le paso dos argumentos,
uno es un id_cliente y otro un id_producto y retornará la cantidad total
que ha adquirido de ese producto*/

DROP FUNCTION IF EXISTS cliente_producto;
CREATE or replace FUNCTION cliente_producto(id1 int, id2 int)
RETURNS int as
$$
BEGIN
return (select sum(l.cantidad) from lin_facturas as l
join cab_facturas as c on l.id_factura = c.id_factura
where l.id_producto = id2 and c.id_cliente = id1);
END;
$$ LANGUAGE plpgsql;
select cliente_producto(10, 2);

/*Función productos_iva() que muestre el listado de productos de un determinado
IVA que pasaremos por parámetro ordenados por id_producto.
Devolverá en forma de mensaje el número de productos y en forma de
tabla la lista de productos*/
CREATE or replace FUNCTION productos_iva(id1 int)
RETURNS table ( 
producto int,
bre varchar,
pre decimal (5,2)) AS
$$
DECLARE
var_total int;
BEGIN
select count (*) into var_total from productos where id_iva = id1;
raise notice 'El número total de productos con iva tipo % es: %',
id1, var_total;

return query select id_producto, nombre, precio_base from productos
where id_iva = id1;

END;
$$ LANGUAGE plpgsql;
select productos_iva(2);

