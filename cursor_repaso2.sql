/* Un cursor que recorra las facturas de los clientes y totalice 
para cada cliente el total que vamos facturando y que no hemos
contabilizado anteriormete (lo sabremos porque si no está contabilizada, 
tendrá un valor = false en el campo "ya_contabilizada" */

drop database if exists facturas;
create database facturas;
use facturas;

create table clientes (
cod_cliente int primary key,
nombre varchar(10),
apellido varchar(10),
fecha_nacimiento date),
importe_total decimal(6,2);

create table facturas (
cod_factura int primary key,
fecha_emision date,
importe decimal(6,2),
cod_cliente int,
ya_contabilizada bool,
foreign key (cod_cliente) references clientes(cod_cliente));

insert into clientes values (1, 'Ana','López','1995/01/17', 0);
insert into clientes values (2, 'Pedro','Sánchez','2003/05/20', 0);
insert into clientes values (3, 'Luis','Ruiz','1995/01/19', 0);

insert into facturas values (1, '2003/08/08',3650, 1, false);
insert into facturas values (2, '1997/11/09',4823, 2, true);
insert into facturas values (3, '1997/12/10',675, 1, true);
insert into facturas values (4, '2023/01/15',985, 1, false);
insert into facturas values (5, '1997/01/16',750, 2, false);
insert into facturas values (6, '2023/01/17',536, 3, true);

select * from clientes;
select * from facturas;


