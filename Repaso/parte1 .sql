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



DELIMITER //
CREATE PROCEDURE actualizar_mejor_marca()
BEGIN
    DECLARE id_deportista INT;
    DECLARE mejor_marca DECIMAL(3,2);
    
/* Cursor que recorra los deportistas y para cada uno acceda al valor máximo de sus saltos para ver si le actualiza su mejor marca personal */
    
    DECLARE curDeportistas CURSOR FOR
    SELECT id_deportista
    FROM deportistas_saltos;
    
    OPEN curDeportistas;
    FETCH NEXT FROM curDeportistas INTO id_deportista;
    
/* Recorremos la tabla de deportistas y accedemos para cada deportista al valor máximo de sus saltos */
    
    WHILE id_deportista IS NOT NULL DO
        SELECT MAX(marca) INTO mejor_marca
        FROM saltos
        WHERE id_deportista = curDeportistas.id_deportista;
        
/* Si el valor máximo es mayor que la mejor marca personal, actualizamos la mejor marca personal */
        
        IF mejor_marca > curDeportistas.mejor_salto THEN
            UPDATE deportistas_saltos SET mejor_salto = mejor_marca WHERE id_deportista = curDeportistas.id_deportista;
        END IF;
        
        FETCH NEXT FROM curDeportistas INTO id_deportista;
    END WHILE;
    
    CLOSE curDeportistas;
    
/* Cursor que recorra los saltos y si alguno es mayor que su mejor marca, la actualizará */
    
    DECLARE curSaltos CURSOR FOR
    SELECT id_deportista, marca FROM saltos WHERE id_deportista IN (SELECT id_deportista FROM deportistas_saltos);
    
    DECLARE done INT DEFAULT FALSE;
    
/* Recorremos la tabla de saltos y comparamos con la mejor marca personal de cada deportista */
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN curSaltos;
    
    WHILE NOT done DO
        FETCH NEXT FROM curSaltos INTO id_deportista, mejor_marca;
        
/* Obtenemos la mejor marca personal del deportista */
        
        SELECT mejor_salto INTO @mejor_salto
        FROM deportistas_saltos
        WHERE id_deportista = curSaltos.id_deportista;
        
/* Si la marca del salto es mayor que la mejor marca personal del deportista, actualizamos la mejor marca personal */
        
        IF mejor_marca > @mejor_salto THEN
            CALL actualizar_mejor_marca_deportista(id_deportista, mejor_marca);
        END IF;
    END WHILE;
    
    CLOSE curSaltos;
END//
DELIMITER ;

SELECT * FROM deportistas_saltos;
SELECT * FROM saltos;

