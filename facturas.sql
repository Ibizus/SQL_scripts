drop database if exists facturas;
create database facturas;
use facturas;
drop table if exists clientes;
drop table if exists facturas;

create table clientes (
	cod_cliente varchar(11) primary key,
	nombre varchar(10),
	apellido varchar(10),
	fecha_nacimiento date
);

create table facturas (
	cod_factura integer primary key,
	f_factura date,
	importe decimal(6,2),
	cod_cliente varchar(11),
	foreign key (cod_cliente) references clientes(cod_cliente)
);

insert into clientes values ('111-D', 'Pedro', 'Jiménez', '1975/10/12');
insert into clientes values ('222-X', 'Andres', 'López', '1984/05/26');
insert into clientes values ('333-H', 'Diego', 'Alonso', '1999/03/05');

insert into facturas values ('1','2022/10/12', 185.69, '111-D');
insert into facturas values ('2','2022/09/23', 67.99, '111-D');
insert into facturas values ('3','2022/07/05', 100, '222-X');
insert into facturas values ('4','2023/01/05', 15.85, '333-H');
insert into facturas values ('5','2022/02/28', 34.50, '222-X');
insert into facturas values ('6','2022/04/15', 122.78, '222-X');
insert into facturas values ('7','2023/01/08', 12, '333-H');
insert into facturas values ('8','2022/12/07', 345.50, '333-H');
insert into facturas values ('9','2022/03/16', 199.99, '111-D');



/* Edad de los clientes: */
select cod_cliente, nombre, apellido, TIMESTAMPDIFF(year, fecha_nacimiento, current_date) as años from clientes;

/* Mostrar el total facturado por cada cliente */
select cod_cliente, sum(importe) from facturas group by cod_cliente;

/* Mostrar el total facturado por cada cliente AHORA CON JOIN */
select facturas.cod_cliente, nombre, apellido, sum(importe) as Total from facturas join clientes where (clientes.cod_cliente = facturas.cod_cliente) group by cod_cliente;

/* Dame toda la información de los clientes mayores de 25 años */
select *, TIMESTAMPDIFF(YEAR, fecha_nacimiento, current_date) as años from clientes where TIMESTAMPDIFF(YEAR, fecha_nacimiento, current_date) > 25;



