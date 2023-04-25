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
select * from editoriales;
DELIMITER //
DROP PROCEDURE IF EXISTS actualiza_cantidades //
CREATE PROCEDURE actualiza_cantidades()
BEGIN
  DECLARE... ;
  ...
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_final = 1;
  OPEN cursor_libros;
  bucle: LOOP
    FETCH ... INTO ....;
    IF var_final = 1 THEN
      LEAVE bucle;
    END IF;
    UPDATE ... SET ...  WHERE ...;
  END LOOP bucle;
  CLOSE cursor_libros;
END//
DELIMITER ;
call actualiza_cantidades();
select * from editoriales;
