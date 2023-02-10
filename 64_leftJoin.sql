/*A) Un club dicta clases de distintos deportes. En una tabla llamada "socios" guarda los datos de 
sus socios y en una tabla denominada "matriculas" almacena la información necesaria para las 
inscripciones de los socios a los distintos deportes.*/

drop database if exists actividades64;
create database actividades64;
use actividades64;
drop table if exists socios;
drop table if exists matriculas;

 create table socios(
  dni char(8) not null,
  nombre varchar(30),
  domicilio varchar(30),
  primary key(dni)
 );

 create table matriculas(
  dni char(8) not null, 
  deporte varchar(15) not null,
  año year,
  matricula char(1), /*si está pagada ='s' sino 'n'*/
  primary key(dni,deporte,año)
 );

 insert into socios values('22333444','Juan Perez','Colon 234');
 insert into socios values('23333444','Maria Lopez','Sarmiento 465');
 insert into socios values('24333444','Antonio Juarez','Caseros 980');
 insert into socios values('25333444','Ana Juarez','Sucre 134');
 insert into socios values('26333444','Sofia Herrero','Avellaneda 1234');

 insert into matriculas values ('22333444','natacion','2015','s');
 insert into matriculas values ('22333444','natacion','2016','n');
 insert into matriculas values ('23333444','natacion','2015','s');
 insert into matriculas values ('23333444','tenis','2016','s');
 insert into matriculas values ('23333444','natacion','2016','s');
 insert into matriculas values ('25333444','tenis','2016','n');
 insert into matriculas values ('25333444','basquet','2016','n');
 
-- 1- Muestre el nombre del socio, deporte y año realizando un join:
select * /*nombre, deporte, año*/ from socios join matriculas where matriculas.dni = socios.dni;
 
-- 2- Muestre los nombres de los socios que no se han matriculado nunca en un deporte:
select * from socios join matriculas on socios.dni = matriculas.dni; /*Este es el mismo que el anterior*/
select * from socios left join matriculas on socios.dni = matriculas.dni;
/* el JOIN me muestra las coincidencias entre ambas tablas, el LEFTJOIN me muestra toda la tabla izquierda y sus valores asociados de la tabla derecha (y si no hay me pone NULL) */
select * from socios left join matriculas on socios.dni = matriculas.dni where matriculas.dni is null;
/* el ON es el que "enchufa" las dos tablas, y el where el filtro */

-- 3- Omita la referencia a las tablas en la condición "on" para verificar que la sentencia no se ejecuta porque el nombre del campo "dni" es ambiguo (ambas tablas lo tienen):





/********************************************************************************************/
/*Un club de barrio realiza una rifa anual y guarda los datos de las rifas en dos tablas, una 
denominada "premios" y otra llamada "numerosrifa".*/

drop table if exists premios;
drop table if exists numerosrifa;

 create table premios(
  posicion tinyint unsigned auto_increment,
  premio varchar(40),
  numeroganador tinyint unsigned,
  primary key(posicion)
 );
 
 create table numerosrifa(
  numero tinyint unsigned not null,
  dni char(8) not null,
  primary key(numero)
 );

 insert into premios values(1,'PC I7',205);
 insert into premios values(2,'Televisor 75 pulgadas',29);
 insert into premios values(3,'Microondas',5);
 insert into premios values(4,'Multiprocesadora',15);
 insert into premios values(5,'Cafetera',33);

 insert into numerosrifa values(205,'22333444');
 insert into numerosrifa values(200,'23333444');
 insert into numerosrifa values(5,'23333444');
 insert into numerosrifa values(8,'23333444');
 insert into numerosrifa values(1,'24333444');
 insert into numerosrifa values(109,'28333444');
 insert into numerosrifa values(15,'30333444');
 insert into numerosrifa values(29,'29333444');
 insert into numerosrifa values(28,'32333444');

-- 4- Muestre todos los números de rifas vendidos ("numerosrifas") y realice un "left join" mostrando la posición y el premio:
 
 
-- 5- Muestre los mismos datos anteriores pero teniendo en cuenta los números ganadores solamente:


-- 6- Realice un "left join" pero en esta ocasión busque los números ganadores de la tabla "premios" en la tabla "numerosrifa":


-- 7- Realice el mismo "join" anterior pero sin considerar los valores de "premios" que no encuentren coincidencia en "numerosrifa".


