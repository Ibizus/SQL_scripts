/*********Script de Inicialización de la Base de Datos **************/
drop database if exists tienda;
create database tienda;
use tienda;

/*Tabla con la información necesaria para clientes*/
create table clientes(
  dni varchar(8) primary key not null,
  apellidos varchar(30),
  nombre varchar(15),
  fnacimiento date,
  domicilio varchar(30)
 );

/*Tabla con la información necesaria de los articulos comercializados*/
 create table articulos(
  articulo int primary key not null, 
  descripcion varchar(30) not null,
  preciounidad decimal(5,2) not null,
  cod_seccion int
 );

/*Tabla con la información necesaria de los distintas secciones*/
 create table secciones(
  cod_seccion int primary key not null, 
  seccion varchar(30) not null,
  descuento decimal(5,2) not null
 );

/*Tabla con la información necesaria de las facturas*/
create table facturascli(
  factura int primary key not null, 
  dni varchar(8) not null,
  fecha date,
  pagada char(1) /*si está pagada, tendrá valor 's' si no, tendrá valor 'n'*/
);

/*Tabla con la información necesaria de cada línea de cada factura*/
 create table lineasfac(
  factura int not null, 
  linea int not null,
  articulo int not null,
  cantidad decimal (5,2) not null,   
  primary key(factura, linea)
 );

/********************* Carga de registros en tablas ****************/

 insert into clientes values('55888444','Romero', 'Julia','1977-12-18','Andromeda, 13');
 insert into clientes values('77333444','Alvarez','Jose Manuel','2003-03-25','Castellana, 14');
 insert into clientes values('88666444','Granados','Isabel','2001-02-01','Gran Via 9');
 insert into clientes values('99000444','Granados','Marcos', '1999-01-30','Plaza de la Libertad, 20');
 insert into clientes values('66111444','Pereyra','Antonio', '1990-01-15','Sucre 349');
 insert into clientes values('11555444','Perez', 'Juan','1967-02-11','Colon 234');
 insert into clientes values('22777444','Lopez','Marta','1993-11-05','Sarmiento 465');
 insert into clientes values('33999444','Juarez','Maria Isabel','2001-09-26','Caseros 980');
 insert into clientes values('44222444','Pereyra','Marco Antonio', '1992-03-14','PLaza de la Marina, 5');


-- Query para mostrar todos los datos de clientes, incluida su edad, ordenados por edad ascendentemente:
select *, timestampdiff(YEAR, fnacimiento, CURRENT_DATE) as edad from clientes order by edad asc;


-- Añadimos secciones:
insert into secciones values(1, 'Ferreteria', 0.20);
insert into secciones values(2, 'Jardineria', 0.00);
insert into secciones values(3, 'Frescos', 0.50);
insert into secciones values(4, 'Joyeria', 0);

-- Añadimos artículos:
insert into articulos values(1, 'Salmon fresco', 12, 3);
insert into articulos values(2, 'Alicates', 10, 1);
insert into articulos values(3, 'Rollo manguera 10m', 50, 2);
insert into articulos values(4, 'Reloj Casio', 50, 4);

-- Query para obtener la descripcion de articulo, el precio (sin descuento), y el precio con descuento, de todos los artículos:
select descripcion, preciounidad, round(preciounidad*(1-descuento),2) as Precio_Final from articulos join secciones on articulos.cod_seccion = secciones.cod_seccion;


-- SUBCONSULTAS:

-- Una consulta que muestre todos los datos de todos los articulos y el nombre de sus secciones cuyo precio es igual al precio máximo de todos los articulos:
select * from articulos join secciones on articulos.cod_seccion = secciones.cod_seccion where preciounidad = max(preciounidad);
/* Asi da error porque mezcla en la comparacion un valor con una funcion de agrupamiento y no se usa subconsulta */

select max(preciounidad) from articulos; -- Esto funciona por separado y da un valor.

/* Así que podemos sacarlo e incluirlo en la comparación del query anterior, entre parentesis: */
select * from articulos join secciones on articulos.cod_seccion = secciones.cod_seccion where preciounidad = (select max(preciounidad) from articulos);
/* saca dos veces "cod_seccion" porque el select* con join muestra todo de cada tabla */


-- Una consulta que muestre todos los datos de todos los articulos y el nombre de sus secciones cuyo precio es menor al precio medio de todos los articulos:
select a.descripcion, a.preciounidad, s.seccion from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion where a.preciounidad < (select avg(preciounidad) from articulos);


-- Apart 86: Una consulta que muestre todos los datos de todos los articulos y el nombre de sus secciones cuyo precio es igual al mayor o igual al menor de todos los articulos:
select a.descripcion, a.preciounidad, s.seccion from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion where a.preciounidad = (select max(preciounidad) from articulos) or a.preciounidad = (select min(preciounidad) from articulos);


-- Apart 87: Consulta que me de todos los articulos cuya seccion no sea Ferreteria:

/* primero sacamos los articulos que pertenecen a ferreteria */
select descripcion from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion where s.seccion = 'Ferreteria';
/* y lo introducimos dentro de la consuta: */
select * from articulos where descripcion not IN (select descripcion from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion where s.seccion = 'Ferreteria');

/* Otra forma */
select a.descripcion, a.preciounidad, s.seccion from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion where s.seccion not like '%Ferret%';







