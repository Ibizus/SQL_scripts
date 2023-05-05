/* Realizar un cursor que recorra todos los saltos realizados durante el día de hoy, y si en algún salto válido
el deportista supera su mejor marca personal, la actualizará con el nuevo valor y con la fecha de hoy*/ 
/* El cursor estará definido de forma que sólo tendrá en cuenta los saltos válidos (campo valido = true)*/
/* Esa nota daría hasta 7,5 puntos*/
/* Para conseguir hasta 2,5 puntos extra, realizar el mismo ejercicio pero mediante un cursor 
que se recorra la tabla de deportistas y acceda para cada deportista al valor máximo de sus saltos para 
ver si le actualiza su mejor marca personal y el día en que la ha conseguido (hoy). */
 
DROP DATABASE IF EXISTS tokio_2020;
CREATE DATABASE tokio_2020;
USE tokio_2020;

CREATE TABLE deportistas_saltos (
    id_deportista int primary key,
    nombre varchar(30),
	pais varchar(3),
	mejor_marca_personal decimal(3,2),
	fecha_mejor_marca date
);
CREATE TABLE saltos (
    id_deportista int,
    id_salto int,
    marca decimal(3,2),
	valido boolean,
    primary key (id_deportista, id_salto) 
);

INSERT INTO deportistas_saltos VALUES (1, 'Mondo Duplantis', 'SUE', 6.22, '2019/02/14');
INSERT INTO deportistas_saltos VALUES (2, 'Thiago Braz', 'BRA', 6.03, '2018/07/01');
INSERT INTO deportistas_saltos VALUES (3, 'Igor Potapovich', 'KAZ', 5.99, '2017/03/11');
INSERT INTO deportistas_saltos VALUES (4, 'Brad Walker', 'USA', 6.12, '2016/12/15');

INSERT INTO saltos VALUES (1,1, 6.01, true);
INSERT INTO saltos VALUES (1,2, 6.24, true);
INSERT INTO saltos VALUES (1,3, 5.98, true);
INSERT INTO saltos VALUES (2,1, 5.99, true);
INSERT INTO saltos VALUES (2,2, 6.04, false);
INSERT INTO saltos VALUES (2,3, 5.94, true);
INSERT INTO saltos VALUES (3,1, 6.02, true);
INSERT INTO saltos VALUES (3,2, 6.04, false);
INSERT INTO saltos VALUES (3,3, 6.00, true);
INSERT INTO saltos VALUES (4,1, 6.19, false);
INSERT INTO saltos VALUES (4,2, 6.17, true);
INSERT INTO saltos VALUES (4,3, 6.01, true);
select * from saltos;


/* PRIMERA PARTE */
/*
select*from deportistas_saltos;

DELIMITER //
DROP PROCEDURE IF EXISTS actualiza_salto //
CREATE PROCEDURE actualiza_salto()
BEGIN

	DECLARE var_final integer;
	DECLARE var_id integer;
	DECLARE var_marca decimal(3,2);
	DECLARE var_valido bool;
	
	DECLARE cursor_salto CURSOR FOR 
		select id_deportista, marca, valido from saltos;
		
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_final=1;
	OPEN cursor_salto;
	bucle: LOOP
		
		FETCH cursor_salto into var_id, var_marca, var_valido;
		
	IF var_final = 1 THEN
      	LEAVE bucle;
    	END IF;
    	
    		UPDATE deportistas_saltos SET mejor_marca_personal = var_marca, fecha_mejor_marca = CURRENT_date 
    		WHERE id_deportista = var_id AND var_marca > mejor_marca_personal AND var_valido = true;
    
  END LOOP bucle;
  CLOSE cursor_salto;
END//
DELIMITER ;

call actualiza_salto();

select*from deportistas_saltos;	
*/	
    	
    	
 
/* SEGUNDA PARTE */
select*from deportistas_saltos;

DELIMITER //
DROP PROCEDURE IF EXISTS actualiza_mejor_marca //
CREATE PROCEDURE actualiza_mejor_marca()
BEGIN

	DECLARE var_final integer;
	DECLARE var_id integer;
	DECLARE var_marca_personal decimal(3,2);
	DECLARE var_mejor_salto decimal(3,2);
	DECLARE var_valido bool;
	
	DECLARE cursor_marca CURSOR FOR
		select id_deportista, mejor_marca_personal from deportistas_saltos;
		
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_final=1;
	OPEN cursor_marca;
	bucle: LOOP
		
		FETCH cursor_marca into var_id, var_marca_personal;
			
	IF var_final = 1 THEN
      	LEAVE bucle;
    	END IF;
	
	SELECT max(marca) INTO var_mejor_salto FROM saltos WHERE id_deportista = var_id AND valido = true;
		
	UPDATE deportistas_saltos SET mejor_marca_personal = var_mejor_salto, fecha_mejor_marca = CURRENT_date 
	WHERE id_deportista = var_id AND var_mejor_salto > var_marca_personal;
	
   END LOOP bucle;
   CLOSE cursor_marca;
END //
DELIMITER ;

call actualiza_mejor_marca();
select*from deportistas_saltos;

