drop database if exists pruebas;
create database pruebas;
use pruebas;

create table log_precios(
  fecha date,
  p_anterior decimal(5,2),
  p_posterior decimal(5,2),
  responsable varchar(30)
);

create table libros(
  codigo integer primary key,
  titulo varchar(50),
  autor varchar(30),
  precio decimal(5,2)
 );

insert into libros (codigo, titulo, autor, precio) values (1,'El aleph','Borges',23.5);
 insert into libros (codigo, titulo, autor, precio) values (2,'Alicia en el pais de las maravillas','Lewis Carroll',15);
 

drop trigger if exists before_precio_update;

-- Creamos el trigger 'before_precio_update':

delimiter //
create trigger before_precio_update
  before update
  on libros
  for each row
begin
  insert into log_precios(fecha,p_anterior, p_posterior) values (current_date, old.precio, new.precio); 
end //
delimiter ;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
