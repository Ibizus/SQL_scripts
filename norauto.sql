/* Tenemos que hacer dos cursores, con uno nos recorreremos cada vehículo (cursor
externo) y para cada vehículo nos recorreremos cada una de sus visitas al taller
(cursor interno) para llevar a cabo la actualización de puntos de fidelización.*/
drop database if exists norauto;
create database norauto;
use norauto;
create table vehiculos (
	id_matricula char(7) primary key,
    marca varchar (10),
    modelo varchar (10),
    puntos int default 0);
    
create table visitas (
	id_matricula char(7),
    fecha_visita date,
    importe_factura decimal(7,2),
    primary key (id_matricula, fecha_visita));
    
create table cheques_regalo (
	id_cheque_regalo_100_puntos int auto_increment primary key,
	id_matricula char(7) not null,
	valor_cheque int);
    
insert into vehiculos (id_matricula, marca, modelo) values ('0978BLT', 'Seat', 'Ibiza Tdi');
insert into vehiculos (id_matricula, marca, modelo) values ('1234CFS', 'Ferrari', 'Testarazo');
insert into vehiculos (id_matricula, marca, modelo) values ('3342LRQ', 'Toyota', 'CHR 185');

insert into visitas values ('3342LRQ', '2021-04-02', 3280);
insert into visitas values ('0978BLT', '2022-09-12', 1220);
insert into visitas values ('1234CFS', '2022-11-05', 3480);
insert into visitas values ('1234CFS', '2022-11-06', 1600);

select * from vehiculos;
select * from visitas;


DELIMITER //
CREATE TRIGGER cheque_regalo
BEFORE UPDATE
ON vehiculos FOR EACH ROW
BEGIN  /*ERROR*/
	IF NEW.puntos >= 100 THEN
	INSERT into cheques_regalo (id_matricula, valor_cheque) values (new.id_matricula, truncate(new.puntos/100, 0)*100);
	SET new.puntos = new.puntos - truncate(new.puntos/100, 0)*100;
	END IF;
END //
DELIMITER //


DELIMITER //
DROP PROCEDURE IF EXISTS actualiza_puntos //
CREATE PROCEDURE actualiza_puntos()
BEGIN
    DECLARE done INT;
    DECLARE var_id_matricula CHAR(7);
    DECLARE var_id_matricula2 CHAR(7);
    DECLARE var_importe_factura DECIMAL(7,2);
    DECLARE cursor_vehiculos CURSOR FOR SELECT id_matricula FROM vehiculos;
    DECLARE cursor_visitas CURSOR FOR SELECT id_matricula, importe_factura FROM visitas where id_matricula = var_id_matricula; 
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    set done = false;
    OPEN cursor_vehiculos;
    bucle_vehiculos: LOOP
        FETCH cursor_vehiculos INTO var_id_matricula;
        IF done THEN
            LEAVE bucle_vehiculos;
        END IF;
        OPEN cursor_visitas;
		bucle_visitas: LOOP
             FETCH cursor_visitas INTO var_id_matricula2, var_importe_factura;
             IF done THEN
             LEAVE bucle_visitas;
             END IF;
             IF var_id_matricula2 = var_id_matricula THEN
                update vehiculos set puntos = puntos + truncate(var_importe_factura / 10, 0) where (id_matricula = var_id_matricula);
			 END IF;
        END LOOP bucle_visitas;
        set done = false;
        CLOSE cursor_visitas;
    END LOOP bucle_vehiculos;
    CLOSE cursor_vehiculos;
END //

DELIMITER ;

call actualiza_puntos();
select * from vehiculos;
select * from visitas;
select * from cheques_regalo;
