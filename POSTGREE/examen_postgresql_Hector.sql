/*DAW Examen Postgresql 26/05/2023*/
drop table if exists ivas;
create table ivas (
	id_iva int primary key,
	descripcion varchar(20),
	valor decimal(4,2)
);

drop table if exists familias;
create table familias (
id_familia int primary key,
familia varchar(20)
);

drop table if exists productos;
create table productos (
	id_producto int primary key,
	producto varchar(30),
	precio_base decimal(5,2),
	porcentaje_descuento decimal(4,2),
	id_iva int,
	id_familia int
);
drop table if exists clientes;
create table clientes (
	id_cliente int primary key,
	nombre varchar(30)
);
drop table if exists cab_facturas;
create table cab_facturas (
	id_factura int primary key,
	id_cliente int,
	fecha_hora date
);
drop table if exists lin_facturas;
create table lin_facturas (
	id_factura int,
	id_linea int,
	id_producto int,
	cantidad int,
	primary key (id_factura, id_linea)
);


insert into ivas values (1,'Iva Reducido', 4.00);
insert into ivas values (2,'Iva Normal', 10.00);
insert into ivas values (3,'Iva Lujo', 16.00);

insert into clientes values (1,'Rocío Carrasco');
insert into clientes values (2,'José L. García');
insert into clientes values (3,'Andrés Sánchez');
insert into clientes values (4,'Luisa Palomares');
insert into clientes values (5,'Ana Jiménez');
insert into clientes values (6,'Julio Torres');

insert into familias values (1,'Alimentación');
insert into familias values (2,'Ropa');
insert into familias values (3,'Complementos');
insert into familias values (4,'Electrodomésticos');

insert into productos  values (1, 'Barra de pan', 0.75,10, 1, 1);
insert into productos  values (2, 'Litro leche', 0.90,10, 1, 1);
insert into productos  values (3, 'Paquete café', 1.20,20, 1, 1);
insert into productos  values (4, 'Kg. patatas', 0.60,50, 2, 1);
insert into productos  values (5, 'Kg. naranjas', 1.50,10, 2, 1);
insert into productos  values (6, 'Kg. tomates', 1.80,10, 2, 1);
insert into productos  values (7, 'Pantalón vaquero', 45.50,20, 3, 2);
insert into productos  values (8, 'Reloj Casio', 22.00,0, 3, 2);

insert into cab_facturas values (1, 1,'2023-10-01');
insert into cab_facturas values (2, 5,'2023-10-02');
insert into cab_facturas values (3, 6,'2023-10-03');


insert into lin_facturas values (1,1,2, 1);
insert into lin_facturas values (1,2,3, 2);
insert into lin_facturas values (1,3,4, 3);
insert into lin_facturas values (1,4,1, 2);
insert into lin_facturas values (2,1,5, 3);
insert into lin_facturas values (2,2,6, 1);
insert into lin_facturas values (2,3,7, 2);
insert into lin_facturas values (3,1,5, 1);
insert into lin_facturas values (3,2,6, 1);
insert into lin_facturas values (3,3,7, 1);
insert into lin_facturas values (3,4,8, 1);

/* EJERCICIO 1:  (1 punto)
Realizar una función pl/pgsql llamada "lineas_por_factura(id int)" que recibe un parámetro que es un identificador de cabecera de factura
y retorna un valor entero que indica el número de líneas de factura que tiene la factura.
Antes de consultar el número de líneas, se comprobará que existe la factura en la tabla de cabeceras de factura. Si no existe, se emitirá un mensaje 
avisando de que dicha factura no existe en la base de datos, y retornará un 0 sin hacer la consulta de las líneas*/
CREATE or replace FUNCTION lineas_por_factura(id int) RETURNS int AS
$$
DECLARE
	var_id int;
	var_lineas int;
BEGIN
	var_lineas = 0;
	select id_factura into var_id from cab_facturas where id_factura = id;
	if not found 
	then
		raise notice 'La factura con id: % no existe en la base de datos', id;
	else
		select COUNT(*) into var_lineas from lin_facturas where id_factura = id;
	end if;
	return var_lineas;
END;
$$ LANGUAGE plpgsql;
select lineas_por_factura(1);



/* EJERCICIO 2:  (2,5 puntos)
Realizar una función pl/pgsql llamada "importe_total_factura(id int)" que recibe un parámetro que es un identificador
de cabecera de factura y retornará el importe total de la suma de los precios con descuento e iva de toda la compra
teniendo en cuenta también la cantidad que se ha comprado de cada producto*/
CREATE or replace FUNCTION importe_total_factura(id int) RETURNS decimal AS
$$
DECLARE
	var_lineas int;
	var_contador int;
	var_total decimal (5,2);
	var_id_fac int;
	var_id_prod int;
	var_cant int;
	var_p_base decimal (5,2);
	var_id_iva int;
	var_valor_iva decimal (4,2);
BEGIN
	var_total = 0;
	select COUNT(*) into var_lineas from lin_facturas where id_factura = id;
	if not found 
	then
		raise notice 'La factura con id: % no existe en la base de datos', id;
	else
		var_contador = 1;
		LOOP
			select l.id_factura, l.id_producto, l.cantidad, p.precio_base, p.id_iva, i.valor
			into var_id_fac, var_id_prod, var_cant, var_p_base, var_id_iva, var_valor_iva
			from lin_facturas as l join productos as p on l.id_producto = p.id_producto
			join ivas as i on p.id_iva = i.id_iva where l.id_factura = id AND var_contador = l.id_linea;

			var_total = var_total + (var_p_base * (1 + (var_valor_iva / 100)) * var_cant);

			var_contador = var_contador +1;
			if var_contador > var_lineas
			then
				exit;
			end if;	
		END LOOP;
	end if;
	return var_total;
END;
$$ LANGUAGE plpgsql;
select importe_total_factura(2);


/* EJERCICIO 3:  (3 puntos)
Realizar una función pl/pgsql llamada "informacion_completa_de_producto(id int)" que recibe un parámetro que es un identificador de producto y 
no retorna ningún valor, la salida es por mensajes "raise notice" y debe mostrar el encabezado y valores siguientes:
ID: El id_producto
PRODUCTO: El nombre del producto
FAMILIA: La familia a la que pertenece el producto
PRECIO_BASE: El precio base del producto
PORCENTAJE_DESCUENTO: El porcentaje de descuento que tiene.
PRECIO_CON_DESCUENTO: El precio del producto después de aplicarle el porcentaje de descuento que tenga el producto
VALOR_IVA: El valor del iva para ese producto
PRECIO_CON_IVA: Es el resultado de aplicarle el valor del iva al PRECIO_CON_DESCUENTO 

ID    PRODUCTO     			FAMILIA        PRECIO_BASE    PORCENTAJE_DESCUENTO   PRECIO_CON_DESCUENTO   VALOR_IVA    PRECIO_CON_IVA
--    ------------------    -----------    ------------    ------------------    -------------------    ---------    --------------
xx    xxxxxxxxxxxxxx        xxxxxxxxxxxx   xxxxxxxxx                 xx            xxxxxxxxxxx               xx        xxxxxxxxxxxx   */
CREATE or replace FUNCTION informacion_completa_de_producto(id_prod int) RETURNS void AS
$$
DECLARE
	var_nom_producto varchar;
	var_id_familia int;
	var_nom_fam varchar;
	var_precio_base decimal(5,2);
	var_descuento decimal (4,2);
	var_precio_con_descuento decimal(5,2);
	var_valor_iva decimal(4,2);
	var_precio_con_iva decimal(5,2);
BEGIN
	select p.producto, p.id_familia, p.precio_base, p.porcentaje_descuento, f.familia, i.valor 
	into var_nom_producto, var_id_familia, var_precio_base, var_descuento, var_nom_fam, var_valor_iva 
	from productos as p join ivas as i on p.id_iva = i.id_iva join familias as f on p.id_familia = f.id_familia
	where p.id_producto = id_prod;
	if not found 
	then
		raise notice 'El producto con id: % no existe en la base de datos', id_prod;
	else
		var_precio_con_descuento = var_precio_base*(1-(var_descuento/100));
		var_precio_con_iva = var_precio_con_descuento*(1+(var_valor_iva/100));
		
		raise notice 'ID    PRODUCTO                FAMILIA        PRECIO_BASE    PORCENTAJE_DESCUENTO   PRECIO_CON_DESCUENTO   VALOR_IVA    PRECIO_CON_IVA';
		raise notice '--    ------------------      -----------    ------------    ------------------    -------------------    ---------    --------------';
		raise notice '%     %           %         %                %             %             %            %', 
		id_prod, var_nom_producto, var_nom_fam, var_precio_base, var_descuento, var_precio_con_descuento, var_valor_iva, var_precio_con_iva;
	end if;
END;
$$ LANGUAGE plpgsql;
select informacion_completa_de_producto(2);


/* EJERCICIO 4:  (3,5 puntos)
Realizar una función pl/pgsql llamada "productos_de_la_familia(id int)" sin valor de retorno, que recibe un parámetro, que es un identificador
de familia y mediante mensajes "raise notice" mostrará la información de la familia y a continuación, haciendo uso del correspondiente bucle,
y sin definir ningún cursor, se mostrará la información básica de los productos que pertenecen a dicha familia.

Para realizar esta función, se diseñará un algoritmo de bucle loop parecido al que se hizo en el archivo sql que tienes en classroom en la
entrada de nombre "19/05/2023 Ejercicios pl_pgsql". Dentro de este apartado, en el archivo de soluciones, hicimos la función
"insertar_productos_iva()" que se recorre la tabla de productos empezando por un valor 1 para el id_producto para hacerle la comprobación necesaria.
Dicho valor se va incrementando en el bucle y finalmente nos salimos del bucle cuando hayamos recorrido tantos registros como hemos calculado que
tenemos que procesar. Después del procesamiento de los productos, se mostrará la cantidad total de productos de dicha familia.

ID_FAMILIA: xx   FAMILIA: xxxxxxxxx   

ID    PRODUCTO     			PRECIO_BASE    TIPO_IVA
--    ------------------    -----------    --------
xx    xxxxxxxxxxxxxx        xxxxxxxxx            xx 

Total productos de la familia: xx  */
CREATE or replace FUNCTION productos_de_la_familia(id_fam int) RETURNS void AS
$$
DECLARE
	var_fam varchar;
	var_id_prod int;
	var_nom_prod varchar;
	var_contador_prod int;
	var_total_prod int;
	var_p_base decimal(5,2);
	var_iva int;
	var_contador int;
BEGIN
	select familia into var_fam from familias where id_familia = id_fam;
	if not found
	then
		raise notice 'La familia con id: % no existe en la base de datos', id_fam;
	else
		raise notice 'ID_FAMILIA: %   FAMILIA: %', id_fam, var_fam;
		raise notice ' ';
		raise notice 'ID    PRODUCTO                PRECIO_BASE    TIPO_IVA';
		raise notice '--    ------------------      -----------    --------';
		
		var_contador = 1;
		var_contador_prod = 1;
		select COUNT(*) into var_total_prod from productos where id_familia = id_fam;
		LOOP
			select p.id_producto, p.producto, p.precio_base, p.id_iva
			into var_id_prod, var_nom_prod, var_p_base, var_iva
			from productos as p where p.id_familia = id_fam and p.id_producto = var_contador_prod;
			if not found
			then
				-- Solo aumento el contador de id.prod para buscar el siguiente
				
			else
				-- Aumento contador de registros y muestro resultado:
				var_contador = var_contador +1;
				raise notice '%      %                %         %', var_id_prod, var_nom_prod, var_p_base, var_iva;
			end if;
			var_contador_prod = var_contador_prod +1;
		
			if var_contador > var_total_prod
			then
				exit;
			end if;	
		END LOOP;
		raise notice ' ';
		raise notice 'Total productos de la familia % son: %', id_fam, var_total_prod;
	end if;
END;
$$ LANGUAGE plpgsql;
select productos_de_la_familia(1);

