/*
EJERCICIO CURSORES:

tenemos una tabla departamentos: (codigo, nombre, descuento)
1. deportes, 0.20
2. alimentacion, 0.10

tabla articulos (codigo, nombre, precio, departamento(codigo))

Recorrer tabla articulos actualizando precios con su descuento

*/

drop database if exists tienda;
create database tienda;
use tienda;

 create table departamentos(
  codigo int,
  nombre varchar(20),
  descuento decimal(5,2),
  primary key (codigo)
 );
  create table articulos(
  codigo int,
  nombre varchar(40),
  precio decimal(5,2),
  cod_dep int,
  primary key (codigo)
 );

insert into departamentos values(1, 'Deportes', 0.20);
insert into departamentos values(2, 'Alimentación', 0.10);
insert into departamentos values(3, 'Electŕonica', 0.00);
insert into departamentos values(4, 'Hogar', 0.50);
insert into departamentos values(5, 'Perfumería', 0.30);

insert into articulos values(1, 'ColaCao', 4.75, 2);
insert into articulos values(2, 'Leche', 1.20, 2);
insert into articulos values(3, 'Cerveza x12', 6.10, 2);
insert into articulos values(4, 'Bicicleta', 249.99, 1);
insert into articulos values(5, 'Patines', 60, 1);
insert into articulos values(6, 'Ordenador', 789.99, 3);
insert into articulos values(7, 'Tablet 10"', 150, 3);
insert into articulos values(8, 'Pen Drive 256GB', 25, 3);
insert into articulos values(9, 'Juego Sabanas', 30, 4);
insert into articulos values(10, 'Toallas Baño', 24, 4);
insert into articulos values(11, 'Mantel Cocina', 14, 4);
insert into articulos values(12, 'Colonia Hombre', 73, 5);
insert into articulos values(13, 'Colonia Mujer', 67, 5);
insert into articulos values(1, 'Maquillaje', 45, 5);
insert into articulos values(1, 'Olla Esprés', 85, 4);

select 'TABLAS ORIGINALES:';
select * from departamentos;
select * from articulos;

/* Realizar mediante un cursor un procedimiento que se recorra todos los artículos de su tabla y para cada 
actualice los precios segun el descuento establecido para su departamento. */

-- Código a completar para hacer el ejercicio:

DELIMITER //
DROP PROCEDURE IF EXISTS aplica_descuentos//
CREATE PROCEDURE aplica_descuentos()
BEGIN

-- DECLARE... 

  DECLARE var_final INTEGER;
  DECLARE cursor_precios CURSOR FOR 
  SELECT /*l.codigo, l.titulo, l.codigoeditorial, l.precio*/
  FROM libros as l join editoriales as e on e.codigo = l.codigoeditorial where e.nombre = 'Paidos'; ??????????????????????
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_final = 1;
  
  OPEN cursor_precios;
  bucle: LOOP
    FETCH cursor_precios INTO var_codigo, var_titulo, var_editorial, var_precio; ?????
    IF var_final = 1 THEN
      LEAVE bucle;
    END IF;
    
    	-- /* INSERT into libros_paidos values (var_codigo, var_titulo, var_editorial, var_precio); */

  END LOOP bucle;
  CLOSE cursor_precios;
END//
DELIMITER ;

call aplica_descuentos();

select * from articulos;





