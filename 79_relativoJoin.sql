drop database if exists prueba;
create database prueba;
use prueba;

 create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(40),
  autor varchar(30),
  codigoeditorial tinyint unsigned,
  precio decimal(5,2) unsigned,
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
 insert into editoriales values(4,'Plaza & Janes');

 insert into libros values (1,'El aleph','Borges',2,44.20);
 insert into libros values (2,'Alicia en el pais de las maravillas','Lewis Carroll',1,12.33);
 insert into libros values (3,'Matematica estas ahi','Paenza',2,9.99);
 insert into libros values (4,'Martin Fierro','Jose Hernandez',3,17.22);
 insert into libros values (5,'Martin Fierro','Jose Hernandez',2,23.56);


 -- Queremos modificar el código de la editorial "Emece" a "9" y también todos
 -- los  "codigoeditorial" de los libros de dicha editorial:

-- punto de partida:
select * from libros;
select * from editoriales;

-- update:
 update libros as l 
 	join editoriales as e 
 	on l.codigoeditorial=e.codigo
 	set l.codigoeditorial=9, e.codigo=9
 	where e.nombre='Emece';
 	
 -- traza resultado:
select * from libros;
select * from editoriales;
 
 
 
