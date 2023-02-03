 drop database if exists libreria;
 create database libreria;
 use prueba;
 
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

-- Borrar procedimiento
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

-- Borrar procedimiento 
 drop procedure if exists pa_libros_autor_editorial;

-- Procedimiento con dos in
 delimiter //
 create procedure pa_libros_autor_editorial(
   in p_autor varchar(30),
   in p_editorial varchar(20))
 begin
   select titulo, precio, autor, editorial
     from libros
     where autor= p_autor and
           editorial=p_editorial;
 end //
 delimiter ;
 
 call pa_libros_autor_editorial('Richard Bach','Planeta');

 call pa_libros_autor_editorial('Borges','Emece');
 
 
 
-- Haz un pa (procedimiento de almacenado) como el anterior pero filtrando por un determinado precio
-- Por ej, mostrar libros de un autor, una editorial y de un precio menor a uno dado que pasa como argumento
-- Se pone p_ para comparar con los campos y que no tenga el mismo nombre

drop procedure if exists pa_libros_autor_editorial_precio;
delimiter //
create procedure pa_libros_autor_editorial_precio (
	in p_autor varchar(30),
	in p_editorial varchar(20), 
	in p_precio decimal (5,2)
	)
begin
	select titulo, precio, autor, editorial from libros
	where autor = p_autor and precio = p_precio and editorial = p_editorial;
end //
delimiter ; -- Si no pones este espacio no funciona
-- si te da este error ya no te reconoce el archivo, w t f

call pa_libros_autor_editorial_precio ('Richard Bach', 'Planeta', 15);

-- Procedimiento sin argumentos
-- Hacer un procedimiento llamado pa_mayor() que devuelve el precio mayor de los libros
drop procedure if exists pa_mayor;

delimiter //
create procedure pa_mayor()
begin
	select max(precio) from libros; 
end //
delimiter ; 

call pa_mayor(); 





















