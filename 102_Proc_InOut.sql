drop database if exists nominas;
 create database nominas;
 use nominas;

drop table if exists empleados;

 create table empleados(
  documento char(8),
  nombre varchar(20),
  apellido varchar(20),
  sueldo decimal(6,2),
  cantidadhijos int,
  seccion varchar(20),
  primary key(documento)
 );

--  Ingrese algunos registros:
 insert into empleados values('22222222','Juan','Perez',300,2,'Contaduria');
 insert into empleados values('22333333','Luis','Lopez',700,0,'Contaduria');
 insert into empleados values ('22444444','Marta','Perez',500,1,'Sistemas');
 insert into empleados values('22555555','Susana','Garcia',400,2,'Secretaria');
 insert into empleados values('22666666','Jose Maria','Morales',1200,3,'Secretaria');


 drop procedure if exists pa_cantidad_hijos;
 
 -- Creamos un procedimiento que recibe un número de documento y un entero 
 -- como parámetro de entrada y salida
 delimiter //
 create procedure pa_cantidad_hijos(
   in p_documento char(8),
   inout cantidad int)
 begin
   select cantidadhijos+cantidad into cantidad 
     from empleados
     where documento=p_documento;
 end //hijos
 delimiter ;
 
 -- Iniciamos un acumulador en cero
 set @cant=0;
 -- Calculamos la cantidad de hijos que tiene '22222222'
 call pa_cantidad_hijos('22222222',@cant); 
 select @cant; -- muestra un 2
 
 -- Acumulamos en @cant la cantidad de hijos de '22222222' y '22666666'
 call pa_cantidad_hijos('22666666',@cant);
 select @cant; -- muestra un 5
 
 
/* Diseñar un proicedimiento que recibe dos paramentros, uno es el documento del empleado y el otro es el porcentaje de retencion de la seguridad social. Devolvera el sueldo del empleado y el nuevo sueldo, que es anterior pero restando la retención: */

 drop procedure if exists pa_sueldos;

delimiter //
create procedure pa_sueldos(
	in doc char(8),
	in ret decimal(4,2),
	out sdo decimal(6,2),
	out nuevosdo decimal(6,2)
	)
begin
	select sueldo*(1-ret) into nuevosdo
	from empleados
	where documento=doc;

	select sueldo into sdo
	from empleados
	where documento=doc;
end //
delimiter ;

/* INICIALIZAMOS LAS VCARIABLES QUE PASAMOS A LA FUNCIÓN */
/* Como en Java, no tienen que coincidir llos nombres, solo mismo orden y tipado */
set @documento = '22222222';
set @retencion = 0.18;
set @sueldo = 0;
set @nuevosueldo = 0;

/* LLAMAMOS A LA FUNCION */
call pa_sueldos(@documento, @retencion, @sueldo, @nuevosueldo);
select @documento, @retencion, @sueldo, @nuevosueldo;

/* OTRA FORMA DE HACERLO */
call pa_sueldos('22222222', 0.18, @sueldo, @nuevosueldo);
select '22222222' as DNI, 0.18 as Retención, @sueldo as Sueldo_Base, @nuevosueldo as Sueldo_Neto;




/* Diseña un procedimiento para que reciba una sección y devuelva el sueldo más alto que se cobra en esa seccióny el nombre de quien lo cobra */
 drop procedure if exists pa_max;

delimiter //
create procedure pa_max(
	in sec varchar(20),
	out maximo decimal(6,2),
	out nom varchar(20)
	)
begin
	select max(sueldo) into maximo
	from empleados
	where seccion=sec;

	select nombre into nom
	from empleados
	where sueldo=maximo limit 1;
end //
delimiter ;

/* INICIALIZAMOS LAS VARIABLES QUE PASAMOS A LA FUNCIÓN */
set @maximo = 0;
set @nombre = '';

/* LLAMAMOS A LA FUNCION */
call pa_max('Secretaria', @maximo, @nombre);
select @maximo, @nombre;





/* Hacer un procedimiento que reciba un apellido y devuelva su nombre, tengo que limitar la salida, elijo el primer nombre que cumpla el requisito:*/
 drop procedure if exists pa_ape_nombre;

delimiter //
create procedure pa_ape_nombre(
	inout ape varchar(20),
	out nom varchar(20)
	)
begin
	select nombre into nom
	from empleados
	where apellido=ape limit 1;
end //
delimiter ;

/* INICIALIZAMOS LAS VARIABLES QUE PASAMOS A LA FUNCIÓN */
set @nombre = '';
set @apellido ='Perez';
/* LLAMAMOS A LA FUNCION */
call pa_ape_nombre(@apellido, @nombre);
select @apellido, @nombre;











