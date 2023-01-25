DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS fabricante;

CREATE TABLE fabricante (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio decimal (7,2) NOT NULL, /* -> pasamos de double a decimal (7,2) para no tener más de dos decimales en los precios.*/
  id_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (id_fabricante) REFERENCES fabricante(id)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);


/* ********************************************************************************************************* */
/* *********************** 1.1.3 Consultas sobre una tabla ************************************************* */
/* ********************************************************************************************************* */

/* 1 - Lista el nombre de todos los productos que hay en la tabla producto.*/
select nombre from producto;

/* 2 - Lista los nombres y los precios de todos los productos de la tabla producto.*/
select nombre, round(precio, 2) from producto;

/* 3 - Lista todas las columnas de la tabla producto.*/
select * from producto;

/* 4 - Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).*/
select nombre, concat(precio, '€'), concat(precio/1.09, '$') from producto.

/* 5 - Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares. */ 
select nombre, concat(precio, '€') as euros, concat(round(precio/1.09,2), '$') as dólares from producto;

/* 6 - Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.*/
select upper(nombre) as NOMBRE, precio from producto;

/* 7 - Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.*/
select lower(nombre) as nombre, precio from producto;

/* 8 - Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.*/
select nombre, upper(left(nombre,2)) as nombre_2mayu from fabricante; /*las 2 ultimas por la IZQ*/
select nombre, upper(substring(nombre,1,2)) as nombre_2mayu from fabricante; /*desde la posicion 1 a la 2*/

/* 9 - Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.*/
select nombre, round(precio, 0) as precio from producto;

/* 10 - Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.*/
select nombre, truncate(precio,0) as precio from producto;

/* 11 - Lista el identificador de los fabricantes que tienen productos en la tabla producto.*/
select id_fabricante from producto;

/* 12 - Lista el identificador de los fabricantes que tienen productos en la tabla producto, eliminando los identificadores que aparecen repetidos.*/
select distinct id_fabricante from producto;

/* 13 - Lista los nombres de los fabricantes ordenados de forma ascendente.*/
select nombre from fabricante order by nombre asc;

/* 14 - Lista los nombres de los fabricantes ordenados de forma descendente.*/
select nombre from fabricante order by nombre desc;

/* 15 - Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.*/
select nombre from producto

/* 16 - Devuelve una lista con las 5 primeras filas de la tabla fabricante.*/
select * from fabricante limit 5;

/* 17 - Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.*/
select * from fabricante limit 3,2; /*a partir de la fila 3, 2 posiciones*/

/* 18 - Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)*/
select nombre, precio from producto order by precio asc limit 1;

/* 19 - Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)*/
select nombre, precio from producto order by precio desc limit 1;

/* 20 - Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2.*/
select nombre from producto where id_fabricante=2;

/* 21 - Lista el nombre de los productos que tienen un precio menor o igual a 120€.*/
select nombre, precio from producto where precio<=120;

/* 22 - Lista el nombre de los productos que tienen un precio mayor o igual a 400€.*/
select nombre, precio from producto where precio>=400;

/* 23 - Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.*/
select nombre, precio from producto where precio<400;

/* 24 - Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.*/
select nombre, precio from producto where precio>=80 and precio<=300;

/* 25 - Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.*/
select nombre, precio from producto where precio between 60 and 200;

/* 26 - Lista todos los productos que tengan un precio mayor que 200€ y que el identificador de fabricante sea igual a 6.*/
select nombre, precio from producto where precio >200 and id_fabricante=6;

/* 27 - Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.*/


/* 28 - Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Utilizando el operador IN.*/

/* 29 - Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la columna que contiene el precio que se llame céntimos.*/

/* 30 - Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.*/

/* 31 - Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.*/

/* 32 - Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.*/

/* 33 - Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.*/

/* 34 - Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.*/

/* 35 - Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.*/

/* 36 - Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).*/

/* ********************************************************************************************************* */
/* *********************** 1.1.4 Consultas multitabla (Composición interna) ******************************** */
/* ********************************************************************************************************* */

/* 1 - Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.*/

/* 2 - Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.*/

/* 3 - Devuelve una lista con el identificador del producto, nombre del producto, identificador del fabricante y nombre del fabricante, de todos los productos de la base de datos.*/

/* 4 - Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.*/

/* 5 - Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.*/

/* 6 - Devuelve una lista de todos los productos del fabricante Lenovo.*/

/* 7 - Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.*/

/* 8 - Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Sin utilizar el operador IN.*/

/* 9 - Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.*/

/* 10 - Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.*/

/* 11 - Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.*/
select p.nombre, p.precio, f.nombre from producto as p join fabricante as f on f.id=p.id_fabricante where p.precio >= 180;

/* 12 - Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)*/
select p.nombre, p.precio, f.nombre from producto as p join fabricante as f on f.id=p.id_fabricante where p.precio >= 180 order by p.precio desc, p.nombre desc;

/* 13 - Devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.*/


