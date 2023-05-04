/********************************************************************/
/****************** EXAMEN 17/02/2023 1º DAW ************************/
/******************* S O L U C I O N A R I O ************************/
/********************************************************************/
/*********Script de Inicialización de la Base de Datos **************/
/********** (No hay foreing keys para no afectar) *******************/ 

drop database if exists facturacion;
create database facturacion;
use facturacion;

/*Tabla con la información necesaria de los distintos departamentos*/
 create table departamentos(
  cod_dep int primary key not null, 
  nombre_dep varchar(30) not null,
  descuento_dep decimal(5,2) not null
 );

/*Tabla con la información necesaria de los articulos comercializados*/
 create table articulos(
  cod_art int primary key not null, 
  nombre_art varchar(30) not null,
  preciounidad_art decimal(5,2) not null,
  cod_dep int /*los articulos pertenecen a departamentos*/
 );

/*Tabla con la información necesaria para clientes*/
create table clientes(
  cod_cli varchar(8) primary key not null,
  apellidos_cli varchar(30),
  nombre_cli varchar(15),
  fnacimiento_cli date,
  domicilio_cli varchar(30)
 );
 
/*Tabla con la información necesaria de las facturas*/
create table facturas(
  cod_fac int primary key not null, 
  cod_cli varchar(8) not null, /*cada factura está asociada a un cliente*/
  fecha_fac date,
  estadodelpago_fac char(1) /*si está pagada, tendrá valor 's' si no, tendrá valor 'n'*/
);

/*Tabla con la información necesaria de cada línea de cada factura*/
 create table lineas_de_facturas(
  cod_factura int not null, 
  cod_linea int not null, /*cada factura tiene lineas de venta*/
  cod_articulo int not null, /*cada linea de venta en una factura tiene un artículo*/
  cantidad decimal (5,2) not null,   /*cada linea de venta en una factura tiene un artículo y una cantidad adquirida*/
  primary key(cod_factura, cod_linea)
 );

/********************* Carga de registros en tablas ****************/
-- Añadimos clientes:
 insert into clientes values('11111111','Romero', 'Julia','1977-12-18','Andromeda, 13');
 insert into clientes values('22222222','Alvarez','Jose Manuel','2003-03-25','Castellana, 14');
 insert into clientes values('33333333','Granados','Isabel','2001-02-01','Gran Via 9');
 insert into clientes values('44444444','Granados','Marcos', '1999-01-30','Plaza de la Libertad, 20');
 insert into clientes values('55555555','Pereyra','Antonio', '1990-01-15','Sucre 349');
 insert into clientes values('66666666','Perez', 'Juan','1967-02-11','Colon 234');
 insert into clientes values('77777777','Lopez','Marta','1993-11-05','Sarmiento 465');
 insert into clientes values('88888888','Juarez','Maria Isabel','2001-09-26','Caseros 980');
 insert into clientes values('99999999','Pereyra','Marco Antonio', '1992-03-14','PLaza de la Marina, 5');

-- Añadimos departamentos:
 insert into departamentos values(1, 'Ferreteria', 0.10);
 insert into departamentos values(2, 'Jardineria', 0.00);
 insert into departamentos values(3, 'Alimentacion',0.25);
 insert into departamentos values(4, 'Joyeria/Relojeria',0.00);
 insert into departamentos values(5, 'Ropa',0.25);
 insert into departamentos values(6, 'Deportes',0.10);
 
-- Añadimos unos articulos
 insert into articulos values(1, 'Salmon fresco', 12, 3);
 insert into articulos values(2, 'Alicates', 25, 1);
 insert into articulos values(3, 'Rollo manguera 10 mt',40, 2);
 insert into articulos values(4, 'Reloj casio',49, 4);
 insert into articulos values(5, 'Chuletas de cordero', 7, 3);
 insert into articulos values(6, 'Cinta americana', 10, 1);
 insert into articulos values(7, 'Saco sustrato 5kg',18, 2);
 insert into articulos values(8, 'Reloj rolex',500, 4);
 insert into articulos values(9, 'Colchoneta yoga',3.5, 6);
 insert into articulos values(10, 'Cinta de correr',300, 6);
 insert into articulos values(11, 'Pantalon vaquero',30, 5);
 insert into articulos values(12, 'Camisa casual',20, 5);

-- Añadimos unas facturas a clientes
 insert into facturas values(105, '22222222', '2023-02-15', 'n');
 insert into facturas values(106, '55555555', '2023-01-01', 's');
 insert into facturas values(107, '33333333', '2023-01-12', 'n');

-- Añadimos líneas de compra dentro de las facturas a clientes
 insert into lineas_de_facturas values(105, 1, 1, 3);
 insert into lineas_de_facturas values(105, 2, 5, 1);
 insert into lineas_de_facturas values(105, 3, 7, 2);
 insert into lineas_de_facturas values(105, 4, 8, 1);
 insert into lineas_de_facturas values(106, 1, 2, 2);
 insert into lineas_de_facturas values(106, 2, 3, 1);
 insert into lineas_de_facturas values(106, 3, 8, 1);
 

/******************************************************************************************/

-- Queries de cada apartado:
-- 1 Una consulta que muestre todos los campos de los articulos cuyo preciounidad está comprendido entre 10 y 400 € (inclusive) y el nombre contiene la palabra 'Cinta'
select 'Query 1:';
select * from articulos where (preciounidad_art between 10 and 400) and (nombre_art like '%Cinta%');

-- 2: Una consulta que muestre todos datos de los articulos de los departamentos de Jardineria y Ferreteria ordenados descendentemente por el nombre de articulo.
select 'Query 2:';
select articulos.* from articulos join departamentos on departamentos.cod_dep = articulos.cod_dep
where nombre_dep = "Jardineria" or nombre_dep = "Ferreteria" order by nombre_art desc;

-- 3 Igual que la query 1, pero se debe mostrar igualmente el nombre del departamento al que pertenecen los artículos obtenidos 
select 'Query 3:';
select articulos.*, nombre_dep from articulos join departamentos on departamentos.cod_dep = articulos.cod_dep
where nombre_dep = "Jardineria" or nombre_dep = "Ferreteria" order by nombre_art desc;

-- 4 Una consulta que muestre los códigos de los articulos, su nombre del articulo, la cantidad comprada y su preciounidad de la factura 106
select 'Query 4:';
select cod_art, nombre_art, cantidad, preciounidad_art from articulos join lineas_de_facturas
on lineas_de_facturas.cod_articulo = articulos.cod_art where lineas_de_facturas.cod_factura = '106';

-- 5 Una consulta que muestre  la nombre del articulo, el precio unidad sin descuento (normal), el porcentaje de descuento a aplicar según la departamento a la que pertenece
-- y el precio unidad con el descuento de todos los articulos ordenados alfabéticamente
select 'Query 5:';
select a.nombre_art, a.preciounidad_art, departamentos.descuento_dep, round(a.preciounidad_art*(1-departamentos.descuento_dep), 2)
as "Precio Final" from articulos as a join departamentos  on departamentos.cod_dep = a.cod_dep order by a.nombre_art;
 
-- 6 Una consulta que muestre  todos los datos de los artículos, y el nombre de su departamento cuyo precio unidad está por encima del precio medio de todos los articulos (usando una subconsulta
-- para calcular el precio medio.)
select 'Query 6:';
select a.* , dep.cod_dep from articulos as a left join departamentos as dep on a.cod_dep = dep.cod_dep
where a.preciounidad_art > (select avg(preciounidad_art) from articulos);

-- 7: Una consulta que muestre la suma del preciounidad de todos los articulos agrupados y ordenados alfabéticamente por el nombre de departamento.
select 'Query 7:';
select nombre_dep , sum(a.preciounidad_art) as suma from articulos as a join departamentos as dep on a.cod_dep = dep.cod_dep
where a.cod_dep = dep.cod_dep group by nombre_dep;

-- 8: Una consulta que me devuelva los nombres de los articulos, su precio por unidad y su precio rebajado. Sólo debe considerar los articulos de precio inferior a 50 €. 
select 'Query 8:';
select a.nombre_art, a.preciounidad_art, round(a.preciounidad_art*(1-dep.descuento_dep), 2) as "Precio Rebajado"
from articulos as a join departamentos as dep on dep.cod_dep = a.cod_dep where a.preciounidad_art < 50;

-- 9 Una consulta que muestre todos los datos de los departamentos que tienen el mayor descuento.
select 'Query 9:';
select * from departamentos where descuento_dep >= (select max(descuento_dep) from departamentos);
  
-- 10  Obtener el nombre, apellidos, fecha de nacimiento y edad de todos los clientes que tienen asociada alguna factura, ordenados ascendentemente por edad
select 'Query 10:';
select nombre_cli, apellidos_cli, fnacimiento_cli, clientes.cod_cli, timestampdiff(YEAR,fnacimiento_cli,CURDATE()) as edad
from clientes join facturas on facturas.cod_cli = clientes.cod_cli order by edad asc;

-- 11 Obtener la nombre del articulo , el precio unidad, el precio rebajado y la cantidad vendida de todos los articulos que han sido vendidos (es decir, parecen dentro de alguna linea de factura)
-- ordenados ascendentemente por el código de factura
select 'Query 11:';
select nombre_art, preciounidad_art, round(a.preciounidad_art*(1-dep.descuento_dep), 2) as "Precio Rebajado", cantidad
from articulos as a join departamentos as dep on dep.cod_dep = a.cod_dep  join lineas_de_facturas as lf on a.cod_art = lf.cod_articulo join facturas as f
on f.cod_fac= lf.cod_factura;

-- 12 Obtener los todos los datos de los clientes y de sus facturas sin pagar con el importe total de las mismas, (agrupados por cliente).
select 'Query 12:';
-- sum(articulos.preciounidad * lineasfac.cantidad) 
select cli.*, fac.*, sum(a.preciounidad_art * lf.cantidad) from facturas as fac join lineas_de_facturas as lf
on lf.cod_factura = fac.cod_fac join articulos as a on a.cod_art = lf.cod_articulo join clientes as cli on cli.cod_cli = fac.cod_cli
where estadodelpago_fac = 'n' group by fac.cod_fac;

-- 13 Obtener los todos los datos de los cliente y de sus facturas con el importe total de las mismas, (agrupados por cliente).  Tambien apareceran los que no tienen facturas 
select 'Query 13:';
select clientes.*,hm.importetotal from clientes left join (select facturas.cod_cli,sum(cantidad * preciounidad_art) as importetotal from lineas_de_facturas
join articulos on lineas_de_facturas.cod_articulo = articulos.cod_art
join facturas on lineas_de_facturas.cod_factura = facturas.cod_fac group by facturas.cod_fac) as hm on hm.cod_cli = clientes.cod_cli;

-- 14 Obtener los todos los datos de las facturas cuya fecha es de hace una semana o más y no están pagadas, junto con los datos de los clientes asociados a dichas facturas.
select 'Query 14:';
select * , timestampdiff(DAY, facturas.fecha_fac, current_date) as "Retraso en Pago"
from facturas join clientes on clientes.cod_cli = facturas.cod_cli
where timestampdiff(DAY, facturas.fecha_fac, current_date) >= 7 and estadodelpago_fac = 'n';

-- 15 Realizar una procedure a la que se le pasa un codigo de factura como variable de entrada 
-- y devuelve el codigo del cliente asociado a la factura y el importe total de dicha factura
select 'Query 15:';
drop procedure if exists p_datosCliente;
  delimiter //
 create procedure p_datosCliente(
   in codFactura int,
   out codCliente varchar(8),
   out importeTotal decimal(5,2))
 begin
   select clientes.cod_cli into codCliente 
	from clientes join facturas
	on facturas.cod_cli = clientes.cod_cli
	where facturas.cod_fac = codFactura;
   select sum(articulos.preciounidad_art * lineas_de_facturas.cantidad) into importeTotal
	from lineas_de_facturas join articulos 
	on articulos.cod_art = lineas_de_facturas.cod_articulo
    where codFactura = lineas_de_facturas.cod_factura;
 end //
 delimiter ;
/*Probamos el procedure*/
set @factura = '106';
set @codigoCli = '';
set @importeTotal = 0;
call p_datosCliente (@factura, @codigoCli, @importeTotal);
select  @factura, @codigoCli, @importeTotal;

-- 16 Realizar una procedure a la que se le pasa un codigo de cliente como variable de entrada
-- y devuelve el importe de todas sus compras realizadas.
select 'Query 16:';
drop procedure if exists p_importeCompra;
  delimiter //
 create procedure p_importeCompra(
   in codCliente varchar(8),
   out importeTotal decimal(5,2))
 begin
   select sum(articulos.preciounidad_art * lineas_de_facturas.cantidad) into importeTotal
	from lineas_de_facturas join articulos 
	on articulos.cod_art = lineas_de_facturas.cod_articulo
    join facturas on facturas.cod_fac = lineas_de_facturas.cod_factura
    where codCliente = facturas.cod_cli ;
 end //
delimiter ;
/*Probamos el procedure*/
set @codigoCli = '55555555';
set @importeTotal = 0;
call p_importeCompra (@codigoCli, @importeTotal);
select  @codigoCli, @importeTotal;
