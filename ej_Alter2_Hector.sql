drop database if exists pruebas;
create database pruebas;
use pruebas;

create table libros(
  codigo int,
  nombre varchar(40),
  autor varchar(30),
  editorial varchar (20),
  costo decimal(5,2)
 );
 
 insert into libros values (1,'El aleph','Borges','Emece',23.5);
 insert into libros values (2,'Alicia en el pais de las maravillas','Lewis Carroll','Planeta',15);
 insert into libros values (3,'Matematica estas ahi','Paenza','Emece',34.6);
 insert into libros values (4,'Martin Fierro','Jose Hernandez','Paidos',43.5);
 insert into libros values (5,'Martin Fierro2','Jose Hernandez','Planeta',12);
 insert into libros values (6,'Aprenda PHP','Mario Molina','Paidos',21.8);
 insert into libros values (7,'Aprenda Java','Mario Molina','Paidos',55.4);
 insert into libros values (8,'Alicia a traves del espejo','Lewis Carroll','Emece',18);
 insert into libros values (9,'Antologia poetica','Borges','Paidos',47.9);

-- 1 Añade una clave primaria para el campo codigo. Haz un describe table para ver los cambios.
 alter table libros
   add primary key (codigo);

-- 2 Añade un índice múltiple (indice normal) para el campo autor. Haz un describe.
 alter table libros
   add index i_autor (autor);
   
describe libros;
  
-- 3 Suponemos que no debe repetirse en la tabla valores duplicados para los títulos de libros. Realiza las acciones oportunas para que el gestor dé error en caso de que vaya a ocurrir.Haz un describe
 alter table libros
   drop primary key;
   
 alter table libros
   add primary key (nombre);
   
describe libros;
  
-- 4 Cambia el nombre del campo "costo" por "precio" y el de el campo "nombre" por "titulo". Haz un describe.
 alter table libros
   change costo precio decimal(5,2);
   
 alter table libros
   change nombre titulo varchar(40);
   
describe libros;
  
-- 5 Cambia la longitud del campo titulo a 50 caracteres máximo. Haz un describe
 alter table libros
   modify titulo varchar(50);
   
 describe libros;
  
-- 6 Añade un nuevo campo de tipo int llamado "stock", cuyo valor por defecto será 1. Este campo no podrá ser nulo. Haz un describe
 alter table libros
   add stock integer not null default 1;
   
 describe libros;
  
-- 7 A partir de la tabla libros, generar una tabla llamada libros_v2 obtenida a partir de una consulta que recorra la tabla libros de forma descendente por código y obtenga la nueva tabla con el campo codigo autoincremental y no aparezcan las editoriales.
 
describe libros;

/* Cuando creas una tabla a traves de una consulta no se crean ni los indices ni los primary keys */
 create table libros_v2
  select codigo, titulo, autor, precio, stock from libros order by codigo desc;
  
describe libros_v2;
select * from libros_v2;

/* borramos el anterior codigo, y volvemos a crearlo, con el aorden en el que se creó la tabla */
 alter table libros_v2
   drop codigo;
 
 alter table libros_v2
   add codigo integer primary key auto_increment;

describe libros_v2;
select * from libros_v2;


