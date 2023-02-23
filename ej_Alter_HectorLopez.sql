 drop table if exists clientes;
 drop table if exists empleados;
 drop table if exists trabajadores;
 
 create table clientes(
  documento char(8) not null,
  nombre varchar(30),
  domicilio varchar(30),
  fechaingreso date,
  sueldo decimal(6,2) unsigned
 );
 create table empleados(
  documento char(8) not null,
  nombre varchar(30),
  domicilio varchar(30),
  ciudad varchar(30),
  provincia varchar(30)
 );

-- 1 Alter para añadir el campo numero de hijos a clientes
 alter table clientes
   add numero_hijos tinyint unsigned; 

-- 2 Alter para crear un indice unico para el domicilio del cliente
 alter table clientes
   add unique index i_domicilio (domicilio);
   
 show index from clientes;

-- 3 Alter para crear claves primarias en ambas tablas (documento)
 alter table clientes
   add primary key (documento);
   
 alter table empleados
   add primary key (documento);

-- 4 Alter para renombrar la tabla de "empleados" como "trabajadores"
 rename table empleados to trabajadores;

-- 5 Alter para cambiar el indice del punto 2 a indice no único
 alter table clientes
   drop index i_domicilio;
   
 alter table clientes
   add index i_domicilio (domicilio);


-- 6 Mostrar los índices de ambas tablas
 show index from clientes;
 show index from trabajadores;


describe table clientes;
describe table trabajadores;
