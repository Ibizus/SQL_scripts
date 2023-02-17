Los procedimientos almacenados pueden recibir y devolver información; para ello se emplean parámetros, de entrada y salida, respectivamente.

Veamos los primeros. Los parámetros de entrada posibilitan pasar información a un procedimiento.

Para que un procedimiento almacenado admita parámetros de entrada se deben declarar variables como parámetros al crearlo. La sintaxis es:

 create procedure NOMBREPROCEDIMIENTO (in NOMBREPARAMETRO TIPODEDATO)
 begin
 end

Los parámetros de entrada se definen luego del nombre del procedimiento, previo al nombre del parámetro se le antecede la palabra clave 'in'. Los parámetros son locales al procedimiento, es decir, existen solamente dentro del mismo. Pueden declararse varios parámetros por procedimiento, se separan por comas.

Cuando el procedimiento es ejecutado, deben explicitarse valores para cada uno de los parámetros (en el orden que fueron definidos).

Los parámetros de entrada pueden ser de cualquier tipo de dato.

Por ejemplo creamos el procedimiento almacenado llamado 'pa_libros_autor' que recibe un parámetro de entrada de tipo varchar(30):

 delimiter //
 create procedure pa_libros_autor(in p_autor varchar(30))
 begin
   select titulo, editorial,precio
     from libros
     where autor= p_autor;
 end //
 delimiter ;

Luego para llamar al procedimiento almacenado debemos pasar un valor para el parámetro:

 call pa_libros_autor('Richard Bach');

Servidor de MySQL instalado en forma local.

Ingresemos al programa "Workbench" y ejecutemos el siguiente bloque de instrucciones SQL:

drop table if exists libros;

 create table libros(
  codigo int auto_increment,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  primary key(codigo) 
 );

 insert into libros (titulo,autor,editorial,precio) 
  values ('Uno','Richard Bach','Planeta',15);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Ilusiones','Richard Bach','Planeta',12);
 insert into libros (titulo,autor,editorial,precio) 
  values ('El aleph','Borges','Emece',25);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Aprenda PHP','Mario Molina','Nuevo siglo',50);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Matematica estas ahi','Paenza','Nuevo siglo',18);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Puente al infinito','Bach Richard','Sudamericana',14);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Antología','J. L. Borges','Paidos',24);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Java en 10 minutos','Mario Molina','Siglo XXI',45);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Cervantes y el quijote','Borges- Casares','Planeta',34);

 drop procedure if exists pa_libros_autor;

 delimiter //
 create procedure pa_libros_autor(in p_autor varchar(30))
 begin
   select titulo, editorial,precio
     from libros
     where autor= p_autor;
 end //
 delimiter ;
 
 
 call pa_libros_autor('Richard Bach');

 
 drop procedure if exists pa_libros_autor_editorial;

 delimiter //
 create procedure pa_libros_autor_editorial(
   in p_autor varchar(30),
   in p_editorial varchar(20))
 begin
   select titulo, precio
     from libros
     where autor= p_autor and
           editorial=p_editorial;
 end //
 delimiter ;
 
 call pa_libros_autor_editorial('Richard Bach','Planeta');

 call pa_libros_autor_editorial('Borges','Emece');

