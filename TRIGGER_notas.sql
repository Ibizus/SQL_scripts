/* Realizar un Trigger de forma que cada vez que se inserte en la base de datos una
nota suspensa, se creará en la tabla de alumnos a recuperar la información del alumno y 
el modulo que debe recuperar*/
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
    nota FLOAT,
    primary key (id_alumno, id_modulo)
);

CREATE TABLE alumnos_a_recuperar (
    id_alumno INT UNSIGNED,
    id_modulo int,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL
);

DROP TRIGGER IF EXISTS pendientes_recuperar;
DELIMITER //
CREATE TRIGGER pendientes_recuperar

AFTER INSERT
ON notas FOR EACH ROW
BEGIN
DECLARE var_nombre varchar(50);
DECLARE var_apellido1 varchar(50);
  IF new.nota < 5 THEN
    select nombre, apellido1 into var_nombre, var_apellido1 from alumnos as a where a.id_alumno = NEW.id_alumno;
    INSERT INTO alumnos_a_recuperar values (new.id_alumno, new.id_modulo, var_nombre, var_apellido1);
  END IF;
END //
DELIMITER ;

INSERT INTO alumnos VALUES (1, 'Pepe', 'López');
INSERT INTO alumnos VALUES (2, 'María', 'Sánchez');
INSERT INTO alumnos VALUES (3, 'Juan', 'Pérez');
INSERT INTO alumnos VALUES (4, 'Lola', 'Ruiz');

INSERT INTO notas VALUES (1,1,4);
INSERT INTO notas VALUES (1,2,6);
INSERT INTO notas VALUES (2,3,4.5);
INSERT INTO notas VALUES (3,1,9);
INSERT INTO notas VALUES (4,5,2);


select*from alumnos;
select*from notas;
select*from alumnos_a_recuperar;


