Así como la cláusula "where" permite seleccionar (o rechazar) registros individuales; la cláusula "having" permite seleccionar (o rechazar) un grupo de registros.

Si queremos saber la cantidad de libros agrupados por editorial usamos la siguiente instrucción ya aprendida:

 select editorial, count(*) from libros
  group by editorial;

Si queremos saber la cantidad de libros agrupados por editorial pero considerando sólo algunos grupos, por ejemplo, los que devuelvan un valor mayor a 2, usamos la siguiente instrucción:

 select editorial, count(*) from libros
  group by editorial
  having count(*)>2;

Se utiliza "having", seguido de la condición de búsqueda, para seleccionar ciertas filas retornadas por la cláusula "group by".

Veamos otros ejemplos. Queremos el promedio de los precios de los libros agrupados por editorial:

 select editorial, avg(precio) from libros
  group by editorial;

Ahora, sólo queremos aquellos cuyo promedio supere los 25 pesos:

 select editorial, avg(precio) from libros
  group by editorial
  having avg(precio)>25;

En algunos casos es posible confundir las cláusulas "where" y "having". Queremos contar los registros agrupados por editorial sin tener en cuenta a la editorial "Planeta".

Analicemos las siguientes sentencias:

 select editorial, count(*) from libros
  where editorial<>'Planeta'
  group by editorial;
 select editorial, count(*) from libros
  group by editorial
  having editorial<>'Planeta';

Ambas devuelven el mismo resultado, pero son diferentes.

La primera, selecciona todos los registros rechazando los de editorial "Planeta" y luego los agrupa para contarlos. La segunda, selecciona todos los registros, los agrupa para contarlos y finalmente rechaza la cuenta correspondiente a la editorial "Planeta".

No debemos confundir la cláusula "where" con la cláusula "having"; la primera establece condiciones para la selección de registros de un "select"; la segunda establece condiciones para la selección de registros de una salida "group by".

Veamos otros ejemplos combinando "where" y "having".

Queremos la cantidad de libros, sin considerar los que tienen precio nulo, agrupados por editorial, sin considerar la editorial "Planeta":

 select editorial, count(*) from libros
  where precio is not null
  group by editorial
  having editorial<>'Planeta';

Aquí, selecciona los registros rechazando los que no cumplan con la condición dada en "where", luego los agrupa por "editorial" y finalmente rechaza los grupos que no cumplan con la condición dada en el "having".

Generalmente se usa la cláusula "having" con funciones de agrupamiento, esto no puede hacerlo la cláusula "where". Por ejemplo queremos el promedio de los precios agrupados por editorial, de aquellas editoriales que tienen más de 2 libros:

 select editorial, avg(precio) from libros
  group by editorial
  having count(*) > 2; 

Podemos encontrar el mayor valor de los libros agrupados por editorial y luego seleccionar las filas que tengan un valor mayor o igual a 30:

 select editorial, max(precio) from libros
  group by editorial
  having max(precio)>=30; 

Esta misma sentencia puede usarse empleando un "alias", para hacer referencia a la columna de la expresión:

 select editorial, max(precio) as 'mayor' from libros
  group by editorial
  having mayor>=30;

Servidor de MySQL instalado en forma local.

Ingresemos al programa "Workbench" y ejecutemos el siguiente bloque de instrucciones SQL para analizar la cláusula having:

drop table if exists libros;

create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(60) not null,
  autor varchar(30),
  editorial varchar(15),
  precio decimal(5,2) unsigned,
  primary key (codigo)
 );

insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Planeta',15);
insert into libros (titulo,autor,editorial,precio)
  values('Martin Fierro','Jose Hernandez','Emece',22.20);
insert into libros (titulo,autor,editorial,precio)
  values('Antologia poetica','Borges','Planeta',40);
insert into libros (titulo,autor,editorial,precio)
  values('Aprenda PHP','Mario Molina','Emece',18.20);
insert into libros (titulo,autor,editorial,precio)
  values('Cervantes y el quijote','Borges','Paidos',36.40);
insert into libros (titulo,autor,editorial,precio)
  values('Manual de PHP', 'J.C. Paez', 'Paidos',30.80);
insert into libros (titulo,autor,editorial,precio)
  values('Harry Potter y la piedra filosofal','J.K. Rowling','Paidos',45.00);
insert into libros (titulo,autor,editorial,precio)
  values('Harry Potter y la camara secreta','J.K. Rowling','Paidos',46.00);
insert into libros (titulo,autor,editorial,precio)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Paidos',null);

-- Queremos averiguar la cantidad de libros agrupados por editorial:
select editorial, count(*) from libros
  group by editorial;

-- Queremos conocer la cantidad de libros agrupados por editorial pero considerando
-- sólo los que devuelvan un valor mayor a 2
select editorial, count(*) from libros
  group by editorial
  having count(*)>2;

-- Necesitamos el promedio de los precios de los libros agrupados por editorial:
select editorial, avg(precio)
  from libros
  group by editorial;

-- sólo queremos aquellos cuyo promedio supere los 25 pesos:
select editorial, avg(precio)
  from libros
  group by editorial
  having avg(precio)>25;

-- Queremos contar los registros agrupados por editorial sin tener en cuenta
-- a la editorial "Planeta"
select editorial, count(*) from libros
  where editorial<>'Planeta'
  group by editorial;
select editorial, count(*) from libros
  group by editorial
  having editorial<>'Planeta';

 -- Queremos la cantidad de libros, sin tener en cuenta los que tienen precio nulo,
 -- agrupados por editorial, rechazando los de editorial "Planeta"
select editorial, count(*) from libros
  where precio is not null
  group by editorial
  having editorial<>'Planeta';

-- promedio de los precios agrupados por editorial, de aquellas editoriales
-- que tienen más de 2 libros 
select editorial, avg(precio) from libros
  group by editorial
  having count(*) > 2; 

-- mayor valor de los libros agrupados por editorial y luego seleccionar las filas
-- que tengan un valor mayor o igual a 30 
select editorial, max(precio)
  from libros
  group by editorial
  having max(precio)>=30; 

-- Para esta misma sentencia podemos utilizar un "alias" para hacer referencia a la
-- columna de la expresión
select editorial, max(precio) as 'mayor'
  from libros
  group by editorial
  having mayor>=30; 

