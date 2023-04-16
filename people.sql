drop database if exists people;
create database people;
use people;

create table people(
	dni char(8) primary key,
	nombre varchar(20),
	apellidos varchar(50), 
	telefono char(9)
);

insert into people values ('12345678', 'Paco', 'Martínez', '666666666');  
insert into people values ('12345689', 'Luisa', 'Díaz', '777777777');  
insert into people values ('12345690', 'Jose', 'López', '888888888');

select * from people;


