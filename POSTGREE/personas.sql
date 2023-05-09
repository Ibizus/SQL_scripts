drop table if exists clientes;
drop table if exists personas;

CREATE TABLE personas (
	id_personas int primary key,
	nombre VARCHAR(50),
	apellido VARCHAR(50),
	telefono VARCHAR(20),
	fecha_nacim DATE
);
CREATE TABLE clientes (
	nro_cuenta INT,
	estado VARCHAR(10),
	TIPOCLIENTE char(1)
) INHERITS (PERSONAS);

insert into personas values (1, 'Juan', 'López', '676676676', '2000/01/12');
insert into clientes values (2, 'Isabel', 'Díaz', '898898898', '1995/04/30');

select*from personas;
select*from clientes;
delete from personas where id_personas=2;
select*from personas;
select*from clientes;
-- delete from clientes where id_personas=2;
select*from personas;
select*from clientes;