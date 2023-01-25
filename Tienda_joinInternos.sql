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
  -- precio DOUBLE NOT NULL, --> ha cambiado esto por decimal para que cuando se pidan los precios salga en formato moneda con 2 decimales
  precio decimal (7,2) NOT NULL,
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

/* 1 - Lista los nombres y los precios de todos los productos de la tabla producto.*/
select nombre, round(precio, 2) from producto; 

/* 1 - Lista todas las columnas de la tabla producto.*/
select * from producto;

/* 1 - Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).*/
select nombre, concat(round(precio,2), '€'), concat(round(precio/1.09,2), '$') from producto;

/* 1 - Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.*/
select nombre as nombre_de_producto, concat(round(precio,2), '€') as dolares, concat(round(precio/1.09,2), '$') as euros from producto;

/* 1 - Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.*/
select upper(nombre) as NOMBRE, round (precio, 2) as precio from producto;

/* 1 - Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.*/
select lower(nombre) as nombre, round (precio, 2) as precio from producto;

/* 1 - Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.*/
select nombre, concat(upper(substring(nombre,1,2)), substring(nombre,3,length(nombre))) as nombre_2mayus from fabricante; 

/* 1 - Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.*/
select nombre, round(precio,0) from producto; 

/* 1 - Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.*/
select nombre, truncate(precio,0) from producto; 

/* 1 - Lista el identificador de los fabricantes que tienen productos en la tabla producto.*/
select fabricante.id from fabricante join producto on (fabricante.id = producto.id_fabricante) group by fabricante.id;

/* 1 - Lista el identificador de los fabricantes que tienen productos en la tabla producto, eliminando los identificadores que aparecen repetidos.*/
select distinct fabricante.id from fabricante join producto where (fabricante.id = producto.id_fabricante);

/* 1 - Lista los nombres de los fabricantes ordenados de forma ascendente.*/
select nombre from fabricante order by nombre asc;

/* 1 - Lista los nombres de los fabricantes ordenados de forma descendente.*/
select nombre from fabricante order by nombre desc;

/* 1 - Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.*/
select precio, nombre from producto order by nombre asc, precio desc;

/* 1 - Devuelve una lista con las 5 primeras filas de la tabla fabricante.*/
select * from fabricante limit 5;

/* 1 - Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.*/
select * from fabricante limit 3,2;

/* 1 - Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)*/
select nombre, precio from producto order by precio asc limit 0,1;

/* 1 - Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)*/
select nombre, precio from producto order by precio desc limit 0,1;

/* 1 - Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2.*/
select nombre from producto where id=2;

/* 1 - Lista el nombre de los productos que tienen un precio menor o igual a 120€.*/
select nombre from producto where precio <= 120;

/* 1 - Lista el nombre de los productos que tienen un precio mayor o igual a 400€.*/
select nombre from producto where precio >= 400;

/* 1 - Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.*/
select nombre from producto where precio < 400;

/* 1 - Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.*/
select nombre from producto where precio>=80 and precio<=300;

/* 1 - Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.*/
select nombre from producto where precio between 60 and 200;

/* 1 - Lista todos los productos que tengan un precio mayor que 200€ y que el identificador de fabricante sea igual a 6.*/
select precio, nombre, id_fabricante from producto where precio>200 and id_fabricante = 6;

/* 1 - Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.*/
select * from producto where id_fabricante=1 or id_fabricante=3 or id_fabricante=5;

/* 1 - Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Utilizando el operador IN.*/
select * from producto where id_fabricante in (1,3,5);

/* 1 - Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la columna que contiene el precio que se llame céntimos.*/
select nombre, precio*100 as céntimos from producto;

/* 1 - Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.*/
select nombre from fabricante where nombre like 'S%';

/* 1 - Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.*/
select nombre from fabricante where nombre like '%e';

/* 1 - Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.*/
select nombre from fabricante where nombre like '%w%';

/* 1 - Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.*/
select nombre from fabricante where length(nombre)=4;

/* 1 - Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.*/
select nombre from producto where nombre like '%Portátil%';

/* 1 - Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.*/
select nombre from producto where nombre like '%Monito%' and precio<215;

/* 1 - Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).*/
select nombre, precio from producto where precio>=180 order by precio desc, nombre asc;


/* ********************************************************************************************************* */
/* *********************** 1.1.4 Consultas multitabla (Composición interna) ******************************** */
/* ********************************************************************************************************* */

/* 1 - Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.*/
select producto.nombre, precio, fabricante.nombre from producto join fabricante on producto.id_fabricante = fabricante.id;

/* 2 - Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.*/
select producto.nombre, precio, fabricante.nombre from producto join fabricante on producto.id_fabricante = fabricante.id order by fabricante.nombre asc;

/* 3 - Devuelve una lista con el identificador del producto, nombre del producto, identificador del fabricante y nombre del fabricante, de todos los productos de la base de datos.*/
select p.id as id_producto, p.nombre as nombre_producto, f.id as id_fabricante, f.nombre as nombre_fabricante from producto as p join fabricante as f on p.id_fabricante = f.id;

/* 4 - Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.*/
-- Como subconsulta: 
select p.nombre as nombre_producto, p.precio as producto_mas_barato, f.nombre as nombre_fabricante from producto as p join fabricante as f on p.id_fabricante = f.id where precio = (select min(precio) from producto);

-- Con limit: 
-- select p.nombre as nombre_producto, p.precio, f.nombre as nombre_fabricante from producto as p join fabricante as f on p.id_fabricante = f.id order by precio limit 1;

-- Producto cartesiano: mezcla todos los fabricantes con todos los productos. Es lo que hace siempre que ponemos un join y después filtra por p.id_fabricante = f.id. Select * from producto join fabricante;

/* 5 - Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.*/
select p.nombre as nombre_producto, p.precio as producto_mas_caro, f.nombre as nombre_fabricante from producto as p join fabricante as f on p.id_fabricante = f.id where precio = (select max(precio) from producto);

/* 6 - Devuelve una lista de todos los productos del fabricante Lenovo.*/
select p.id, p.nombre, p.precio, f.nombre as Lenovo from producto as p join fabricante as f on f.id = p.id_fabricante and f.nombre = 'Lenovo'; 

/* 7 - Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.*/
select p.id, p.nombre, p.precio, f.nombre as Crucial_mayor_200€ from producto as p join fabricante as f on f.id = p.id_fabricante and f.nombre = 'Crucial' where precio>200; 

/* 8 - Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.*/
select p.id, p.nombre, p.precio from producto as p join fabricante as f on f.id = p.id_fabricante and (f.nombre = 'Asus' or f.nombre = 'Hewlett-Packard' or f.nombre = 'Seagate');

/* 9 - Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Utilizando el operador IN.*/
select p.id, p.nombre, precio from producto as p join fabricante as f on f.id = p.id_fabricante and f.nombre in ('Asus', 'Hewlett-Packard', 'Seagate');

/* 10 - Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.*/
select p.nombre, precio from producto as p join fabricante as f on f.id = p.id_fabricante and f.nombre like '%e';

/* 12 - Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.*/
select p.nombre, precio from producto as p join fabricante as f on f.id = p.id_fabricante and f.nombre like '%w%';

/* 13 - Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente) */
select p.nombre, precio, f.nombre as nombre_fabricante from producto as p join fabricante as f on f.id = p.id_fabricante and precio>=180 order by precio desc, p.nombre asc;

/* 14 - Devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.*/
select distinct f.id, f.nombre from fabricante as f join producto as p on f.id = p.id_fabricante; 
