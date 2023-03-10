/*********Script de Inicialización de la Base de Datos **************/
/**********No hay foreing keys para no afectar **********************/ 
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

/*Tabla con la información necesaria de los distintas secciones*/
 create table secciones(
  cod_seccion int primary key not null, 
  seccion varchar(30) not null,
  descuento decimal(5,2) not null
 );

/*Tabla con la información necesaria de los articulos comercializados*/
 create table articulos(
  articulo int primary key not null, 
  descripcion varchar(30) not null,
  preciounidad decimal(5,2) not null,
  cod_seccion int
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

-- Añadimos secciones:
 insert into secciones values(1, 'Ferreteria', 0.10);
 insert into secciones values(2, 'Jardineria', 0.00);
 insert into secciones values(3, 'Alimentacion',0.25);
 insert into secciones values(4, 'Joyeria/Relojeria',0.00);
 insert into secciones values(5, 'Ropa',0.25);
 insert into secciones values(6, 'Deportes',0.10);
 
-- Añadimos unos articulos
 insert into articulos values(1, 'Salmon fresco', 12, 3);
 insert into articulos values(2, 'Alicates', 25, 1);
 insert into articulos values(3, 'Rollo manguera 10 mt',40, 2);
 insert into articulos values(4, 'Reloj casio',50, 4);
 insert into articulos values(5, 'Chuletas de cordero', 7, 3);
 insert into articulos values(6, 'Cinta americana', 2, 1);
 insert into articulos values(7, 'Saco sustrato 5kg',18, 2);
 insert into articulos values(8, 'Reloj rolex',500, 4);
 insert into articulos values(9, 'Colchoneta yoga',3.5, 6);
 insert into articulos values(10, 'Bicicleta carretera',300, 6);
 insert into articulos values(11, 'Pantalon vaquero',30, 5);
 insert into articulos values(12, 'Camisa casual',20, 5);

-- Añadimos unas facturas a clientes
 insert into facturascli values(105, '22222222', '2023-02-15', 'n');
 insert into facturascli values(106, '55555555', '2023-01-01', 'n');
 insert into facturascli values(107, '33333333', '2023-01-12', 'n');

-- Añadimos líneas de compra dentro de las facturas a clientes
 insert into lineasfac values(105, 1, 1, 3);
 insert into lineasfac values(105, 2, 5, 1);
 insert into lineasfac values(105, 3, 7, 2);
 insert into lineasfac values(105, 4, 8, 1);
 insert into lineasfac values(106, 1, 2, 2);
 insert into lineasfac values(106, 2, 3, 1);
 insert into lineasfac values(106, 3, 8, 1);
 


/******************************************************************************************/
-- Realizar las Queries necesarias en cada apartado para:
-- 1 Obtener todos los campos de los articulos cuyo preciounidad está comprendido entre 100 y 400 € (inclusive), o bien, son artículos cuya descripción incluye la palabra 'Reloj'
select 'Query 1:';
select * from articulos where preciounidad between 100 and 400 or descripcion like "%Reloj%";

-- 2 Obtener todos los campos de las facturas a clientes cuya fecha y estado indica que llevan más de una semana sin pagarse
select 'Query 2:';
select * from facturascli where (timestampdiff(DAY, facturascli.fecha, CURRENT_DATE) >=7) and (facturascli.pagada = 'n');

-- 3 Obtener los códigos de los articulos, su descripción, la cantidad comprada y su preciounidad de la factura 106
select 'Query 3:';
select a.articulo, a.descripcion, a.preciounidad, l.cantidad from articulos as a join lineasfac as l on a.articulo=l.articulo where l.factura = 106;

-- 4 Obtener la descripcion, el precio unidad sin descuento (normal), el porcentaje de descuento a aplicar según la sección a la que pertenece
-- y el precio unidad con el descuento de todos los articulos ordenados alfabéticamente
select 'Query 4:';
-- sin FORMATO:
select a.descripcion, a.preciounidad, s.descuento, a.preciounidad*(1-s.descuento) as p_rebajado from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion order by a.descripcion asc;
-- CON FORMATO:
select a.descripcion, a.preciounidad, concat(round(s.descuento*100), ' %') as Descuento from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion order by a.descripcion asc;

-- 5 Obtener todos los datos de los artículos, y el nombre de su sección cuyo precio unidad está por debajo al precio medio de todos los articulos (usando una subconsulta
-- para calcular el precio medio.)
select 'Query 5:';
-- de todos los articulos:
select a.articulo, a.descripcion, a.preciounidad, a.cod_seccion, s.seccion from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion; 
-- subconsulta articulos debajo del precio medio:
select avg(preciounidad) from articulos;
-- query completo:
select a.articulo, a.descripcion, a.preciounidad, a.cod_seccion, s.seccion from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion where a.preciounidad < (select avg(preciounidad) from articulos);

-- 6: Obtener la suma del preciounidad de todos los articulos agrupadas por secciones.
select 'Query 6:';
select s.seccion, sum(a.preciounidad) as suma_Precios from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion  group by a.cod_seccion;

-- 7: Obtener todos datos de los articulos cuya seccion no sea ni Deportes ni Ropa
select 'Query 7:';
select * from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion where seccion not like "%Deportes%" and seccion not like "%Ropa%";

-- 8: Una consulta que me devuelva las descripciones de los articulos, su precio por unidad y su precio rebajado 
select 'Query 8:';
select a.descripcion, a.preciounidad, round(a.preciounidad*(1-s.descuento),2) as p_rebajado from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion;

-- 9 Una consulta que te muestre todos los datos de todas las secciones que no tienen descuento
select 'Query 9:';
select * from secciones where descuento = 0;
  
-- 10  Obtener el nombre, apellidos y edad de todos los clientes ordenados ascendentemente por edad
select 'Query 10:';
select nombre, apellidos, timestampdiff(YEAR, fnacimiento, CURRENT_DATE) as edad from clientes order by fnacimiento desc;
 
-- 11 Obtener la descripción y el precio y la cantidad de todos los articulos que han sido vendidos (es decir, parecen dentro de alguna linea de factura)
-- ordenados ascendentemente por factura
select 'Query 11:';
select l.factura, a.descripcion, a.preciounidad, l.cantidad from articulos as a join lineasfac as l on a.articulo = l.articulo order by factura;

-- 12 Obtener los todos los datos de los cliente y de sus facturas con el importe total de las mismas, (agrupados por cliente). (Sólo los clientes que tienen facturas)
select 'Query 12:';
-- select c.dni, c.nombre, c.apellidos, c.fnacimiento, c.domicilio, f.factura, sum(a.preciounidad*l.cantidad) from clientes as c join facturascli as f on c.dni = f.dni join lineasfac as l on f.factura=l.factura join articulos as a on l.articulo=a.articulo;
-- sumatorio lineasfactura:
select sum(a.preciounidad*l.cantidad) from articulos as a join lineasfac as l on on a.articulo=l.articulo;

-- 13 Obtener los todos los datos de los cliente y de sus facturas con el importe total de las mismas, (agrupados por cliente).  Tambien apareceran los que no tienen facturas 
select 'Query 13:';


-- 14 Realizar una procedure a la que se le pasa un número de factura como variable de entrada y devuelve el dni del cliente asociado a la factura y el importe total de dicha factura
select 'Query 14:';
drop procedure if exists pa_totalFactura;

delimiter //
create procedure pa_totalFactura(
		in p_fac int,
		out dni varchar(8),
		out total decimal(5,2)
		)
	begin
		select dni into c.dni
		from clientes as c
		join facturas as f
		on c.dni=f.dni
		where p_fac = f.factura;
		
		select sum(a.preciounidad*l.cantidad)
		from articulos as a
		join lineasfac as l
		on a.articulo=l.articulo
		where l.factura=p_fac;
end //
delimiter ;
/* INICIALIZAMOS LAS VARIABLES QUE PASAMOS A LA FUNCIÓN */
set @dni = '';
set @total = 0;
		
/* LLAMAMOS A LA FUNCION */
call pa_totalFactura(106, @dni, @total);
select @dni, @total;	
		
		
		
		
/*
-- Borrar procedimiento
 drop procedure if exists pa_libros_autor;

 delimiter //
 create procedure pa_libros_autor(in p_autor varchar(30))
 begin
   select titulo, editorial,precio
     from libros
     where autor= p_autor;
 end //
 delimiter ;
 
 call pa_libros_autor('Richard Bach');
*/






-- 15 Realizar una procedure a la que se le pasa un dni como variable de entrada y devuelve la cantidad de facturas pendientes de pago que tenga
select 'Query 15:';


 






 

