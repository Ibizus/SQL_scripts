drop table if exists libros;

create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15),
  precio decimal(5,2) unsigned,
  primary key(codigo)
 );

insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Planeta',15.50);
insert into libros (titulo,autor,editorial,precio)
  values('Martin Fierro','Jose Hernandez','Emece',22.90);
insert into libros (titulo,autor,editorial,precio)
  values('Antologia poetica','J.L. Borges','Planeta',39);
insert into libros (titulo,autor,editorial,precio)
  values('Aprenda PHP','Mario Molina','Emece',19.50);
insert into libros (titulo,autor,editorial,precio)
  values('Cervantes y el quijote','Bioy Casare- J.L. Borges','Paidos',35.40);
insert into libros (titulo,autor,editorial,precio)
  values('Manual de PHP', 'J.C. Paez', 'Paidos',19);
insert into libros (titulo,autor,editorial,precio)
  values('Harry Potter y la piedra filosofal','J.K. Rowling','Paidos',45.00);
insert into libros (titulo,autor,editorial,precio)
  values('Harry Potter y la camara secreta','J.K. Rowling','Paidos',46.00);
insert into libros (titulo,autor,editorial,precio)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Paidos',36.00);

/* Para recuperar todos los libros cuyo autor sea "Borges": */
select 'TODOS LOS LIBROS CUYO AUTOR SEA BORGES:' as '';
select * from libros
  where autor='Borges';

/* Para recuperar todos los registros cuyo autor contenga la cadena "Borges": */
select 'TODOS LOS REGISTROS QUE CONTENGAN LA CADENA "Borges":' as '';
select * from libros
  where autor like '%Borges%';

/* Para seleccionar todos los libros que comiencen con "A": */
select 'TODOS LOS LIBROS QUE COMIENCEN CON "A":' as '';
select * from libros
 where titulo like 'A%';

/* Para seleccionar todos los libros que no comiencen con "A": */
select 'TODOS LOS LIBROS QUE NO COMIENCEN CON A:' as '';
select * from libros
  where titulo not like 'A%';

/* Para libros de "Lewis Carroll" pero no recordamos si se escribe "Carroll" o "Carrolt",: */
select 'PARA:' as '';
select * from libros
  where autor like '%Carrol_';

/* Para recuperar todos los registros cuyo titulo contenga la cadena "Harry Potter": */
select 'TITULOS QUE CONTENGAN HARRY POTTER:' as '';
select * from libros
  where titulo like '%Harry Potter%';

/* Para recuperar todos los registros cuyo titulo contenga la cadena "PHP": */
select 'TITULOS QUE CONTENGAN PHP:' as '';
select * from libros
  where titulo like '%PHP%';
  
/* Libros cuyo autor tiene una M contenida en el nombre y el precio es menor de 30 o no tiene una M y el precio es mayor de 30 */
select * from libros where (autor like '%M%' and precio <30) or (autor not like '%M%' and precio > 30);


