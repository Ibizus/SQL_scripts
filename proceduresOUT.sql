Dijimos que los procedimientos almacenados pueden devolver información; para ello se emplean parámetros de salida. El valor se retorna a quien realizó la llamada con parámetros de salida. Para que un procedimiento almacenado devuelva un valor se debe declarar una variable con la palabra clave "out" al crear el procedimiento:

 create procedure NOMBREPROCEDIMIENTO (out NOMBREPARAMETRO TIPODEDATO)
 begin
 end

Como ejemplo implementaremos un procedimiento almacenado que le enviemos dos enteros y nos retorne el promedio de dichos valores:

 drop procedure if exists pa_promedio;
 
 delimiter //
 create procedure pa_promedio(
   in n1 float,
   in n2 float,
   out resultado float)
 begin
   select (n1+n2)/2 into resultado;
 end //
 delimiter ;
 
 call pa_promedio(10, 5, @resu);
 
 select @resu;

El procedimiento almacenado tiene tres parámetros, los dos primeros son de entrada y el último es de salida. Mediante un select calculamos el promedio de los parámetros n1 y n2, guardamos en el parámetro 'resultado' el promedio de los dos primeros parámetros.

Cuando llamamos al procedimiento almacenado debemos pasar dos valores numéricos y como último dato una variable donde se almacene el resultado:

 call pa_promedio(10, 5, @resu);

Luego imprimimos el valor almacenado en la variable @resu:

select @resu;

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
   select sum(precio) into suma
     from libros
     where autor=p_autor;
   select avg(precio) into promedio
     from libros
     where autor=p_autor;
 end; //
 delimiter ;
 
 
 -- Llamamos al procedimiento almacenado que nos retorna la suma de precios 
 -- de todos los libros y su promedio del autor 'Richard Bach'
 call pa_autor_sumaypromedio('Richard Bach', @s,@p);
 select @s, @p;

 call pa_autor_sumaypromedio('Borges', @s,@p);
 select @s, @p;

