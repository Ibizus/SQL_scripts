drop database if exists libreria;
 create database libreria;
 use libreria;

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
  values ('Antología','Borges','Paidos',24);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Java en 10 minutos','Mario Molina','Siglo XXI',45);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Cervantes y el quijote','Borges- Casares','Planeta',34);
 
 drop procedure if exists pa_autor_sumaypromedio;

 -- creamos un procedimiento almacenado que recibe el nombre de un autor
 -- y nos retorna la suma de precios de todos sus libros y su promedio
 
 delimiter //
 create procedure pa_autor_sumaypromedio(
   in p_autor varchar(30),
   out suma decimal(6,2),
   out promedio decimal(6,2))
 begin
   select titulo,editorial,precio
     from libros
     where autor=p_autor;
   select sum(precio) into suma -- into guarda suma en vez de simplemente mostrarla
     from libros
     where autor=p_autor;
   select avg(precio) into promedio
     from libros
     where autor=p_autor;
 end; //
 delimiter ;
 
 
 -- Llamamos al procedimiento almacenado que nos retorna la suma de precios 
 -- de todos los libros y su promedio del autor 'Richard Bach'
 -- Variables se ponen con @, @s es suma, @p es promedio. El select muetra el contenido de las variables
 
 call pa_autor_sumaypromedio('Richard Bach', @s,@p);
 select @s, @p;

 call pa_autor_sumaypromedio('Borges', @s,@p);
 select @s as suma, @p as promedio;
 
 -- Los valores de salida tienen que estar en un out, guardarse con el into y al final se muestran con @nombrequequieras y los llamas con el select para que se muestren
 -- Los procedimientos que se hacen se quedan almacenados en la bbdd que se está usando
 
 -- Un procedimiento al que le pase un autor y devuelva el valor máximo y mínimo de sus libros
  
 drop procedure if exists pa_autor_max_min;
  
 delimiter //
 create procedure pa_autor_max_min(
   in p_autor varchar(30),
   out p_max decimal(6,2),
   out p_min decimal(6,2))
 begin
   select titulo,editorial,precio
     from libros
     where autor=p_autor;
   select max(precio) into p_max
     from libros
     where autor=p_autor;
   select min(precio) into p_min
     from libros
     where autor=p_autor;
 end; //
 delimiter ;
 
 call pa_autor_max_min ('Borges', @ma, @mi);
 select @ma, @mi; 
 
 
 
 -- /* Un procedimiento que devuelva el valor máximo de precio de los los libros, y el otro es el autos de dicho libro */
 
 drop procedure if exists pa_autor_max;
  
 delimiter //
 create procedure pa_autor_max(
   out p_max decimal(6,2),
   out p_autor varchar(30))
 begin
   select max(precio) into p_max
     from libros;
   select autor into p_autor
     from libros
     where precio=p_max limit 1;
 end; //
 delimiter ;
 
 call pa_autor_max (@ma, @aut);
 select @ma, @aut; 
 
 
 
 -- /* Un procedimiento que reciba una editorial y devuelva el número de libros que tiene. Pruebalo con varias llamadas diferentes */
 
  drop procedure if exists pa_numEditorial;
  
 delimiter //
 create procedure pa_numEditorial(
   in p_edit varchar(30),
   out p_num int)
 begin
   select count(*) into p_num
     from libros
     where editorial = p_edit;
 end; //
 delimiter ;
 
 call pa_numEditorial ('Planeta', @num);
 select 'Planeta', @num;
 
 
 -- /* Otro ejemplo con otra editorial usando alias para mostrar la tabla */
 
   drop procedure if exists pa_numEditorial;
  
 delimiter //
 create procedure pa_numEditorial(
   in p_edit varchar(30),
   out p_num int)
 begin
   select count(*) into p_num
     from libros
     where editorial = p_edit;
 end; //
 delimiter ;
 
 call pa_numEditorial ('Nuevo siglo', @num);
 select 'Nuevo siglo' as Editorial, @num as Cantidad;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
