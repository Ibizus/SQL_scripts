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

/* Programa las acciones necesarias para que al borrar una editorial se borren sus libros 
(Si lanzo delete from editoriales where nombre='Emece' se tienen que borrar tambien sus libros asociados)*/

select 'PROGRAMADO CON ALTER:';

-- primero metemos una FK con delete cascade en codigo libro:
alter table libros add foreign key (codigoeditorial) references editoriales(codigo) on delete cascade;
-- traza para ver como queda antes del delete:
select * from editoriales;
select * from libros;
-- lanzamos el delete:
delete from editoriales where nombre = 'Emece';
-- traza para ver el resultado:
select * from editoriales;
select * from libros;



/* UPDATE CASCADE */ 
/* Programa el altar table necesario para una FK con actualizacion en cascada */
/* Realizar el update necesario para incrementar los codigos de editoriales en 10:
(codigo = codigo+10) aprovechando la funcionalidad de la FK anterior*/
alter table libros add foreign key (codigoeditorial) references editoriales(codigo) on update cascade;
-- traza para ver como queda antes del delete:
select * from editoriales;
select * from libros;
-- lanzamos el delete:
update editoriales set codigo = codigo+10;
-- traza para ver el resultado:
select * from editoriales;
select * from libros;



/*
select 'DELETE CON JOIN';
 -- Borrar la editorial "Emece" y todos los libros de "libros" de esta editorial:
 delete libros,editoriales
  from libros
  join editoriales
  on libros.codigoeditorial=editoriales.codigo
  where editoriales.nombre='Emece';

 select * from editoriales;
 
 select * from libros;
 /*

  
 
