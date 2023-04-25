/*Realiza un cursor que recorra las editoriales, y para cada editorial
que tenga activado el flag de borrado de sus libros, se borrarán dichos
libros.
De forma automática, cada vez que se borre un libro de la tabla de libros, se almacenará justamente antes
de su borrado, en la tabla de libros_borrados, con toda su información más un campo de tipo fecha_hora 
que indicará el momento exacto del borrado*/

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
create table log_libros_borrados(
  codigo int,
  titulo varchar(40),
  codigoeditorial int,
  precio decimal(5,2),
  fecha_borrado date,
  primary key (codigo)
 );

create table editoriales(
  codigo int,
  nombre varchar(20),
  flag_borrar bool,
  primary key(codigo)
 );
 
 insert into editoriales values(1, 'Emece', false);
 insert into editoriales values(2, 'Planeta', true);
 insert into editoriales values(3, 'Paidos', false);
 insert into libros values (1,'El aleph',1,23.5);
 insert into libros values (2,'Alicia en el pais de las maravillas',2,15);
 insert into libros values (3,'Matematica estas ahi',1,34.6);
 insert into libros values (4,'Martin Fierro',3,43.5);
 insert into libros values (5,'Martin Fierro',2,12);
 insert into libros values (6,'Aprenda PHP',3,21.8);
 insert into libros values (7,'Aprenda Java',3,55.4);
 insert into libros values (8,'Alicia a traves del espejo',1,18);
 insert into libros values (9,'Antologia poetica',3,47.9);


/*Reutiliza en la medida de lo posible la estructura de cursor siguiente*/
select * from libros;
DELIMITER //
DROP PROCEDURE IF EXISTS borrado_libros //
CREATE PROCEDURE borrado_libros()

BEGIN
  DECLARE var_final int;
  DECLARE var_codigo int;
  DECLARE var_flag bool;
  
  DECLARE cursor_borrado_libros CURSOR FOR
  SELECT codigo, flag_borrar FROM editoriales;
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_final = 1;

  OPEN cursor_borrado_libros;
  bucle: LOOP
    FETCH cursor_borrado_libros INTO var_codigo, var_flag;
    IF var_final = 1 THEN
      LEAVE bucle;
    END IF;
    
    -- /* UNA FORMA DE HACERLO: */
    If var_flag = true THEN
    	DELETE from libros WHERE var_codigo = codigoeditorial;
    END IF;
    
    -- /* otra:  DELETE from libros WHERE var_codigo = codigoeditorial and var_flag = true;*/
    
  END LOOP bucle;
  CLOSE cursor_borrado_libros;
END//
DELIMITER ;

/* AQUÍ TENGO QUE CREAR EL TRIGGER PARA QUE SALTE ANTES DE LLAMAR AL CURSOR: */

DROP TRIGGER IF EXISTS log_borrados;
DELIMITER //
CREATE TRIGGER log_borrados
BEFORE DELETE
ON libros FOR EACH ROW
BEGIN
  insert into log_libros_borrados values (OLD.codigo, OLD.titulo, OLD.codigoeditorial, OLD.precio, CURRENT_DATE);
  
END //
DELIMITER ;


call borrado_libros();

select * from libros;
select * from log_libros_borrados;
