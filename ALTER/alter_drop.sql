/* 
"alter table" nos permite alterar la estructura de la tabla, podemos usarla para eliminar un campo.

Continuamos con nuestra tabla "libros".

Para eliminar el campo "edicion" tipeamos:

 alter table libros
  drop edicion;

Entonces, para borrar un campo de una tabla usamos "alter table" junto con "drop" y el nombre del campo a eliminar.

Si intentamos borrar un campo inexistente aparece un mensaje de error y la acción no se realiza.

Podemos eliminar 2 campos en una misma sentencia:

 alter table libros
  drop editorial, drop cantidad;

Si se borra un campo de una tabla que es parte de un índice, también se borra el índice.

Si una tabla tiene sólo un campo, éste no puede ser borrado.

Hay que tener cuidado al eliminar un campo, éste puede ser clave primaria. Es posible eliminar un campo que es clave primaria, no aparece ningún mensaje:

 alter table libros
  drop codigo;

Si eliminamos un campo clave, la clave también se elimina. */

----------------------------------------------------------------------------------

drop table if exists libros;

create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar (20),
  edicion date,
  precio decimal(5,2) unsigned,
  cantidad int unsigned,
  primary key(codigo)
 );

alter table libros
  drop edicion;

describe libros;

alter table libros
  drop edicion;

alter table libros
  drop editorial, drop cantidad;

alter table libros
  drop codigo;

