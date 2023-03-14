drop database prueba;
create database prueba;
use prueba;

create table motores (
id_motor int,
bastidor_asociado varchar (12),
nombre_motor varchar (20) not null,
tipomotor enum ('Eléctrico', 'Híbrido', 'Gasolina', 'Diésel') not null,
primary key (id_motor)
);

create table componentes (
id_componente int,
nombre_componente varchar (20) not null,
precio decimal (7,2) not null,
precio_rebajado decimal (7,2) not null,
id_motor int not null,
primary key (id_componente)
);

insert into motores values (1, 'AX563300', 'motor_1', 'Gasolina');
insert into motores values (2, 'NY000567', 'motor_2', 'Eléctrico');
insert into componentes values (1, 'componente_1', 150.00, 145.90, 1);
insert into componentes values (2, 'componente_2', 39.00, 37.50, 1);
insert into componentes values (3, 'componente_3', 96.00, 89.25, 2);


-- Ejercicio 1:
-- Escribe las instrucciones necesarias para añadirle a la tabla "componentes" un campo de tipo fecha llamado "fecha_fabricacion" que pueda contener valores null.
alter table componentes add fecha_fabricacion date;

-- Ejercicio 2:
-- Escribe las instrucciones necesarias para eliminar en la tabla "componentes" el campo "precio_rebajado".
-- alter table componentes drop precio_rebajado;

-- Ejercicio 3:
-- Escribe las instrucciones necesarias para quitar la clave primaria que tiene la tabla motores y asisgnársela al campo "bastidor_asociado".
alter table motores drop primary key;
alter table motores add primary key (bastidor_asociado);

-- Ejercicio 4:
-- Escribe las instrucciones necesarias para añadir a la tabla "motores" un índice único para el campo "id_motor", llamado "i_id_motor".
alter table motores add unique index i_id_motor (id_motor);

-- Ejercicio 5:
-- Escribe las instrucciones necesarias para eliminar el índice creado en el ejercicio 4.
alter table motores drop index i_id_motor;

-- Ejercicio 6:
-- Escribe las instrucciones necesarias para que los campos "nombre_motor" de la tabla "motores" y "nombre_componente" de la tabla "componentes" puedan almacenar hasta 30 caracteres.
alter table motores modify nombre_motor varchar(30) not null,
alter table componentes modify nombre_componentes varchar(30) not null;

-- Ejercicio 7:
-- Escribe las instrucciones necesarias para que los campos "nombre_motor" de la tabla "motores" y "nombre_componente" de la tabla "componentes" puedan almacenar hasta 30 caracteres.


-- Ejercicio 8:
-- Escribe las instrucciones necesarias intercambiar los nombres de las dos tablas, de tal forma que "componentes" pase a llamarse "motores" y "motores" se llame "componerntes".
-- Escribe las instrucciones necesarias para que se muestren las estructuras de las dos tablas antes y después de intercambiar los nombres.
-- Deshaz los cambios llevados a cabo para que vuelvan a quedar como estaban inicialmente
select 'ESTADO INICIAL:';
describe motores;
describe componentes;

rename table componentes to auxiliar, motores to componentes, auxiliar to motores;

select 'DESPUES DEL CAMBIO:';
describe motores;
describe componentes;

rename table componentes to auxiliar, motores to componentes, auxiliar to motores;

select 'VUELTA A LA NORMALIDAD:';
describe motores;
describe componentes;

-- Ejercicio 9:
-- Escribe las instrucciones necesarias para crear una tabla llamada "componentes_motor" que muestre los campos "nombre_componente", "precio" y el campo "nombre_del_motor"  
create table componentes_motor select c.nombre_componente, c.precio, m.nombre_motor from componentes as c join motores as m on c.id_motor=m.id_motor;

select*from componentes_motor;

-- Ejercicio 10:
-- Escribe las instrucciones necesarias para crear una tabla llamada "total_componentes_por_motor" que contendrá un campo llamado "motor" y otro llamado "total_componentes" (Indicará cuántos componentes tiene cada motor). 
create table total_componentes_por_motor select m.nombre_motor as motor, count(*) as total_componentes from motores as m join componentes as c on c.id_motor=m.id_motor group by m.nombre_motor;

select*from total_componentes_por_motor;

-- Ejercicio 11:
-- Escribe las instrucciones necesarias para que al borrar un motor de la base de datos mediante la instrucción siguiente:
-- delete from motores where id_motor = 2;
-- ...automáticamente se borren también sus componentes asociados.:
alter table motores drop primary key;
alter table motores add primary key (id_motor);

show create table motores;

/*alter table componentes add foreign key (id_motor) references motores(id_motor) on delete cascade;*/

/*delete from motores where id_motor = 2;

select*from motores;
select*from componentes;*/

-- Ejercicio 12:
-- Reescribe la instrucción "delete..." anterior, de manera que al realizar el borrado del motor cuyo "id_motor" sea = 2 y sus componentes, no sea necesario usar una Foreign Key.
/*delete motores,componentes from motores join componentes on motores.id_motor = componentes.id_motor where motores.id_motor=2;

select*from motores;
select*from componentes;*/

-- Ejercicio 13:
-- Escribe las instrucciones necesarias para generar una tabla llamada "descuentos" a partir de la tabla componentes, que tendrá los campos:
-- "nombre_componente", "precio_componente" e "importe_a_descontar", calculado este último como la diferencia entre los campos "precio" y "precio_rebajado"
create table descuentos select c.nombre_componente, c.precio, round((precio - precio_rebajado),2) as importe_a_descontar from componentes as c;


-- Ejercicio 14:
-- Escribe las instrucciones necesarias para que al actualizar el valor de "id_motor" en la tabla "motores" a su valor actual + 5, se actualice
-- dicho campo igualmente en la tabla componentes:
-- Hacerlo de dos formas:
-- Con JOIN:
select * from motores;
select * from componentes;

/* habria que borrar la foreign key primero 

show create table componentes;

alter table componentes drop constraint componentes_ibfk_1;*/

update motores 
	join componentes 
	on motores.id_motor=componentes.id_motor 
	set motores.id_motor = motores.id_motor+5, 
	componentes.id_motor = componentes.id_motor+5;

select * from motores;
select * from componentes;

-- Sin JOIN:
alter table componentes add foreign key (id_motor) references motores(id_motor) on update cascade;

update motores set id_motor = id_motor+5;


























