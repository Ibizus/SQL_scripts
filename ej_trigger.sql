DROP DATABASE IF EXISTS seneca;
CREATE DATABASE seneca;
USE seneca;

CREATE TABLE alumnos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    nota FLOAT
);

DROP TRIGGER IF EXISTS tcnbi;
DELIMITER //
CREATE TRIGGER tcnbi
BEFORE INSERT
ON alumnos FOR EACH ROW
BEGIN
  IF NEW.nota < 0 THEN
    set NEW.nota = 0;
  ELSEIF NEW.nota > 10 THEN
    set NEW.nota = 10;
  END IF;
END //
DELIMITER ;


DROP TRIGGER IF EXISTS tcnbu;
DELIMITER //
CREATE TRIGGER tcnbu
BEFORE UPDATE
ON alumnos FOR EACH ROW
BEGIN
  IF NEW.nota < 0 THEN
    set NEW.nota = 0;
  ELSEIF NEW.nota > 10 THEN
    set NEW.nota = 10;
  END IF;
END //
DELIMITER ;

INSERT INTO alumnos VALUES (1, 'Pepe', 'López', -1);
INSERT INTO alumnos VALUES (2, 'María', 'Sánchez', 11);
INSERT INTO alumnos VALUES (3, 'Juan', 'Pérez', 8.5);
SELECT * FROM alumnos;

UPDATE alumnos SET nota = -4 WHERE id = 3;
SELECT * FROM alumnos;

UPDATE alumnos SET nota = 14 WHERE id = 3;
SELECT * FROM alumnos;

UPDATE alumnos SET nota = 9.5 WHERE id = 3;
SELECT * FROM alumnos;



