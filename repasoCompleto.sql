-- show databases;
-- use prueba;
 
 drop table if exists libros;
 
 create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(50) not null,
  autor varchar(50),
  editorial varchar(25),
  primary key (codigo)
 );
 
-- describe libros;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
