drop database if exists prueba;
create database prueba;
use prueba;


create table motores (
	id_motor int,
	motor varchar (20) not null,
	tipomotor enum ('Eléctrico', 'Híbrido', 'Gasolina', 'Diésel') not null,
	primary key (id_motor)
);


create table componentes (
	id_componente int,
	componente varchar (20) not null,
	precio decimal (7,2) not null,
	id_motor int not null,
	primary key (id_componente),
	foreign key (id_motor) references motores (id_motor)
);


insert into motores values (1, 'motor_1', 'Gasolina');
insert into motores values (2, 'motor_2', 'Eléctrico');

insert into componentes values (1, 'componente_1', 150.00, 1);
insert into componentes values (2, 'componente_2', 39.00, 1);
insert into componentes values (3, 'componente_3', 96.00, 2);

/*
Programa la(s) instrucción(es) SQL necesaria(s) para:

Crear y cargar de datos una nueva tabla llamada “componentes_motor” a partir de las tablas “componentes” y “motores” anteriores. La nueva tabla “componentes_motor” estará formada por todos los campos de la tabla componentes (excepto el campo “id_motor”) más el campo “motor” de la tabla “motores”.
*/
-- Primero hacemos la consulta que proporciona la tabla que queremos obtener:
select c.id_componente, c.componente, c.precio, m.motor from componentes as c join motores as m on c.id_motor=m.id_motor;

-- Añadimos el CREATE:
create table componentes_motor select c.id_componente, c.componente, c.precio, m.motor from componentes as c join motores as m on c.id_motor=m.id_motor;

-- Traza para comporbar el resultado:
select * from componentes_motor;



/*
Programa la(s) instrucción(es) SQL necesaria(s) para que se añada a la tabla componentes un campo de tipo entero llamado “cantidad_en_stock” que pueda contener valores nulos.”
*/
alter table componentes add cantidad_en_stock int;

-- traza para ver el resultado:
select * from componentes;


/*
Programa la(s) instrucción(es) SQL necesaria(s) para conseguir que el campo
“componente” sea la nueva clave primaria de la tabla “componentes”.
*/
-- traza para ver punto de partida:
describe componentes;

alter table componentes drop primary key;
alter table componentes add primary key(componente);

-- traza para ver el resultado:
describe componentes;

