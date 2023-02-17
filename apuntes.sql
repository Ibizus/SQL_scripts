/*drop database if exists tienda;
create database tienda;
use tienda;


drop table if exists libros;

-- SET sql_mode = '';  ELIMINA EL ERROR DE LOS DEFAULT CUANDO ES NOT NULL

create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(20) not null,
  autor varchar(30),
  editorial varchar(15),
  precio decimal(5,2) unsigned,
  cantidad smallint unsigned,
  primary key (codigo)
 );
*/

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
select a.descripcion, a.preciounidad, s.descuento, (s.descuento*100) as p_rebajado from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion order by a.descripcion asc;

-- 5 Obtener todos los datos de los artículos, y el nombre de su sección cuyo precio unidad está por debajo al precio medio de todos los articulos (usando una subconsulta
-- para calcular el precio medio.)
select 'Query 5:';
select a.articulo, a.descripcion, a.preciounidad, a.cod_seccion, s.seccion from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion where a.preciounidad < (select avg(preciounidad) from articulos);

-- 6: Obtener la suma del preciounidad de todos los articulos agrupadas por secciones.
select 'Query 6:';
select s.seccion, sum(a.preciounidad) from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion  group by a.cod_seccion;

-- 7: Obtener todos datos de los articulos cuya seccion no sea ni Deportes ni Ropa
select 'Query 7:';
select * from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion where seccion not like "%Deportes%" and seccion not like "%Ropa%";

-- 8: Una consulta que me devuelva las descripciones de los articulos, su precio por unidad y su precio rebajado 
select 'Query 8:';
select a.descripcion, a.preciounidad, a.preciounidad*(1-s.descuento) as p_rebajado from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion;

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


-- 15 Realizar una procedure a la que se le pasa un dni como variable de entrada y devuelve la cantidad de facturas pendientes de pago que tenga
select 'Query 15:';



