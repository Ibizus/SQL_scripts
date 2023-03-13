drop database if exists prueba;
create database prueba;
use prueba;

drop table if exists peliculas;

 create table peliculas(
  codigo int unsigned,
  nombre varchar(20) not null,
  actor varchar(20),
  director varchar(25),
  duracion tinyint
 );
 
 alter table peliculas modify duracion tinyint unsigned;
 
 alter table peliculas modify nombre varchar(40) not null;
 
 alter table peliculas modify actor varchar(20) not null;
 
 select 'No permite añadirlo auto_increment porque no es primary key';
 alter table peliculas modify codigo int unsigned auto_increment;
 
 describe peliculas;
 
 select 'Tengo que borrarlo y volver a añadir ya como auto_increment y primary key';
 alter table peliculas drop codigo;
 
 alter table peliculas add codigo int unsigned auto_increment primary key;
 
 describe peliculas;
 
 
