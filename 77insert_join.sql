 drop table libros, editoriales, cantidadporeditorial;

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
 
 create table cantidadporeditorial(
  nombre varchar(20),
  cantidad smallint unsigned
 );

 insert into libros values (1,'El aleph','Borges',2,23.5);
 insert into libros values (2,'Alicia en el pais de las maravillas',
                            'Lewis Carroll',1,15);
 insert into libros values (3,'Matematica estas ahi','Paenza',2,34.6);
 insert into libros values (4,'Martin Fierro','Jose Hernandez',3,43.5);
 insert into libros values (5,'Martin Fierro','Jose Hernandez',2,12);

 insert into editoriales values(1,'Planeta');
 insert into editoriales values(2,'Emece');
 insert into editoriales values(3,'Paidos');
 insert into editoriales values(4,'Plaza & Janes');

 insert into cantidadporeditorial
  select e.nombre,count(l.codigoeditorial)
  from editoriales as e
  left join libros as l
  on e.codigo=l.codigoeditorial
  group by e.nombre;

 select * from cantidadporeditorial;
 
 
