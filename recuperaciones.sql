/* Asociar a la tabla recuperaciones un trigger para que una vez que se 
haya insertado una nota de recuperación, actualice la nota del alumno en la
tabla de notas siempre y cuando la nota de recuperación sea mayor a la nota inicial en el modulo */

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

CREATE TABLE notas_recuperaciones (
    id_alumno int,
    id_modulo int,
    nota_recuperacion decimal(4,2),
    primary key (id_alumno, id_modulo) 
);

DROP TRIGGER IF EXISTS recuperaciones;
DELIMITER //
CREATE TRIGGER recuperaciones
AFTER INSERT
ON notas_recuperaciones FOR EACH ROW
BEGIN
DECLARE var_nota decimal(4,2);
  select nota into var_nota from notas where id_alumno = new.id_alumno and id_modulo = new.id_modulo;
  
  IF new.nota_recuperacion >= var_nota THEN
	update notas set nota = new.nota_recuperacion where id_alumno = NEW.id_alumno and id_modulo = NEW.id_modulo;
    END IF;
END //
DELIMITER ;


INSERT INTO alumnos VALUES (1, 'Pepe', 'López');
INSERT INTO alumnos VALUES (2, 'María', 'Sánchez');
INSERT INTO alumnos VALUES (3, 'Juan', 'Pérez');
INSERT INTO alumnos VALUES (4, 'Lola', 'Ruiz');

INSERT INTO notas VALUES (1,1,4);
INSERT INTO notas VALUES (1,2,6);
INSERT INTO notas VALUES (1,3,4);
INSERT INTO notas VALUES (2,3,4.5);
INSERT INTO notas VALUES (3,1,9);
INSERT INTO notas VALUES (3,2,10);
INSERT INTO notas VALUES (4,5,2);

INSERT INTO notas_recuperaciones VALUES (1,1,6);
INSERT INTO notas_recuperaciones VALUES (1,3,3);
INSERT INTO notas_recuperaciones VALUES (2,3,8);
INSERT INTO notas_recuperaciones VALUES (4,5,1);

-- NOTAS(1,1,6);
-- NOTAS(1,3,4);
-- NOTAS(2,3,8);
-- NOTAS(4,5,2);

select * from notas; 
select * from notas_recuperaciones;

