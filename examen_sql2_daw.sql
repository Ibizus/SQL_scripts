/**** NO SE PUEDE ESCRIBIR NADA DENTRO DE ESTE BLOQUE DE GENERACIÓN DE LA BBDD ****/
/****************************** PRINCIPIO DEL BLOQUE  *****************************/

drop database if exists componentesmotor;
create database componentesmotor;
use componentesmotor;

create table motores (
id_motor int,
bastidor_asociado varchar (12),
denominacion varchar (20) not null,
tipo enum ('Eléctrico', 'Híbrido', 'Gasolina', 'Diésel') not null,
fecha_fabricacion datetime,
primary key (id_motor)
);

create table componentes (
id_componente int,
denominacion varchar (20) not null,
precio decimal (7,2) not null,
precio_rebajado decimal (7,2) not null,
material_usado varchar (30),
id_motor int not null,
primary key (id_componente)
);

insert into motores values (1, 'AX563300', 'motor_1', 'Gasolina', '2017-08-10');
insert into motores values (2, 'NY000567', 'motor_2', 'Eléctrico', '2022-11-23');
insert into motores values (3, 'JK051299', 'motor_3', 'Híbrido', '2023-02-01');
insert into componentes values (1, 'componente_1', 150.00, 145.90, 'Acero', 1);
insert into componentes values (2, 'componente_2', 39.00, 37.50, null, 1);
insert into componentes values (3, 'componente_3', 96.00, 89.25, null, 2);
insert into componentes values (4, 'componente_4', 49.00, 49.00, 'Plástico y alumninio', 2);
insert into componentes values (5, 'componente_5', 17.00, 14.50, null, 3);

/****************NO SE PUEDE ESCRIBIR POR ENCIMA DE ESTA LÍNEA ********************/
/****************************** FIN DEL BLOQUE  *****************************/
/*RÚBRICA DE CALIFICACIÓN*/
/*Ejercicio que se ejecuta correctamente sin ningún error del motor MySQL.......  => 1 punto   *******/
/*Ejercicio que no se ejecuta correctamente pero está bien planteado............  => 0.25/0.50 puntos*/
/*Ejercicio sin terminar o que no funcione correctamente ni esté bien planteado.  => 0 puntos  *******/
 

select "Ejercicio_1";
-- Ejercicio 1:
-- Programa las instrucciones necesarias para añadirle a la tabla "motores" un campo de tipo decimal (7,2) de nombre "precio_motor" que no pueda contener valores null.
-- Programa las instrucciones necesarias para eliminar en la tabla "componentes" el campo "material_usado" 
alter table motores add precio_motor decimal(7,2) not null;
alter table componentes drop material_usado;

describe motores;
describe componentes;


select "Ejercicio_2";
-- Ejercicio 2:
-- Programa las instrucciones necesarias para quitar la clave primaria que tiene la tabla componentes
-- y asisgnársela al campo "denominacion". Haz un describe para ver el resultado.
alter table componentes drop primary key;
alter table componentes add primary key (denominacion);

describe componentes;


select "Ejercicio_3";
-- Ejercicio 3:
-- Programa las instrucciones necesarias para añadir a la tabla "componentes" un índice, llamado "i_componente" en el campo "id_componente".
-- A continuación programa las instrucciones necesarias para describir cómo ha quedado la estructura de la tabla y finalmente
-- vuelve a dejarla como estaba, quitándole ese índice. Vuelve a describir la tabla para comprobar que ya no está el índice.
alter table componentes add index i_componente (id_componente);
describe componentes;

alter table componentes drop index i_componente;
describe componentes;


select "Ejercicio_4";
-- Ejercicio 4:
-- Programa las instrucciones necesarias para que los campos "denominacion" de la tabla "motores" y "denominacion" de la tabla "componentes" puedan almacenar hasta 30 caracteres.
alter table motores modify denominacion varchar(30) not null;
alter table componentes modify denominacion varchar(30) not null;

describe motores;
describe componentes;


select "Ejercicio_5";
-- Ejercicio 5:
-- Programa las instrucciones necesarias intercambiar los nombres de las dos tablas, de tal forma que "componentes" pase a llamarse "motores" y "motores" se llame "componentes".
-- Programa las instrucciones necesarias para que se muestren las estructuras de las dos tablas antes y después de intercambiar los nombres.
-- Deshaz los cambios llevados a cabo para que vuelvan a quedar como estaban inicialmente
select'PUNTO DE PARTIDA:';
describe motores;
describe componentes;

rename table componentes to auxiliar, motores to componentes, auxiliar to motores;

select 'NOMBRES INTERCAMBIADOS:';
describe motores;
describe componentes;

rename table componentes to auxiliar, motores to componentes, auxiliar to motores;

select 'VUELTA AL ESTADO INICIAL:';
describe motores;
describe componentes;


select "Ejercicio_6";
-- Ejercicio 6:
-- Programa las instrucciones necesarias para crear una tabla llamada "componentes_motor" que muestre los campos
-- "denominacion" y "precio" de la tabla "componentes" y el campo "denominación" y "tipo" de la tabla "motores" 
-- Debes cambiar (mediante alias) algún nombre de campo en la tabla que vas a crear, ya que colisionarán dos campos por llamarse igual("denominacion")
create table componentes_motor select c.denominacion as denominacion_comp, c.precio, m.denominacion as denominacion_motor, m.tipo from componentes as c join motores as m on m.id_motor=c.id_motor;

describe componentes_motor; 
select * from componentes_motor;


select "Ejercicio_7";
-- Ejercicio 7:
-- Programa las instrucciones necesarias para crear una tabla llamada "total_de_componentes_por_motor"
-- que contendrá un campo llamado "denominacion_motor" y otro llamado "total_de_componentes" (Indicará cuántos componentes tiene cada motor). 
-- Para poder llevar a cabo el ejercicio, deberás tener en cuenta el agrupamiento adecuado.
create table total_de_componentes_por_motor select m.denominacion as denominacion_motor, count(*) as total_de_componentes from motores as m join componentes as c on c.id_motor=m.id_motor group by m.denominacion;

select * from total_de_componentes_por_motor;


select "Ejercicio_8";
-- Ejercicio 8:
-- Programa las instrucciones previas necesarias para que al ejecutar la instrucción:
-- delete from motores where id_motor = 2;
-- ...automáticamente se borren también sus componentes asociados.:
select * from motores;
select * from componentes;

alter table componentes add foreign key (id_motor) references motores(id_motor) on delete cascade;
delete from motores where id_motor=2;

select 'FK añadida y motores (where id_motor=2) borrados';
select * from motores;
select * from componentes;


select "Ejercicio_9";
-- Ejercicio 9:
-- Reescribe la instrucción "delete..." anterior, de manera que al realizar el borrado del motor cuyo "id_motor" sea = 2 y sus componentes, no sea necesario usar una Foreign Key.

select 'Vuelvo a cargar el Script para restaurar las tablas tal cual estaban (sin FK)';
drop table if exists componentes;
drop table if exists motores;

create table motores (
id_motor int,
bastidor_asociado varchar (12),
denominacion varchar (20) not null,
tipo enum ('Eléctrico', 'Híbrido', 'Gasolina', 'Diésel') not null,
fecha_fabricacion datetime,
primary key (id_motor)
);
create table componentes (
id_componente int,
denominacion varchar (20) not null,
precio decimal (7,2) not null,
precio_rebajado decimal (7,2) not null,
material_usado varchar (30),
id_motor int not null,
primary key (id_componente)
);
insert into motores values (1, 'AX563300', 'motor_1', 'Gasolina', '2017-08-10');
insert into motores values (2, 'NY000567', 'motor_2', 'Eléctrico', '2022-11-23');
insert into motores values (3, 'JK051299', 'motor_3', 'Híbrido', '2023-02-01');
insert into componentes values (1, 'componente_1', 150.00, 145.90, 'Acero', 1);
insert into componentes values (2, 'componente_2', 39.00, 37.50, null, 1);
insert into componentes values (3, 'componente_3', 96.00, 89.25, null, 2);
insert into componentes values (4, 'componente_4', 49.00, 49.00, 'Plástico y alumninio', 2);
insert into componentes values (5, 'componente_5', 17.00, 14.50, null, 3);

select 'TABLAS RESTAURADAS A SU ORIGEN';
select * from motores;
select * from componentes;

delete motores,componentes 
	from motores 
	join componentes 
	on componentes.id_motor = motores.id_motor 
	where motores.id_motor = 2;

select 'MOTORES ID=2 BORRADOS';
select * from motores;
select * from componentes;


select "Ejercicio_10";
-- Ejercicio 10:
-- Programa las instrucciones necesarias para generar una tabla llamada "descuentos" a partir de la tabla componentes, que tendrá los campos:
-- "denominacion", "precio_componente" e "importe_a_descontar", calculado este último como la diferencia entre los campos "precio" y "precio_rebajado"
create table descuentos select c.denominacion, c.precio as precio_componente, round((c.precio-c.precio_rebajado),2) as importe_a_descontar from componentes as c;

describe descuentos;
select * from descuentos;


