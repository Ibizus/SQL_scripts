/* Realizar un Trigger de forma que cada vez que se inserte en la base de datos una
nota suspensa, se creará en la tabla de alumnos a recuperar la información del alumno y 
el mçodulo que debe recuperar*/
DROP DATABASE IF EXISTS alumnos;
CREATE DATABASE alumnos;
USE alumnos;

CREATE TABLE alumnos (
    id_alumno PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL
);

CREATE TABLE notas (
    id_alumno,
    id_modulo,
    nota FLOAT,
    foreing key (id_alumno, id_modulo)
);

CREATE TABLE alumnos_a_recuperar (
    id_alumno INT UNSIGNED,
    id_modulo,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL
);

DROP TRIGGER IF EXISTS pendientes_recuperar;
DELIMITER //
CREATE TRIGGER pendientes_recuperar
AFTER INSERT
ON notas FOR EACH ROW
BEGIN
	IF NEW.nota


INSERT INTO alumnos VALUES (1, 'Pepe', 'López');
INSERT INTO alumnos VALUES (2, 'María', 'Sánchez');
INSERT INTO alumnos VALUES (3, 'Juan', 'Pérez');
INSERT INTO alumnos VALUES (4, 'Lola', 'Ruiz');

INSERT INTO notas VALUES (1,1,4);
INSERT INTO notas VALUES (1,2,6);
INSERT INTO notas VALUES (2,3,4.5);
INSERT INTO notas VALUES (3,1,9);
INSERT INTO notas VALUES (4,5,2);

