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

describe componentes;

-- Ejercicio 2:
-- Escribe las instrucciones necesarias para eliminar en la tabla "componentes" el campo "precio_rebajado".

/* lo comento porque en un ejercicio de mas adelante hay que usar el campo precio_rebajado

alter table componentes drop precio_rebajado;

describe componentes;

*/

-- Ejercicio 3:
-- Escribe las instrucciones necesarias para quitar la clave primaria que tiene la tabla motores y asisgnársela al campo "bastidor_asociado".

alter table motores drop primary key;

alter table motores add primary key (bastidor_asociado);

describe motores;

-- Ejercicio 4:
-- Escribe las instrucciones necesarias para añadir a la tabla "motores" un índice único para el campo "id_motor", llamado "i_id_motor".

alter table motores add index i_id_motor (id_motor);

describe motores;


-- Ejercicio 5:
-- Escribe las instrucciones necesarias para eliminar el índice creado en el ejercicio 4.

alter table motores drop index i_id_motor;

describe motores;

-- Ejercicio 6:
-- Escribe las instrucciones necesarias para que los campos "nombre_motor" de la tabla "motores" y "nombre_componente" de la tabla "componentes" puedan almacenar hasta 30 caracteres.

alter table motores modify nombre_motor varchar(30);
alter table componentes modify nombre_componente varchar(30);

describe motores;
describe componentes;

-- Ejercicio 7:
-- Escribe las instrucciones necesarias para que los campos "nombre_motor" de la tabla "motores" y "nombre_componente" de la tabla "componentes" puedan almacenar hasta 30 caracteres.

/* es lo mismo que el 6 */


-- Ejercicio 8:
-- Escribe las instrucciones necesarias intercambiar los nombres de las dos tablas, de tal forma que "componentes" pase a llamarse "motores" y "motores" se llame "componerntes".
-- Escribe las instrucciones necesarias para que se muestren las estructuras de las dos tablas antes y después de intercambiar los nombres.
-- Deshaz los cambios llevados a cabo para que vuelvan a quedar como estaban inicialmente

select 'ejercicio 8';

select * from motores;
select * from componentes;

rename table motores to auxiliar,
	componentes to motores,
	auxiliar to componentes;
	
select * from motores;
select * from componentes;

rename table motores to auxiliar,
	componentes to motores,
	auxiliar to componentes;
	
select * from motores;
select * from componentes;
	
-- Ejercicio 9:
-- Escribe las instrucciones necesarias para crear una tabla llamada "componentes_motor" que muestre los campos "nombre_componente", "precio" y el campo "nombre_del_motor"  

select nombre_componente, precio, nombre_motor from componentes as c
	join motores as m on c.id_motor = m.id_motor;
	
create table componentes_motor select nombre_componente, precio, nombre_motor from componentes as c
	join motores as m on c.id_motor = m.id_motor;
	
select * from componentes_motor;


-- Ejercicio 10:
-- Escribe las instrucciones necesarias para crear una tabla llamada "total_componentes_por_motor" que contendrá un campo llamado "motor" y otro llamado "total_componentes" (Indicará cuántos componentes tiene cada motor). 

select 'ejercicio 10';

select nombre_motor, count(*) as total_componentes from componentes
	join motores on componentes.id_motor = motores.id_motor
	group by nombre_motor;
	
create table total_componentes_por_motor select nombre_motor, count(*) as total_componentes from componentes
	join motores on componentes.id_motor = motores.id_motor
	group by nombre_motor;
	
select * from total_componentes_por_motor;

-- Ejercicio 11:
-- Escribe las instrucciones necesarias para que al borrar un motor de la base de datos mediante la instrucción siguiente:
-- delete from motores where id_motor = 2;
-- ...automáticamente se borren también sus componentes asociados.:

/* habria que volver a cambiar la primary key de motores y añadir id_motor como primary key */

alter table motores drop primary key;

alter table motores add primary key (id_motor);

describe motores;

alter table componentes add foreign key (id_motor) 
	references motores (id_motor) on delete cascade;

describe componentes;

show create table componentes;

-- Ejercicio 12:
-- Reescribe la instrucción "delete..." anterior, de manera que al realizar el borrado del motor cuyo "id_motor" sea = 2 y sus componentes, no sea necesario usar una Foreign Key.

/* lo comento para no borrar los valores realmente, ya que los voy a usar mas tarde
 
 delete motores, componentes from motores
	join componentes on motores.id_motor = componentes.id_motor
	where motores.id_motor = 2;
	
select * from motores;
select * from componentes;

*/

-- Ejercicio 13:
-- Escribe las instrucciones necesarias para generar una tabla llamada "descuentos" a partir de la tabla componentes, que tendrá los campos:
-- "nombre_componente", "precio_componente" e "importe_a_descontar", calculado este último como la diferencia entre los campos "precio" y "precio_rebajado"

select nombre_componente, precio as precio_componente, (precio-precio_rebajado) as importe_a_desconstar from componentes;

create table descuento select nombre_componente, precio as precio_componente, (precio-precio_rebajado) as importe_a_desconstar from componentes;

select * from descuento;

-- Ejercicio 14:
-- Escribe las instrucciones necesarias para que al actualizar el valor de "id_motor" en la tabla "motores" a su valor actual + 5, se actualice
-- dicho campo igualmente en la tabla componentes:
-- Hacerlo de dos formas:
-- Con JOIN:

/* habria que borrar la foreign key primero */

show create table componentes;

alter table componentes drop constraint componentes_ibfk_1;

select * from motores;
select * from componentes;

update motores join componentes
	on motores.id_motor = componentes.id_motor
	set motores.id_motor = motores.id_motor + 5,
	componentes.id_motor = componentes.id_motor + 5;

select * from motores;
select * from componentes;


-- Sin JOIN:

alter table componentes add foreign key (id_motor) references motores (id_motor) on update cascade;

describe componentes;

select * from motores;
select * from componentes;

update motores set id_motor = id_motor + 5;

select * from motores;
select * from componentes;




























