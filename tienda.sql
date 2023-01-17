drop database if exists tienda;
create database tienda;
use tienda;
create table cliente(
    cod_cliente int auto_increment primary key,
    nombre varchar(10) not null,
    ape1 varchar(10) not null,
    ape2 varchar(10),
    edad int
);
insert into cliente values(15,'Pedro','Peter',null,30);
insert into cliente (nombre,ape1,edad)values('Pedro','Peter',30);
insert into cliente (nombre, ape1, edad) values ('Carmen', 'Lopez', 25);
insert into cliente values (30, 'Carlos', 'García', null, 48);

create table pedido(
    cod_pedido int primary key,
    fecha_pedido date not null,
    importe numeric(5,2),
    cod_cliente int,
    foreign key (cod_cliente) references cliente(cod_cliente)
);
insert into pedido values(1435,'2022-03-12',58.50, 15);
insert into pedido values (1436, '2021-08-12', 99.00, 30);
insert into pedido values (1437, '2021-08-12', 399.00, 17);

create table articulo(
    cod_articulo int primary key,
    descripcion varchar(25) not null,
    precio numeric(5,2)
);
create table art_ped(
    cod_ped int,
    cod_art int,
    cantidad int,
    primary key(cod_ped, cod_art),select fe
    foreign key (cod_ped) references pedido(cod_pedido),
    foreign key (cod_art) references articulo(cod_articulo)
);
insert into articulo values(125,'8 GB Memoria Ram',50.00);
insert into articulo values(126,'Placa base ASUS',99.00);
insert into articulo values(127,'Procesadir Intel i7',185.00);
insert into articulo values (200, 'Pantalón Vaquero', 35.00);
insert into articulo values (222, 'Camisa algodón', 55.00);
insert into art_ped values(1435,125,5);
insert into art_ped values(1435,126,2);
insert into art_ped values(1435,127,1);
insert into art_ped values (1436, 200, 2);
insert into art_ped values (1436, 222, 1);
insert into art_ped values (1437, 125, 1);
insert into art_ped values (1437, 126, 1);


