drop table if exists libros, editoriales;

 create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2) unsigned,
  primary key(codigo)
 );

 create table editoriales(
  nombre varchar(20)
 );

 insert into libros values (1,'El aleph','Borges','Emece',23.5);
 insert into libros values (2,'Alicia en el pais de las maravillas',
                            'Lewis Carroll','Planeta',15);
 insert into libros values (3,'Matematica estas ahi','Paenza','Emece',34.6);
 insert into libros values (4,'Martin Fierro','Jose Hernandez','Paidos',43.5);
 insert into libros values (5,'Martin Fierro','Jose Hernandez','Planeta',12);
 insert into libros values (6,'Aprenda PHP','Mario Molina','Paidos',21.8);
 insert into libros values (7,'Aprenda Java','Mario Molina','Paidos',55.4);
 insert into libros values (8,'Alicia a traves del espejo','Lewis Carroll','Emece',18);
 insert into libros values (9,'Antologia poetica','Borges','Paidos',47.9);


-- Rellenar la tabla de editoriales con las editoriales que aparecen en los libros:
select editorial from libros group by editorial;









 insert into editoriales (nombre)
  select distinct editorial from libros;

 select * from editoriales;

  select editorial,count(*)
  from libros
  group by editorial;

 drop table if exists cantidadporeditorial;

 create table cantidadporeditorial(
  nombre varchar(20),
  cantidad smallint unsigned
 );

 insert into cantidadporeditorial (nombre,cantidad)
  select editorial,count(*) as cantidad
  from libros
  group by editorial;

 select * from cantidadporeditorial;
