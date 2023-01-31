drop database if exists facturas;
create database facturas;
use facturas;
drop table if exists lineas, facturas, clientes, producto;

create table clientes (
cod_cliente int primary key,
nombre varchar(10),
apellido varchar(10),
fecha_nacimiento date
);

create table facturas (
cod_factura int primary key,
fecha_emision date,
importe decimal(6,2),
cod_cliente int,
foreign key (cod_cliente) references clientes(cod_cliente)
);

insert into clientes values (1, 'Ana','López','1995/01/17');
insert into clientes values (2, 'Pedro','Sánchez','2003/05/20');
insert into clientes values (3, 'Luis','Ruiz','1995/01/19');

insert into facturas values (1, '1997/08/08',3650, 1);
insert into facturas values (2, '2022/11/09',4823, 2);
insert into facturas values (3, '1997/12/10',675, 3);
insert into facturas values (4, '2023/01/15',985, 1);
insert into facturas values (5, '1997/01/16',750, 2);
insert into facturas values (6, '2023/01/17',536, 3);


/*
-- Calcular la edad de una persona a partir de su fecha de nacimiento
select *, timestampdiff(year, fecha_nacimiento, current_date) as Años from clientes;

-- Los totales facturados agrupados por cliente
select cod_cliente, sum(importe) from facturas group by cod_cliente;

-- Los totales facturados agrupados por cliente, y el nombre y apellido del cliente

select clientes.cod_cliente, nombre, apellido, sum(importe) from facturas join clientes on (facturas.cod_cliente = clientes.cod_cliente) group by cod_cliente;

-- Sólo la de los menores de 25 
select clientes.cod_cliente, nombre, apellido, sum(importe) from facturas join clientes on (facturas.cod_cliente = clientes.cod_cliente) where timestampdiff(year, fecha_nacimiento, current_date) < 25 group by cod_cliente;

-- Los totales facturados agrupados por cliente, y el nombre y apellido del cliente si tene menos de 25 años
select clientes.cod_cliente, nombre, apellido, sum(importe), timestampdiff(year, fecha_nacimiento, current_date) as Edad from facturas join clientes on (facturas.cod_cliente = clientes.cod_cliente) where timestampdiff(year, fecha_nacimiento, current_date) < 25 group by cod_cliente;
*/

/* Añadido para simular un caso real más complejo: Join con más de dos tablas: */

create table productos (
cod_producto int primary key,
nombre varchar(30),
precio_unidad decimal(5,2)
);

create table lineas (
cod_factura int,
cod_linea int,
cod_producto int,
cantidad decimal(5,2),
primary key (cod_factura, cod_linea),
foreign key (cod_factura) references facturas(cod_factura),
foreign key (cod_producto) references productos(cod_producto)
);

insert into productos values (1, 'Palé de ladrillos', 25);
insert into productos values (2, 'Saco de cemento', 15);
insert into productos values (3, 'Metro de arena', 35);
insert into productos values (4, 'Carretilla', 125);
insert into productos values (5, 'Metro de grava', 25);
insert into productos values (6, 'Tela asfática', 55);

insert into lineas values (1,1,3,2);
insert into lineas values (1,2,1,3);
insert into lineas values (1,3,2,5);

insert into lineas values (2,1,4,2);
insert into lineas values (2,2,5,2);
insert into lineas values (2,3,6,2);


/* Empezamos con join de DOS TABLAS: */

/* Toda la información a nivel de facturas del cliente que se llama Pedro Sanchez */
select facturas.cod_factura, facturas.fecha_emision, facturas.importe from facturas join clientes on clientes.cod_cliente = facturas.cod_cliente where clientes.nombre = 'Pedro' and clientes.apellido = 'Sánchez';

/* Toda la información de los clientes que en algun momento nos han comprado ladrillos */
select clientes.cod_cliente, clientes.nombre, clientes.apellido from clientes join facturas on clientes.cod_cliente = facturas.cod_cliente join lineas on lineas.cod_factura = facturas.cod_factura join productos on lineas.cod_producto = productos.cod_producto where productos.nombre like'%ladrillo%';

/* Obtener toda la información de los clientes, e información de los productos que hayan comprado a un precio mayor de 30€ */
select clientes.cod_cliente, clientes.nombre, apellido, productos.nombre, productos.precio_unidad from clientes join facturas on clientes.cod_cliente = facturas.cod_cliente join lineas on lineas.cod_factura = facturas.cod_factura join productos on lineas.cod_producto = productos.cod_producto where productos.precio_unidad >30;

/* Obtener toda la información de los clientes, e información de los productos que hayan comprado una cantidad de producto que sume un precio mayor a 100€ */
select clientes.cod_cliente, clientes.nombre, apellido, productos.nombre, productos.precio_unidad*lineas.cantidad as subtotal from clientes join facturas on clientes.cod_cliente = facturas.cod_cliente join lineas on lineas.cod_factura = facturas.cod_factura join productos on lineas.cod_producto = productos.cod_producto where (productos.precio_unidad*lineas.cantidad) >100;

/* Obtener los clientes que han comprado ladrillos en el siglo XX */
select clientes.cod_cliente, clientes.nombre, clientes.apellido from clientes join facturas on clientes.cod_cliente = facturas.cod_cliente join lineas on lineas.cod_factura = facturas.cod_factura join productos on lineas.cod_producto = productos.cod_producto where productos.nombre like'%ladrillo%' and facturas.fecha_emision < '2001-01-01';

/* Toda la información a nivel de cliente, facturas asociadas y líneas de factura con el detalle del producto e importe total de líneas */














