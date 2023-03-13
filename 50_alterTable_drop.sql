drop database if exists prueba;
create database prueba;
use prueba;

drop table if exists peliculas;

 create table peliculas(
  codigo int unsigned auto_increment,
  nombre varchar(30) not null,
  protagonista varchar(20),
  actorsecundario varchar(20),
  director varchar(25),
  duracion tinyint unsigned,
  primary key(codigo),
  index i_director (director)
 );
 
  insert into peliculas values(1,'el rey leon','simba','act2','dire1',112);
 insert into peliculas values(2,'la cenicienta','calabaza','act6','dire4',98);
 insert into peliculas values(3,'shrek','asno','act5','dire2',134);
 insert into peliculas values(4,'el señor de los anillos','frodo','act2','dire1',120);
 insert into peliculas(nombre,protagonista,actorsecundario,director,duracion) values ('peterpan','campanilla','act5','dire4',87);
 insert into peliculas(nombre,protagonista,actorsecundario,director,duracion) values('doraemon','nobita','act2','dire1',108);
 insert into peliculas(nombre,protagonista,actorsecundario,director,duracion) values('a todo gas','toretto','act6','dire3',167);
 
 
 show index from peliculas;
 
 alter table peliculas drop director;
 
 describe peliculas;
 
 show index from peliculas;
 
 alter table peliculas drop director;
 
 select*from peliculas;
  
 alter table peliculas drop actorsecundario, drop duracion;
 
 select*from peliculas;
 
  
