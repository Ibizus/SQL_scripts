/* Realizar un cursor quye se recorra todos los alumnos e inserte en la 
tabla de medias, la nota media*/

DROP DATABASE IF EXISTS alumnos;
CREATE DATABASE alumnos;
USE alumnos;

CREATE TABLE alumnos (
    id_alumno int PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL
);

CREATE TABLE notas (
    id_alumno int,
    id_modulo int,
    nota decimal(4,2),
    primary key (id_alumno, id_modulo) 
);

CREATE TABLE notas_medias (
    id_alumno int primary key,
    nota decimal(4,2)
);

INSERT INTO alumnos VALUES (1, 'Pepe', 'López');
INSERT INTO alumnos VALUES (2, 'María', 'Sánchez');
INSERT INTO alumnos VALUES (3, 'Juan', 'Pérez');
INSERT INTO alumnos VALUES (4, 'Lola', 'Ruiz');

INSERT INTO notas VALUES (1,2,6);
INSERT INTO notas VALUES (1,3,4);
INSERT INTO notas VALUES (2,3,4.5);
INSERT INTO notas VALUES (3,1,9);
INSERT INTO notas VALUES (4,5,2);

DELIMITER //
DROP PROCEDURE IF EXISTS crea_medias;
CREATE PROCEDURE crea_medias()
BEGIN
	DECLARE var_final bool;
	DECLARE var_id_alumno integer;
	DECLARE var_media_alumno decimal(4,2);
		
	DECLARE cursor_crea_medias CURSOR FOR
	
	SELECT id_alumno from alumnos;
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_final = false;
	
	OPEN cursor_crea_medias;
	bucle: LOOP
		
		FETCH cursor_crea_medias INTO var_id_alumno;
		
		IF var_final = false THEN
			LEAVE bucle;
		END IF;
		
		SELECT round(avg(nota),2) into var_media_alumno FROM notas WHERE id_alumno = var_id_alumno;
		INSERT into notas_medias values (var_id_alumno, var_media_alumno);

	END LOOP bucle;
	CLOSE cursor_crea_medias;
	END//
DELIMITER ;

CALL crea_medias();

select*from notas;
select*from notas_medias;

