drop database if exists padrehijo;
create database padrehijo;
use padrehijo;
drop table if exists padre;
drop table if exists hijo;
create table padre(
	dni varchar(10) primary key,
	nombre varchar(15) not null,
	apellido varchar(15) not null,
	sueldo decimal(6,2),
	r_irpf decimal(4,2),
	r_ss decimal(4,2)
);
create table hijo(
	dni varchar(10) primary key,
	nombre varchar(15) not null,
	apellido varchar(15) not null,
	fecha_nacimiento date,
	dni_padre varchar(10) not null,
	foreign key (dni_padre) references padre(dni)
);
insert into padre values ('12121212-X', 'Pedro', 'Jiménez', 1125.56, 0.15, 0.3);
insert into padre values ('23232323-P', 'Andres', 'López', 1689.85, 0.2, 0.35);
insert into hijo values ('87878787-A', 'Rosa', 'Jiménez', '2001/10/12', '12121212-X');
insert into hijo values ('90909090-Z', 'Rafael', 'Jiménez', '2001/10/12', '12121212-X');
insert into hijo values ('67676767-U', 'Ana', 'López', '2005/06/23', '23232323-P');
insert into hijo values ('55555555-X', 'Isabel', 'Jiménez', '2000/07/01', '12121212-X');

select dni, nombre, apellido, sueldo as Base_imp, sueldo*r_irpf as Irpf, sueldo*r_ss as S_Social, sueldo - sueldo*r_irpf - sueldo*r_ss as neto from padre;
