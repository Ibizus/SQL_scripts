/* Objetivo:
Llevar a cabo la misma acción final que se pretendía en la parte 1 del examen, es decir, 
que finalmente en cada registro de la tabla "deportistas_saltos" termine apareciendo como 
mejor marca personal la que tenga una vez realizados los distintos saltos que se indican
mediante las inserciones en la tabla de saltos, pero esta vez se hará
MEDIANTE LA PROGRAMACIÓN DEL TRIGGER CORRESPONDIENTE, de tal forma que cada vez que
se lleve a cabo un INSERT en la tabla "saltos" se disparará el trigger, que podrá actualizar
(o no) la mejor "marca personal del saltador" obtenida hasta el momento */ 

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



DELIMITER //

CREATE TRIGGER actualizar_mejor_marca_personal AFTER INSERT ON saltos
FOR EACH ROW
BEGIN
    DECLARE mejor_marca DECIMAL(3,2);
    
/* Buscamos la mejor marca personal actual del deportista asociado al nuevo salto */
    
    SELECT MAX(marca) INTO mejor_marca
    FROM saltos
    WHERE id_deportista = NEW.id_deportista;
    
/* Si el valor máximo es mayor que la mejor marca personal, actualizamos la tabla "deportistas_saltos" */
    
    IF mejor_marca > (SELECT mejor_marca_personal FROM deportistas_saltos WHERE id_deportista = NEW.id_deportista) THEN
        UPDATE deportistas_saltos SET mejor_marca_personal = mejor_marca WHERE id_deportista = NEW.id_deportista;
    END IF;
END //

DELIMITER ;

SELECT * FROM deportistas_saltos;
SELECT * FROM saltos;
