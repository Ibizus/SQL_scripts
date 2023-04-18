/*Realiza un cursor que recorra los libros, incrementará un campo llamado 
cantidad_libros en su editorial correspondiente*/
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
create table editoriales(
  codigo int,
  nombre varchar(20),
  cantidad_libros int,
  primary key(codigo)
 );
 
 insert into editoriales values(1, 'Emece', 0);
 insert into editoriales values(2, 'Planeta', 0);
 insert into editoriales values(3, 'Paidos', 0);
 insert into libros values (1,'El aleph',1,23.5);
 insert into libros values (2,'Alicia en el pais de las maravillas',2,15);
 insert into libros values (3,'Matematica estas ahi',1,34.6);
 insert into libros values (4,'Martin Fierro',3,43.5);
 insert into libros values (5,'Martin Fierro',2,12);
 insert into libros values (6,'Aprenda PHP',3,21.8);
 insert into libros values (7,'Aprenda Java',3,55.4);
 insert into libros values (8,'Alicia a traves del espejo',1,18);
 insert into libros values (9,'Antologia poetica',3,47.9);

select * from editoriales;

DELIMITER //
DROP PROCEDURE IF EXISTS actualiza_cantidades //
CREATE PROCEDURE actualiza_cantidades()
BEGIN
  
  DECLARE var_codigoeditorial INTEGER;
  DECLARE var_final INTEGER;
  DECLARE cursor_libros CURSOR FOR
  select libros.codigoeditorial from libros;  
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_final = 1;
  OPEN cursor_libros;
  bucle: LOOP
    FETCH cursor_libros INTO var_codigoeditorial;
    IF var_final = 1 THEN
      LEAVE bucle;
    END IF;
    
    UPDATE editoriales SET cantidad_libros= cantidad_libros+1 WHERE editoriales.codigo = var_codigoeditorial;
    
  END LOOP bucle;
  CLOSE cursor_libros;
END//
DELIMITER ;
call actualiza_cantidades();
select * from editoriales;

