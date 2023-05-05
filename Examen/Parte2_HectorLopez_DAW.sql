/* Objetivo:
Llevar a cabo la misma acción final que se pretendía en la parte 1 del examen,
es decir, que finalmente en cada registro de la tabla "deportistas_saltos"
termine apareciendo como la mejor marca personal del deportista la que tenga
una vez comparados los distintos saltos del día (los válidos) con su mejor marca,
pero esta vez se hará MEDIANTE LA PROGRAMACIÓN DEL CORRESPONDIENTE TRIGGER,
de tal forma que cada vez que se lleve a cabo un INSERT en la tabla "saltos" se disparará dicho trigger, que podrá actualizar (o no) la mejor "marca personal.
Igualmente, en caso de que se mejore la marca con algún salto de hoy, 
aparecerá la fecha de hoy como la fecha de la mejor marca.*/ 

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

/* Se crea el trigger despues de la tabla y antes de los insert que disparan su ejecución */

DROP TRIGGER IF EXISTS mejor_marca;
DELIMITER //
CREATE TRIGGER mejor_marca
BEFORE INSERT
ON saltos FOR EACH ROW
BEGIN

	UPDATE deportistas_saltos SET mejor_marca_personal = NEW.marca, fecha_mejor_marca = CURRENT_date 
	WHERE id_deportista = NEW.id_deportista AND NEW.marca > mejor_marca_personal AND NEW.valido = true;

END //
DELIMITER ;


INSERT INTO deportistas_saltos VALUES (1, 'Mondo Duplantis', 'SUE', 6.22, '2019/02/14');
INSERT INTO deportistas_saltos VALUES (2, 'Thiago Braz', 'BRA', 6.03, '2018/07/01');
INSERT INTO deportistas_saltos VALUES (3, 'Igor Potapovich', 'KAZ', 5.99, '2017/03/11');
INSERT INTO deportistas_saltos VALUES (4, 'Brad Walker', 'USA', 6.12, '2016/12/15');

/* Traza estado inicial */
select * from deportistas_saltos;

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

/* Traza resultado trigger */
select * from deportistas_saltos;
