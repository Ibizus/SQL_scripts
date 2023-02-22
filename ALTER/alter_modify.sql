/*
Con "alter table" podemos modificar el tipo de algún campo incluidos sus atributos.

Continuamos con nuestra tabla "libros", definida con la siguiente estructura:

 - código, int unsigned,
 - titulo, varchar(30) not null,
 - autor, varchar(30),
 - editorial, varchar (20),
 - precio, decimal(5,2) unsigned,
 - cantidad int unsigned.

Queremos modificar el tipo del campo "cantidad", como guardaremos valores que no superarán los 50000 usaremos smallint unsigned, tipeamos:

 alter table libros
  modify cantidad smallint unsigned;

Usamos "alter table" seguido del nombre de la tabla y "modify" seguido del nombre del nuevo campo con su tipo y los modificadores.

Queremos modificar el tipo del campo "titulo" para poder almacenar una longitud de 40 caracteres y que no permita valores nulos, tipeamos:

 alter table libros
  modify titulo varchar(40) not null;

Hay que tener cuidado al alterar los tipos de los campos de una tabla que ya tiene registros cargados. Si tenemos un campo de texto de longitud 50 y lo cambiamos a 30 de longitud, los registros cargados en ese campo que superen los 30 caracteres, se cortarán (en versiones nuevas de MySQL 8.x genera un error y no modifica la estructura de la tabla)

Igualmente, si un campo fue definido permitiendo valores nulos, se cargaron registros con valores nulos y luego se lo define "not null", todos los registros con valor nulo para ese campo cambiarán al valor por defecto según el tipo (cadena vacía para tipo texto y 0 para numéricos), ya que "null" se convierte en un valor inválido.

Si definimos un campo de tipo decimal(5,2) y tenemos un registro con el valor "900.00" y luego modificamos el campo a "decimal(4,2)", el valor "900.00" se convierte en un valor inválido para el tipo, entonces guarda en su lugar, el valor límite más cercano, "99.99" (en versiones nuevas de MySQL genera un error y no modifica la estructura de la tabla).

Si intentamos definir "auto_increment" un campo que no es clave primaria, aparece un mensaje de error indicando que el campo debe ser clave primaria. Por ejemplo:

 alter table libros
  modify codigo int unsigned auto_increment;

"alter table" combinado con "modify" permite agregar y quitar campos y atributos de campos. Para modificar el valor por defecto ("default") de un campo podemos usar también "modify" pero debemos colocar el tipo y sus modificadores, entonces resulta muy extenso, podemos setear sólo el valor por defecto con la siguiente sintaxis:

 alter table libros
 alter autor set default 'Varios';

Para eliminar el valor por defecto podemos emplear:

 alter table libros
 alter autor drop default; */

------------------------------------------------------------------------

drop table if exists libros;

create table libros(
  codigo int unsigned,
  titulo varchar(30) not null,
  autor varchar(30),
  editorial varchar (20),
  precio decimal(5,2) unsigned,
  cantidad int unsigned
 );

alter table libros
  modify cantidad smallint unsigned;

describe libros;

alter table libros
  modify titulo varchar(40) not null;

describe libros;

insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El aleph','Borges','Planeta',23.5,100);
insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Alicia en el pais de las maravillas','Lewis Carroll','Emece',25,200);
insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El gato con botas',null,'Emece',10,500);
insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Martin Fierro','Jose Hernandez','Planeta',150,200);

alter table libros
  modify autor varchar(10);

select * from libros;

alter table libros
  modify autor varchar(10) not null;

select * from libros;

alter table libros
  modify precio decimal(4,2);

select * from libros;

alter table libros
  modify codigo int unsigned auto_increment;
  
/* MODIFICAR EL NOMBRE DE UN CAMPO: */
-- ponemos el nombre del campo y seguidamente el nbombre que qeremos darle
-- además de poder cambiar su tamaño o añadir o quitar alguna característica

 alter table libros
  change precio costo decimal (5,2);

alter table libros
  change titulo nombre_libro varchar(40) not null;

describe libros;



