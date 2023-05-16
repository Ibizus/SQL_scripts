/*PARA HACER EN POSTGRESQL*/
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
	nombre varchar(30),
	descuento decimal(5,2)
);
drop table if exists compras;
create table compras (
	id_cliente int,
	id_producto int,
	fecha_hora date,
	cantidad int,
	primary key (id_cliente, id_producto, fecha_hora)
);
insert into ivas values (1,'Super Reducido', 4.00);
insert into ivas values (2,'Reducido', 10.00);
insert into ivas values (3,'Normal', 16.00);
insert into ivas values (4,'Lujo', 20.00);

insert into clientes values (1,'Rocío Carrasco', 10.00);
insert into clientes values (2,'José L. García', 0.00);
insert into clientes values (3,'Andrés Sáenchez', 20.00);

insert into productos values (1, 'Barra de pan', 0.75, 1);
insert into productos values (2, 'Litro leche', 0.90, 1);
insert into productos values (3, 'Paquete café', 1.20, 2);
insert into productos values (4, 'Kg. patatas', 0.60, 2);
insert into productos values (5, 'Kg. naranjas', 1.50, 3);
insert into productos values (6, 'Kg. tomates', 1.80, 3);
insert into productos values (7, 'Pantalón vaquero', 45.50, 4);
insert into productos values (8, 'Reloj Casio', 22.00, 4);

insert into compras values (1,1,'2023-10-02', 5);
insert into compras values (1,8,'2023-10-02', 1);
insert into compras values (1,4,'2023-10-02', 2);
insert into compras values (2,1,'2023-10-02', 5);
insert into compras values (2,8,'2023-10-02', 1);
insert into compras values (2,4,'2023-10-02', 2);

/*traza de la creación e inicialización de las tablas*/
select * from ivas;
select * from productos;
select * from clientes;
select * from compras;


/*Programar la función "precio_base_y_con_iva()" que muestre el nombre, el precio base
el valor del iva y el precio con iva del artículo cuyo identificador le paso como argumento
(y realizar la correspondiente llamada a la función para probarla)*/



/*Programar la función "compras_cliente()" que muestre los id_producto, nombres, precios base,
precios con el descuento y los precios finales de cada línea de compra del cliente
cuyo identificador le paso como argumento.
El precio final de un artículo es el precio base - descuento + iva */
