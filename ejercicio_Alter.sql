
/* Crear un script .sql que genere dos tablas, una de artículos y otra de departamentos.

	Los artículos contienen: 
	un id int autoincremental, (PK)
	una descripción,
	un precio base.
	(foreign key relativa al departamento al que pertenece)
	
	Los departamentos tendrán:
	un codigo autoincremental, (PK)
	un nombre,
	un descuento asociado.
	
El mismo script generará 4 artículos y dos departamentos.

Se pide:

-> Realizar las acciones necesarias para alterar la tabla de articulos con un campo más (precio rebajado según su departamento) que se actualizará teniendo en cuenta el precio del artículo y el descuento en su departamento. */

drop database if exists tienda;
create database tienda;
use tienda;

drop table if exists departamentos;
create table departamentos(
	codigo int unsigned auto_increment primary key,
	nombre varchar (20),
	descuento decimal (3,2) unsigned
	);
	
/* Tengo que haber creado antes "departamentos" para poder referenciarla como foreign key */
drop table if exists articulos;
create table articulos(
	id int unsigned auto_increment primary key,
	descripcion varchar(40),
	precio_base decimal(5,2) unsigned,
	cod_dep int unsigned,
	foreign key (cod_dep) references departamentos(codigo)
	);

/* Meto primero valores en departamentos porque si lo hago al revés da error al meter la FK cod_departamento */
insert into departamentos values(1,'Electronica',0.10);
insert into departamentos values(2,'Textil',0.25);	

insert into articulos values(1,'8 GB Memoria Ram',50.00,1);
insert into articulos values(2,'Placa base ASUS',99.00,1);
insert into articulos values (3, 'Traje', 125.00,2);
insert into articulos values(4,'Procesador Intel i7',185.00,1);
insert into articulos values (5, 'Pantalón Vaquero', 35.00,2);

select * from articulos;

/* PROGRAMACIÓN PEDIDA */

 alter table articulos add precio_final decimal(7,2);
 
 select * from articulos;
 
 update articulos join departamentos on articulos.cod_dep = departamentos.codigo
 set precio_final = precio_base*(1-descuento);
 
 select * from articulos;
	
	
/* Partiendo de las dos tablas anteriores crear una nueva tabla dinamicamente rellenada con la información
de los articulos y para cada articulo aparecerá el nombre de su departamento */

/* Este tipo de operativa se hace anteponiendo 
 create table art_dept a la consulta select que 
 nos devuelve los resultados buscados */
 
 
-- Primero hago la consulta y la pruebo:
select a.*, d.nombre from articulos as a join departamentos as d on a.cod_dep=d.codigo;
 
-- Añado create table delante y ya me vuelca los resultados del select en una nueva tabla:
create table art_dept select a.*, d.nombre from articulos as a join departamentos as d on a.cod_dep=d.codigo;
 
-- Compruebo que funciona:
select * from art_dept;
 
-- Ahora crea esa misma tabla sin que aparezca el código de departamento:
drop table if exists art_dept;
create table art_dept select a.id, a.descripcion, a.precio_base, a.precio_final, d.nombre from articulos as a join departamentos as d on a.cod_dep=d.codigo;
 
 select * from art_dept;
 
 
 
 
 
 

