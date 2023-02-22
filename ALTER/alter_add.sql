/* 
 Para modificar la estructura de una tabla existente, usamos "alter table".

"alter table" se usa para:

- agregar nuevos campos,

- eliminar campos existentes,

- modificar el tipo de dato de un campo,

- agregar o quitar modificadores como "null", "unsigned", "auto_increment",

- cambiar el nombre de un campo,

- agregar o eliminar la clave primaria,

- agregar y eliminar índices,

- renombrar una tabla.

"alter table" hace una copia temporal de la tabla original, realiza los cambios en la copia, luego borra la tabla original y renombra la copia.

Aprenderemos a agregar campos a una tabla.

Para ello utilizamos nuestra tabla "libros", definida con la siguiente estructura:

 - código, int unsigned auto_increment, clave primaria,
 - titulo, varchar(40) not null,
 - autor, varchar(30),
 - editorial, varchar (20),
 - precio, decimal(5,2) unsigned.

Necesitamos agregar el campo "cantidad", de tipo smallint unsigned not null, tipeamos:

 alter table libros
  add cantidad smallint unsigned not null;

Usamos "alter table" seguido del nombre de la tabla y "add" seguido del nombre del nuevo campo con su tipo y los modificadores.

Agreguemos otro campo a la tabla:

 alter table libros
  add edicion date;

Si intentamos agregar un campo con un nombre existente, aparece un mensaje de error indicando que el campo ya existe y la sentencia no se ejecuta.

Cuando se agrega un campo, si no especificamos, lo coloca al final, después de todos los campos existentes; podemos indicar su posición (luego de qué campo debe aparecer) con "after":

 alter table libros
 add cantidad tinyint unsigned after autor; */

----------------------------------------------------------------------------------------

drop table if exists libros;

create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar (20),
  precio decimal(5,2) unsigned,
  primary key(codigo)
 );

alter table libros
  add cantidad smallint unsigned not null;
  
-- se le puede poner default para darle un valor por defecto.

describe libros;

alter table libros
  add edicion date;

describe libros;

alter table libros
  add precio int;

