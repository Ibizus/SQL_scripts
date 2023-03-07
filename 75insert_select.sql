 
 
 
 
 -- /* NO ENTRA */
 
 
 drop tables if exists libros, editoriales;

 create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(40) not null,
  autor varchar(30),
  codigoeditorial tinyint unsigned,
  precio decimal(5,2) unsigned,
  primary key (codigo)
 );

 create table editoriales(
  codigo tinyint unsigned auto_increment,
  nombre varchar(20),
  domicilio varchar(30),
  primary key(codigo)
 );

 -- /* NO ENTRA */

 insert into libros values (1,'El aleph','Borges',2,23.5);
 insert into libros values (2,'Alicia en el pais de las maravillas','Lewis Carroll',1,15);
 insert into libros values (3,'Matematica estas ahi','Paenza',2,34.6);
 insert into libros values (4,'Martin Fierro','Jose Hernandez',3,43.5);
 insert into libros values (5,'Martin Fierro','Jose Hernandez',2,12);

 insert into editoriales values(1,'Planeta','San Martin 222');
 insert into editoriales values(2,'Emece','San Martin 590');
 insert into editoriales values(3,'Paidos','Colon 245');

 insert into libros (titulo,autor,codigoeditorial,precio)
  select 'Harry Potter y la camara secreta','J.K.Rowling',codigo,45.90
  from editoriales
  where nombre='Emece';
  -- El registro se cargará con el valor de código de la editorial "Emece".

 -- Veamos qué sucedió:
 select * from libros;

  -- Si buscamos el código de una editorial que no existe en la tabla "editoriales",
  -- la consulta no retornará ningún registro y la inserción no se realizará. Veamos
  -- un ejemplo:
 insert into libros (titulo,autor,codigoeditorial,precio)
  select 'Cervantes y el quijote','Borges',codigo,35
  from editoriales
  where nombre='Plaza & Janes';

 -- /* NO ENTRA */

 -- Queremos ingresar el siguiente registro:
 -- Harry Potter y la camara secreta, J.K. Rowling,54.
 -- pero no recordamos el código de la editorial ni su nombre, sólo sabemos que su 
 -- domicilio es en calle "San Martin". Si con un "select" localizamos 
 -- el código de todas las editoriales que tengan sede en "San Martin",
 -- el resultado retorna 2 filas, porque hay 2 editoriales en esa dirección 
 -- ("Planeta" y "Emece"). Tipeeemos la sentencia:
 insert into libros (titulo,autor,codigoeditorial,precio)
  select 'Harry Potter y la camara secreta','J.K. Rowling',codigo,54
  from editoriales
  where domicilio like 'San Martin%';

 -- Veamos qué sucedió:
 select * from libros;
 
 
