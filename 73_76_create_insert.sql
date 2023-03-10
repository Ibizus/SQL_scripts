drop database if exists prueba;
create database prueba;
use prueba;

drop table if exists libros, editoriales;

 create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(40),
  autor varchar(30),
  codigoeditorial tinyint unsigned,
  precio decimal(5,2),
  primary key(codigo)
 );

 create table editoriales(
  codigo tinyint unsigned auto_increment,
  nombre varchar(20),
  primary key(codigo)
 );

 insert into editoriales values(1,'Planeta');
 insert into editoriales values(2,'Emece');
 insert into editoriales values(3,'Paidos');

 insert into libros values (1,'El aleph','Borges',2,100);
 insert into libros values (2,'Alicia en el pais de las maravillas','Lewis Carroll',1,200);
 insert into libros values (3,'Matematica estas ahi','Paenza',2,50);
 insert into libros values (4,'Martin Fierro','Jose Hernandez',3,80);
 insert into libros values (5,'Martin Fierro','Jose Hernandez',2,50);

/* Programar la creacion de una tabla (llamada libros 2) que contendrá los mismo registros que libros pero a mitad de precio los libros de Emece */

select 'TABLA ORIGINAL:';
-- traza de la tabla original:
select * from libros;

select 'CONSULTA QUE QUEREMOS:';
/* Consulta que obtiene los datos que quiero: */
select l.codigo, titulo, autor, codigoeditorial, round((precio/2),2) from libros as l join editoriales as e on l.codigoeditorial = e.codigo where e.nombre = 'Emece';

select 'TABLA NUEVA:';
/* Creo la tabla AÑADIENDO CREATE al select anterior */
create table libros2 select l.codigo, titulo, autor, codigoeditorial, round((precio/2),2) as precioNuevo from libros as l join editoriales as e on l.codigoeditorial = e.codigo where e.nombre = 'Emece';

-- traza de la nueva tabla libros2:
select * from libros2;

select 'TABLA CON TODOS LOS DATOS:';
/* Meto el resto de los datos CON INSERT (de la condicion contraria) */
insert into libros2 select l.codigo, titulo, autor, codigoeditorial, precio from libros as l join editoriales as e on l.codigoeditorial = e.codigo where e.nombre <> 'Emece';

-- traza de la nueva tabla libros2 actualizada:
select * from libros2;



