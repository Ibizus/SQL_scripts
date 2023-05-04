/* Cursor que recorra los saltos y si alguno es mayor que su mejor marca, la actualizará*/ 
/* Esa nota daría hasta 8 puntos*/
/* Para conseguir hasta 2 puntos extra, realizar el mismo ejercicio pero mediante un cursor 
que se recorra la tabla de deportistas y acceda para cada deportista al valor máximo de sus saltos para 
ver si le actualiza su mejor marca personal. */
 
DROP DATABASE IF EXISTS tokio_2020;
CREATE DATABASE tokio_2020;
USE tokio_2020;

CREATE TABLE deportistas_saltos (
    id_deportista int primary key,
    nombre varchar(30),
	pais varchar(3),
	mejor_marca_personal decimal(3,2)
);
CREATE TABLE saltos (
    id_deportista int,
    id_salto int,
    marca decimal(3,2),
    primary key (id_deportista, id_salto) 
);

INSERT INTO deportistas_saltos VALUES (1, 'Mondo Duplantis', 'SUE', 6.22);
INSERT INTO deportistas_saltos VALUES (2, 'Thiago Braz', 'BRA', 6.03);
INSERT INTO deportistas_saltos VALUES (3, 'Igor Potapovich', 'KAZ', 5.99);
INSERT INTO deportistas_saltos VALUES (4, 'Brad Walker', 'USA', 6.12);

INSERT INTO saltos VALUES (1,1, 6.01);
INSERT INTO saltos VALUES (1,2, 6.24);
INSERT INTO saltos VALUES (1,3, 5.98);
INSERT INTO saltos VALUES (2,1, 5.99);
INSERT INTO saltos VALUES (2,2, 5.97);
INSERT INTO saltos VALUES (2,3, 5.94);
INSERT INTO saltos VALUES (3,1, 6.02);
INSERT INTO saltos VALUES (3,2, 6.04);
INSERT INTO saltos VALUES (3,3, 6.00);
INSERT INTO saltos VALUES (4,1, 6.10);
INSERT INTO saltos VALUES (4,2, 6.17);
INSERT INTO saltos VALUES (4,3, 6.01);


select*from deportistas_saltos;
select*from saltos;

DELIMITER //
DROP PROCEDURE IF EXISTS actualiza_mejor_marca //
CREATE PROCEDURE actualiza_mejor_marca()
BEGIN

	DECLARE var_final integer;
	DECLARE var_id integer;
	DECLARE var_marca_personal decimal(3,2);
	DECLARE var_mejor_salto decimal(3,2);
	
	DECLARE cursor_marca CURSOR FOR
		select id_deportista, mejor_marca_personal from deportistas_saltos;
		
	DECLARE cursor_saltos CURSOR FOR
		select marca from saltos where id_deportista=var_id;
		
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_final=1;
	OPEN cursor_marca;
	bucle: LOOP
		
		FETCH cursor_marca into var_id, var_marca_personal;
		
	IF var_final = 1 THEN
      	LEAVE bucle;
    	END IF;
	

	OPEN cursor_saltos;
	bucle_saltos: LOOP
		FETCH cursor_saltos into var_mejor_salto;
	IF var_final = 1 THEN
      	LEAVE bucle_saltos;
    	END IF;
		
	IF var_mejor_salto > var_marca_personal THEN
	UPDATE deportistas_saltos SET mejor_marca_personal = var_mejor_salto 
	where id_deportista = var_id;
	
	SET var_marca_personal = var_mejor_salto;
	END IF;
	
	
	END LOOP bucle_saltos;
        set var_final = 0;
        CLOSE cursor_saltos;
    	END LOOP bucle;
    	CLOSE cursor_marca;
END //
DELIMITER ;

	
call actualiza_mejor_marca();
select*from deportistas_saltos;


