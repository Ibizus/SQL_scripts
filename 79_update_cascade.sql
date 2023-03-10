drop database if exists prueba;
create database prueba;
use prueba;

drop table if exists libros, editoriales;

 create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(40),
  autor varchar(30),
  codigoeditorial tinyint unsigned, -- foreign key references editoriales(codigo) on delete cascade; (así sería en caso de construir la tabla directamente)
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

 insert into libros values (1,'El aleph','Borges',2);
 insert into libros values (2,'Alicia en el pais de las maravillas','Lewis Carroll',1);
 insert into libros values (3,'Matematica estas ahi','Paenza',2);
 insert into libros values (4,'Martin Fierro','Jose Hernandez',3);
 insert into libros values (5,'Martin Fierro','Jose Hernandez',2);

/* UPDATE CASCADE */ 

/* Programa el altar table necesario para una FK con actualizacion en cascada */
/* Realizar el update necesario para incrementar los codigos de editoriales en 10:
(codigo = codigo+10) aprovechando la funcionalidad de la FK anterior*/
alter table libros add foreign key (codigoeditorial) references editoriales(codigo) on update cascade;
-- traza para ver como queda antes del delete:
select 'ANTES DE CAMBIAR EL CAMPO:';
select * from editoriales;
select * from libros;
-- lanzamos el delete:
update editoriales set codigo = codigo+10;
-- traza para ver el resultado:
select 'UNA VEZ PROGRAMADO EL CAMBIO DEL CAMPO CODIGO:';
select * from editoriales;
select * from libros;



