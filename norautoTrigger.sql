/*
* 1. alter tabvle de cheques regalo para añadir un campo fecha
*
* 2. updateamos los cheques regalo con fechas al azar
*
* 3. generamos un trigger con un borrado de los cheques con antiguedad mayor a 6 meses,
* pero devolviendo los puntos a sus vehiculos.
*/

use norauto;

/* añadimos el campo */
alter table cheques_regalo add fecha_emision date;


/* creamos el trigger que devuelva los puntos antes de hacer el borrado */
DELIMITER //
CREATE TRIGGER actualizar_puntos
BEFORE DELETE
ON cheques_regalo FOR EACH ROW
BEGIN
	UPDATE vehiculos SET puntos = puntos + OLD.valor_cheque where id_matricula = OLD.id_matricula;
END //
DELIMITER //


/* Updateo las fechas aleatorias con algunas antiguas */

update cheques_regalo set fecha_emision = '2022/03/01' where id_cheque_regalo_100_puntos = 1;
update cheques_regalo set fecha_emision = '2023/03/11' where id_cheque_regalo_100_puntos = 2;
update cheques_regalo set fecha_emision = '2022/03/01' where id_cheque_regalo_100_puntos = 3;
update cheques_regalo set fecha_emision = '2023/03/10' where id_cheque_regalo_100_puntos = 4;

/* Lanzamos el borrado de los cheques antiguos: */

delete from cheques_regalo where current_date() - fecha_emision > 180;

/*TRAZA*/
select*from cheques_regalo;
select*from vehiculos;



