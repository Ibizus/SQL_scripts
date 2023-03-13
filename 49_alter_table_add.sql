drop database if exists prueba;
create database prueba;
use prueba;

drop table if exists peliculas;

create table peliculas(
	codigo int unsigned auto_increment,
  	nombre varchar(30) not null,
	actor varchar(20),
  	primary key(codigo)
 );
 
 insert into peliculas values(1,'el rey leon','simba');
 insert into peliculas values(2,'la cenicienta','calabaza');
 insert into peliculas values(3,'shrek','asno');
 insert into peliculas values(4,'el señor de los anillos','frodo');
 insert into peliculas(nombre,actor) values ('peterpan','campanilla');
 insert into peliculas(nombre,actor) values('doraemon','nobita');
 insert into peliculas(nombre,actor) values('a todo gas','toretto');
 
 
 alter table peliculas add duracion tinyint unsigned;
 
 describe peliculas;
 
 alter table peliculas add director varchar(20);
 
 describe peliculas;
 
 alter table peliculas add actor varchar(20);
 
 
 
 
 
