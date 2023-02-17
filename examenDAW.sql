/********* Script de Inicialización de la Base de Datos **************/
/****** Para simplificar la base de datos, no hay foreing keys *******/ 
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
select * from articulos where preciounidad_art between 10 and 400 and articulos.nombre_art like "%Cinta%";

-- 2: Una consulta que muestre todos datos de los articulos de los departamentos de Jardineria y Ferreteria ordenados descendentemente por el nombre de articulo.
select 'Query 2:';
select * from articulos as a join departamentos as d on a.cod_dep=d.cod_dep where d.nombre_dep like "%Jardineria%" or d.nombre_dep like "%Ferreteria%" order by a.nombre_art asc;

-- 3 Igual que la query 1, pero se debe mostrar igualmente el nombre del departamento al que pertenecen los artículos obtenidos 
select 'Query 3:';
select a.cod_art, a.nombre_art, a.preciounidad_art, a.cod_dep, d.nombre_dep from articulos as a join departamentos as d on a.cod_dep=d.cod_dep where a.preciounidad_art between 10 and 400 and a.nombre_art like "%Cinta%";


-- 4 Una consulta que muestre los códigos de los articulos, su nombre del articulo, la cantidad comprada y su preciounidad de la factura 106
select 'Query 4:';
select a.cod_art, a.nombre_art, l.cantidad, a.preciounidad_art from articulos as a join lineas_de_facturas as l on a.cod_art = l.cod_articulo where l.cod_factura=106;


-- 5 Una consulta que muestre  la nombre del articulo, el precio unidad sin descuento (normal), el porcentaje de descuento a aplicar según la departamento a la que pertenece
-- y el precio unidad con el descuento de todos los articulos ordenados alfabéticamente
select 'Query 5:';
select a.nombre_art as Nombre, a.preciounidad_art as P_unitario, concat(round(d.descuento_dep*100), ' %') as Descuento, concat(round(a.preciounidad_art*(1-d.descuento_dep)),' €') P_rebajado from articulos as a join departamentos as d on a.cod_dep=d.cod_dep order by a.nombre_art asc;

 
-- 6 Una consulta que muestre  todos los datos de los artículos, y el nombre de su departamento cuyo precio unidad está por encima del precio medio de todos los articulos (usando una subconsulta
-- para calcular el precio medio.)
select 'Query 6:';
-- subconsulta precio medio:
select avg(preciounidad_art) as Precio_Medio from articulos;

select a.cod_art, a.nombre_art, a.preciounidad_art, a.cod_dep, d.nombre_dep from articulos as a join departamentos as d on a.cod_dep=d.cod_dep where a.preciounidad_art > (select avg(preciounidad_art) from articulos);


-- 7: Una consulta que muestre la suma del preciounidad de todos los articulos agrupados y ordenados alfabéticamente por el nombre de departamento.
select 'Query 7:';
select d.nombre_dep, sum(a.preciounidad_art) as suma_Precios from articulos as a join departamentos as d on a.cod_dep=d.cod_dep group by d.nombre_dep order by d.nombre_dep asc;



-- 8: Una consulta que me devuelva los nombres de los articulos, su precio por unidad y su precio rebajado. Sólo debe considerar los articulos de precio inferior a 50 €. 
select 'Query 8:';
select a.nombre_art, a.preciounidad_art, round(a.preciounidad_art*(1-d.descuento_dep),2) as p_rebajado from articulos as a join departamentos as d on a.cod_dep=d.cod_dep where a.preciounidad_art<50;


-- 9 Una consulta que muestre todos los datos de los departamentos que tienen el mayor descuento.
select 'Query 9:';
select * from departamentos where descuento_dep = (select max(descuento_dep) from departamentos);

  
-- 10  Obtener el nombre, apellidos, fecha de nacimiento y edad de todos los clientes que tienen asociada alguna factura, ordenados ascendentemente por edad
select 'Query 10:';
select c.nombre_cli, c.apellidos_cli, c.fnacimiento_cli, timestampdiff(YEAR, c.fnacimiento_cli, CURRENT_DATE) as edad, f.cod_fac from clientes as c join facturas as f on c.cod_cli=f.cod_cli order by c.fnacimiento_cli desc;
 

-- 11 Obtener la nombre del articulo , el precio unidad, el precio rebajado y la cantidad vendida de todos los articulos que han sido vendidos (es decir, parecen dentro de alguna linea de factura)
-- ordenados ascendentemente por el código de factura
select 'Query 11:';
select l.cod_factura, a.nombre_art, a.preciounidad_art, round(a.preciounidad_art*(1-d.descuento_dep),2) as p_rebajado, l.cantidad from articulos as a join lineas_de_facturas as l on a.cod_art = l.cod_articulo join departamentos as d on a.cod_dep=d.cod_dep order by l.cod_factura;


-- 12 Obtener los todos los datos de los clientes y de sus facturas sin pagar con el importe total de las mismas, (agrupados por cliente).
select 'Query 12:';
select c.cod_cli, c.nombre_cli, c.apellidos_cli, c.fnacimiento_cli, c.domicilio_cli, f.cod_fac, f.fecha_fac, f.estadodelpago_fac as pagado, sum(a.preciounidad_art*l.cantidad) as total from clientes as c join facturas as f on c.cod_cli=f.cod_cli join lineas_de_facturas as l on f.cod_fac=l.cod_factura join articulos as a on l.cod_articulo=a.cod_art where f.estadodelpago_fac = 'n' group by l.cod_factura;


-- 13 Obtener los todos los datos de los cliente y de sus facturas con el importe total de las mismas, (agrupados por cliente).  Tambien apareceran los que no tienen facturas 
select 'Query 13:';
select c.cod_cli, c.nombre_cli, c.apellidos_cli, c.fnacimiento_cli, c.domicilio_cli, f.cod_fac, f.fecha_fac, f.estadodelpago_fac as pagado, sum(a.preciounidad_art*l.cantidad) as total from clientes as c left join facturas as f on c.cod_cli=f.cod_cli left join lineas_de_facturas as l on f.cod_fac=l.cod_factura left join articulos as a on l.cod_articulo=a.cod_art group by c.cod_cli;


-- 14 Obtener los todos los datos de las facturas cuya fecha es de hace una semana o más y no están pagadas, junto con los datos de los clientes asociados a dichas facturas.
select 'Query 14:';
select f.cod_fac, f.fecha_fac, f.estadodelpago_fac, c.cod_cli, c.nombre_cli, c.apellidos_cli, c.fnacimiento_cli, c.domicilio_cli from clientes as c join facturas as f on c.cod_cli=f.cod_cli where (timestampdiff(DAY, f.fecha_fac, CURRENT_DATE) >=7) and (f.estadodelpago_fac = 'n');


-- 15 Realizar una procedure a la que se le pasa un codigo de factura como variable de entrada 
-- y devuelve el codigo del cliente asociado a la factura y el importe total de dicha factura
select 'Query 14:';



-- 16 Realizar una procedure a la que se le pasa un codigo de cliente como variable de entrada
-- y devuelve el importe de todas sus compras realizadas.
select 'Query 16:';


 
 


 
 
