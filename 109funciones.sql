/*
Tenemos una tabla llamada 'sitios' donde almacenamos las url de distintos sitios web, la cantidad de páginas que se visualizan por mes y la cantidad de estrellas asignadas (un valor entre 1 y 5)
*/
drop table if exists sitios;

create table sitios (
    url varchar(100),
    cantpaginas int,
    estrellas tinyint,
    primary key(url)
);

insert into sitios(url,cantpaginas,estrellas) values ('lanacion.com.ar',17000000,3);
insert into sitios(url,cantpaginas,estrellas) values ('clarin.com',42000000,3);
insert into sitios(url,cantpaginas,estrellas) values ('infobae.com',33000000,5);
insert into sitios(url,cantpaginas,estrellas) values ('lavoz.com.ar',25000000,2);

/*
Implementar una función que le enviemos la cantidad de estrellas que tiene un sitio y nos devuelva un varchar con tantos '*' como indica el parámetro:
*/
drop function if exists f_estrellas;

delimiter //
create function f_estrellas(
  cant tinyint)
  returns varchar(15)
  deterministic
 begin
   declare estrellas varchar(15) default '';
   declare x int default 0;
   while x<cant do
     set estrellas=concat(estrellas,'*');
     set x=x+1;
   end while;
   return estrellas;
 end //
 delimiter ; 
 
 select url,f_estrellas(estrellas) from sitios;
 
/*
Confeccionar una segunda función que le enviemos la cantidad de páginas que se visualizan por mes y nos retorne un varchar indicando si el sitio tiene 'tráfico bajo', 'tráfico medio' o 'alto tráfico'.

Tener en cuenta:
Es de 'tráfico bajo' si entrega menos de 20000000 de páginas.
Es de 'tráfico medio' si entrega entre 20000000 y 40000000 de páginas.
Es de 'tráfico alto' si entrega má 40000000 de páginas.

Primero borramos la función almacenada si existe y procedemos a crearla:
*/
drop function if exists f_tipositio;
 
 delimiter //
 create function f_tipositio(
   cantidad int)
   returns varchar(20)
   deterministic
 begin
case 
    when cantidad<20000000 then
      return 'tráfico bajo';
    when cantidad>=20000000 and cantidad<40000000 then
      return 'tráfico medio';
    when cantidad>=40000000 then
      return 'tráfico alto';
  end case; 
 end //
 delimiter ;
 
 select url,f_estrellas(estrellas), cantpaginas, f_tipositio(cantpaginas) from sitios;
 

/*
Confeccionar una tercer función que nos retorne la url del sitio que tiene mayor tráfico:

Ahora confeccionar una función que retorne la 'url' del sitio que tiene mayor tráfico:
 */
drop function if exists f_mayor_trafico;
 
 delimiter //
 create function f_mayor_trafico()
   returns varchar(100)
   deterministic
 begin
   declare vurl varchar(100);
   select url into vurl from sitios order by cantpaginas desc limit 1;
   return vurl;
 end //
 delimiter ;
 
 select f_mayor_trafico();
 
 
/*
Una funcion que devuelva el dominio
*/

drop function if exists f_dominio;
 
 delimiter //
 create function f_dominio(
   p_url varchar(100))
   returns varchar(3)
   deterministic
 begin
   declare dominio varchar(3) default '';
   set dominio=right(p_url,3);
   return dominio;
 end //
 delimiter ;
 
 select url, f_dominio(url) from sitios where estrellas = 3;
 
/*
Crear una funcion llamda f_cociente que devuelva un valor entero obtenido de dividir las visitas de una url entre sus estrellas
Prueba la funcion con un select* sin filtro para todos los sitios web
*/

drop function if exists f_cociente;
 
 delimiter //
 create function f_cociente(
   p_cantpaginas int,
   p_estrellas tinyint)
   returns int
   deterministic
 begin
   declare resultado int default 0;
   set resultado=p_cantpaginas/p_estrellas;
   return resultado;
 end //
 delimiter ;
 
 select url, cantpaginas, estrellas, f_cociente(cantpaginas,estrellas) as cociente from sitios;

