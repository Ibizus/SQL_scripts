drop database if exists libreria;
create database libreria;
use libreria;
 create table libros(
  codigo int,
  titulo varchar(40),
  codigoeditorial int,
  precio decimal(5,2),
  primary key (codigo)
 );
 
  create table libros_paidos(
  codigo int,
  titulo varchar(40),
  codigoeditorial int,
  precio decimal(5,2),
  primary key (codigo)
 );

 create table editoriales(
  codigo int,
  nombre varchar(20),
  primary key(codigo)
 );

 insert into editoriales values(1, 'Emece');
 insert into editoriales values(2, 'Planeta');
 insert into editoriales values(3, 'Paidos');
 insert into libros values (1,'El aleph',1,23.5);
 insert into libros values (2,'Alicia en el pais de las maravillas',2,15);
 insert into libros values (3,'Matematica estas ahi',1,34.6);
 insert into libros values (4,'Martin Fierro',3,43.5);
 insert into libros values (5,'Martin Fierro',2,12);
 insert into libros values (6,'Aprenda PHP',3,21.8);
 insert into libros values (7,'Aprenda Java',3,55.4);
 insert into libros values (8,'Alicia a traves del espejo',1,18);
 insert into libros values (9,'Antologia poetica',3,47.9);

/* Realizar mediante un cursor un procedimiento que se recorra todos los libros de su tabla y para cada 
libro de la editorial 'Paidos' hará una copia de dicho registro sobre una nueva tabla llamada  'libros_de_paidos'. */

-- Código a completar para hacer el ejercicio:

DELIMITER //
DROP PROCEDURE IF EXISTS crea_libros_paidos//
CREATE PROCEDURE crea_libros_paidos()
BEGIN

-- DECLARE... 
  DECLARE var_codigo INTEGER;
  DECLARE var_titulo varchar(40);
  DECLARE var_editorial INTEGER;
  DECLARE var_precio decimal(5,2);
  DECLARE var_final INTEGER;
  DECLARE cursor_libros CURSOR FOR 
  SELECT l.codigo, l.titulo, l.codigoeditorial, l.precio
  FROM libros as l join editoriales as e on e.codigo = l.codigoeditorial where e.nombre = 'Paidos';
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_final = 1;
  
  OPEN cursor_libros;
  bucle: LOOP
    FETCH cursor_libros INTO var_codigo, var_titulo, var_editorial, var_precio;
    IF var_final = 1 THEN
      LEAVE bucle;
    END IF;
    
    	INSERT into libros_paidos values (var_codigo, var_titulo, var_editorial, var_precio);

  END LOOP bucle;
  CLOSE cursor_libros;
END//
DELIMITER ;
call crea_libros_paidos();
select * from libros_paidos;


