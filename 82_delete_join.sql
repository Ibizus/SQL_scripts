drop database if exists prueba;
create database prueba;
use prueba;

drop table if exists libros, editoriales;

 create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(40),
  autor varchar(30),
  codigoeditorial tinyint unsigned,
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


-- PARTIMOS DE TENER UNA fk CREADA EN LA TABLA:
alter table libros add foreign key (codigoeditorial) references editoriales(codigo) on delete cascade;

-- traza para ver punto de partida:
select 'PUNTO DE PARTIDA';
select * from editoriales;
select * from libros;

-- REALIZA LAS ACCIONES NECESARIAS PARA:

-- Para ver cual es el nombre de la FK creada:
show create table libros;

-- Eliminar la FK:
alter table libros drop foreign key libros_ibfk_1;

-- Realizar un nuevo DELETE para conseguir el resultado anterior sin delete on cascade:
delete editoriales,libros from editoriales join libros on libros.codigoeditorial = editoriales.codigo where editoriales.nombre = 'Emece';

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




