-- a) mostrar el numero de orden y el total de la orden con maximo dinero

select o.id_orden, SUM(p.precio*o.cantidad) as Total from orden o, producto p
where o.producto_id_producto = p.id_producto
group by o.id_orden
order by Total desc
limit 1;

-- b) Mostrar el número de cliente, nombre, apellido y el total del cliente
-- que más ha comprado.

select c.id_cliente, c.nombre, c.apellido, SUM(p.precio*o.cantidad) as Total from orden o, cliente c, producto p
where c.id_cliente = o.cliente_id_cliente and p.id_producto = o.producto_id_producto
group by c.id_cliente
order by Total desc
limit 1;

-- c) Mostrar el número de país, el nombre y el total del país que menos ha
-- comprado y el que más ha comprado, (una sola consulta).

(
select pa.id_pais, pa.nombrepais, SUM(p.precio*o.cantidad) as Total from cliente c, orden o, pais pa, producto p
where o.cliente_id_cliente = c.id_cliente
and o.producto_id_producto = p.id_producto
and c.pais_id_pais = pa.id_pais
group by pa.id_pais
order by Total
limit 1
) union (
select pa.id_pais, pa.nombrepais, SUM(p.precio*o.cantidad) as Total from cliente c, orden o, pais pa, producto p
where o.cliente_id_cliente = c.id_cliente
and o.producto_id_producto = p.id_producto
and c.pais_id_pais = pa.id_pais
group by pa.id_pais
order by Total desc
limit 1
)
order by Total;

-- d) Mostrar el número de cliente, el número de órdenes, el país y el total
-- de los cinco clientes que más han comprado de Rusia.

select c.id_cliente, COUNT(o.id_orden), pa.nombrepais, SUM(p.precio*o.cantidad) as Total
from cliente c, orden o, producto p, pais pa
where o.cliente_id_cliente = c.id_cliente
and o.producto_id_producto = p.id_producto
and c.pais_id_pais = pa.id_pais
and pa.nombrepais = 'Rusia'
group by c.id_cliente, pa.nombrepais
order by Total desc
limit 5;

-- e) Mostrar el número de mes y el total de dinero del mes que tiene más
-- y menos ventas (una sola consulta).

(
select to_char(o.fecha_orden, 'MM') as mes, SUM(p.precio*o.cantidad) as Total
from orden o, producto p
where o.producto_id_producto = p.id_producto
group by mes
order by Total desc
limit 1
) union (
select to_char(o.fecha_orden, 'MM') as mes, SUM(p.precio*o.cantidad) as Total
from orden o, producto p
where o.producto_id_producto = p.id_producto
group by mes
order by Total
limit 1
);

-- f) Mostrar el día y el total ordenado por total más alto al más bajo de los
-- cinco días más rentables.

select to_char(o.fecha_orden, 'DD') as dia, SUM(p.precio*o.cantidad) as Total
from orden o, producto p
where o.producto_id_producto = p.id_producto
group by dia
order by Total desc
limit 5;

-- g) Mostrar el día y el promedio, ordenado por promedio más alto al más
-- bajo de los cinco días más rentables.

select to_char(o.fecha_orden, 'DD') as dia, AVG(p.precio*o.cantidad) as Promedio
from orden o, producto p
where o.producto_id_producto = p.id_producto
group by dia
order by Promedio desc
limit 5;

-- h) Mostrar el nombre de la categoría más y menos vendida y el total
-- vendido (una sola consulta).

(
select c.nombrecategoria, SUM(p.precio*o.cantidad) as Total
from orden o, producto p, categoria c
where o.producto_id_producto = p.id_producto
and p.categoria_id_categoria = c.id_categoria
group by c.id_categoria
order by Total desc
limit 1
) union
(
select c.nombrecategoria, SUM(p.precio*o.cantidad) as Total
from orden o, producto p, categoria c
where o.producto_id_producto = p.id_producto
and p.categoria_id_categoria = c.id_categoria
group by c.id_categoria
order by Total
limit 1
);

-- la c y i son iguales

-- j) Mostrar el nombre del país, número de mes y el total de las ventas
-- por mes en Canadá.

select pa.nombrepais, to_char(o.fecha_orden, 'MM') as mes, SUM(p.precio*o.cantidad) as Total
from orden o, producto p, cliente c, pais pa
where o.producto_id_producto = p.id_producto
and o.cliente_id_cliente = c.id_cliente
and c.pais_id_pais = pa.id_pais
and pa.nombrepais = 'Canada'
group by pa.nombrepais, mes
order by mes;

-- k) Mostrar el país, el año y el total de ventas de la categoría Animación.

select pa.nombrepais, to_char(o.fecha_orden, 'YYYY') as year, SUM(p.precio*o.cantidad) as Total
from orden o, producto p, categoria c, cliente cl, pais pa
where o.producto_id_producto = p.id_producto
and p.categoria_id_categoria = c.id_categoria
and o.cliente_id_cliente = cl.id_cliente
and cl.pais_id_pais = pa.id_pais
and c.nombrecategoria = 'Animacion'
group by year, c.id_categoria, pa.nombrepais;

-- l) Mostrar el nombre del vendedor, el mes, la categoría y el total de las
-- ventas del vendedor 1 en la categoría deportes.

select v.nombrevendedor, to_char(o.fecha_orden, 'MM') as mes, c.nombrecategoria, SUM(p.precio*o.cantidad) as Total
from orden o, producto p, categoria c, vendedor v
where o.producto_id_producto = p.id_producto
and o.vendedor_id_vendedor = v.id_vendedor
and p.categoria_id_categoria = c.id_categoria
and v.id_vendedor = 1
and c.nombrecategoria = 'Deportes'
group by v.id_vendedor, mes, c.nombrecategoria
order by mes;

-- m) Mostrar totales vendidos por categoría y por mes. Se debe visualizar
-- la categoría, el total del mes 1 hasta el mes 12 y los subtotales tanto
-- horizontal como vertical.
(
select 
c.nombrecategoria as categoria,
SUM(CASE WHEN extract(month from o.fecha_orden)=1 THEN p.precio*o.cantidad ELSE 0 END) as mes_1,
SUM(CASE WHEN extract(month from o.fecha_orden)=2 THEN p.precio*o.cantidad ELSE 0 END) as mes_2,
SUM(CASE WHEN extract(month from o.fecha_orden)=3 THEN p.precio*o.cantidad ELSE 0 END) as mes_3,
SUM(CASE WHEN extract(month from o.fecha_orden)=4 THEN p.precio*o.cantidad ELSE 0 END) as mes_4,
SUM(CASE WHEN extract(month from o.fecha_orden)=5 THEN p.precio*o.cantidad ELSE 0 END) as mes_5,
SUM(CASE WHEN extract(month from o.fecha_orden)=6 THEN p.precio*o.cantidad ELSE 0 END) as mes_6,
SUM(CASE WHEN extract(month from o.fecha_orden)=7 THEN p.precio*o.cantidad ELSE 0 END) as mes_7,
SUM(CASE WHEN extract(month from o.fecha_orden)=8 THEN p.precio*o.cantidad ELSE 0 END) as mes_8,
SUM(CASE WHEN extract(month from o.fecha_orden)=9 THEN p.precio*o.cantidad ELSE 0 END) as mes_9,
SUM(CASE WHEN extract(month from o.fecha_orden)=10 THEN p.precio*o.cantidad ELSE 0 END) as mes_10,
SUM(CASE WHEN extract(month from o.fecha_orden)=11 THEN p.precio*o.cantidad ELSE 0 END) as mes_11,
SUM(CASE WHEN extract(month from o.fecha_orden)=12 THEN p.precio*o.cantidad ELSE 0 END) as mes_12,
SUM(p.precio*o.cantidad) as subtotal
FROM orden o, producto p, categoria c
where o.producto_id_producto = p.id_producto
and p.categoria_id_categoria = c.id_categoria
group by categoria
) union (
select 
'subtotal',
SUM(CASE WHEN extract(month from o.fecha_orden)=1 THEN p.precio*o.cantidad ELSE 0 END) as mes_1,
SUM(CASE WHEN extract(month from o.fecha_orden)=2 THEN p.precio*o.cantidad ELSE 0 END) as mes_2,
SUM(CASE WHEN extract(month from o.fecha_orden)=3 THEN p.precio*o.cantidad ELSE 0 END) as mes_3,
SUM(CASE WHEN extract(month from o.fecha_orden)=4 THEN p.precio*o.cantidad ELSE 0 END) as mes_4,
SUM(CASE WHEN extract(month from o.fecha_orden)=5 THEN p.precio*o.cantidad ELSE 0 END) as mes_5,
SUM(CASE WHEN extract(month from o.fecha_orden)=6 THEN p.precio*o.cantidad ELSE 0 END) as mes_6,
SUM(CASE WHEN extract(month from o.fecha_orden)=7 THEN p.precio*o.cantidad ELSE 0 END) as mes_7,
SUM(CASE WHEN extract(month from o.fecha_orden)=8 THEN p.precio*o.cantidad ELSE 0 END) as mes_8,
SUM(CASE WHEN extract(month from o.fecha_orden)=9 THEN p.precio*o.cantidad ELSE 0 END) as mes_9,
SUM(CASE WHEN extract(month from o.fecha_orden)=10 THEN p.precio*o.cantidad ELSE 0 END) as mes_10,
SUM(CASE WHEN extract(month from o.fecha_orden)=11 THEN p.precio*o.cantidad ELSE 0 END) as mes_11,
SUM(CASE WHEN extract(month from o.fecha_orden)=12 THEN p.precio*o.cantidad ELSE 0 END) as mes_12,
SUM(p.precio*o.cantidad) as subtotal
FROM orden o, producto p, categoria c
where o.producto_id_producto = p.id_producto
and p.categoria_id_categoria = c.id_categoria
)

-- n) Mostrar totales vendidos por categoría y por país. Se debe visualizar
-- el país y el total de la categoría Action hasta Travel y los subtotales
-- tanto horizontal como vertical.

(
select 
pa.nombrepais as pais,
SUM(CASE WHEN c.id_categoria=1 THEN p.precio*o.cantidad ELSE 0 END) as Accion,
SUM(CASE WHEN c.id_categoria=2 THEN p.precio*o.cantidad ELSE 0 END) as Animacion,
SUM(CASE WHEN c.id_categoria=3 THEN p.precio*o.cantidad ELSE 0 END) as Kids,
SUM(CASE WHEN c.id_categoria=4 THEN p.precio*o.cantidad ELSE 0 END) as Clasicos,
SUM(CASE WHEN c.id_categoria=5 THEN p.precio*o.cantidad ELSE 0 END) as Comedia,
SUM(CASE WHEN c.id_categoria=6 THEN p.precio*o.cantidad ELSE 0 END) as Documentales,
SUM(CASE WHEN c.id_categoria=7 THEN p.precio*o.cantidad ELSE 0 END) as Drama,
SUM(CASE WHEN c.id_categoria=8 THEN p.precio*o.cantidad ELSE 0 END) as Familia,
SUM(CASE WHEN c.id_categoria=9 THEN p.precio*o.cantidad ELSE 0 END) as Extranjeros,
SUM(CASE WHEN c.id_categoria=10 THEN p.precio*o.cantidad ELSE 0 END) as Juegos,
SUM(CASE WHEN c.id_categoria=11 THEN p.precio*o.cantidad ELSE 0 END) as Horror,
SUM(CASE WHEN c.id_categoria=12 THEN p.precio*o.cantidad ELSE 0 END) as Musica,
SUM(CASE WHEN c.id_categoria=13 THEN p.precio*o.cantidad ELSE 0 END) as Nuevo,
SUM(CASE WHEN c.id_categoria=14 THEN p.precio*o.cantidad ELSE 0 END) as CienciaFiccion,
SUM(CASE WHEN c.id_categoria=15 THEN p.precio*o.cantidad ELSE 0 END) as Deportes,
SUM(CASE WHEN c.id_categoria=16 THEN p.precio*o.cantidad ELSE 0 END) as Viajes,
SUM(p.precio*o.cantidad) as subtotal
FROM orden o, producto p, categoria c, pais pa, cliente cl
where o.producto_id_producto = p.id_producto
and p.categoria_id_categoria = c.id_categoria
and o.cliente_id_cliente = cl.id_cliente
and cl.pais_id_pais = pa.id_pais
group by pais
order by pais
) union (
select 
'subtotal',
SUM(p.precio*o.cantidad) as subtotal,
SUM(CASE WHEN c.id_categoria=1 THEN p.precio*o.cantidad ELSE 0 END) as Accion,
SUM(CASE WHEN c.id_categoria=2 THEN p.precio*o.cantidad ELSE 0 END) as Animacion,
SUM(CASE WHEN c.id_categoria=3 THEN p.precio*o.cantidad ELSE 0 END) as Kids,
SUM(CASE WHEN c.id_categoria=4 THEN p.precio*o.cantidad ELSE 0 END) as Clasicos,
SUM(CASE WHEN c.id_categoria=5 THEN p.precio*o.cantidad ELSE 0 END) as Comedia,
SUM(CASE WHEN c.id_categoria=6 THEN p.precio*o.cantidad ELSE 0 END) as Documentales,
SUM(CASE WHEN c.id_categoria=7 THEN p.precio*o.cantidad ELSE 0 END) as Drama,
SUM(CASE WHEN c.id_categoria=8 THEN p.precio*o.cantidad ELSE 0 END) as Familia,
SUM(CASE WHEN c.id_categoria=9 THEN p.precio*o.cantidad ELSE 0 END) as Extranjeros,
SUM(CASE WHEN c.id_categoria=10 THEN p.precio*o.cantidad ELSE 0 END) as Juegos,
SUM(CASE WHEN c.id_categoria=11 THEN p.precio*o.cantidad ELSE 0 END) as Horror,
SUM(CASE WHEN c.id_categoria=12 THEN p.precio*o.cantidad ELSE 0 END) as Musica,
SUM(CASE WHEN c.id_categoria=13 THEN p.precio*o.cantidad ELSE 0 END) as Nuevo,
SUM(CASE WHEN c.id_categoria=14 THEN p.precio*o.cantidad ELSE 0 END) as CienciaFiccion,
SUM(CASE WHEN c.id_categoria=15 THEN p.precio*o.cantidad ELSE 0 END) as Deportes,
SUM(CASE WHEN c.id_categoria=16 THEN p.precio*o.cantidad ELSE 0 END) as Viajes
FROM orden o, producto p, categoria c, pais pa, cliente cl
where o.producto_id_producto = p.id_producto
and p.categoria_id_categoria = c.id_categoria
and o.cliente_id_cliente = cl.id_cliente
and cl.pais_id_pais = pa.id_pais
)

select * from orden;
select * from producto;
select * from vendedor;
select * from cliente;
select * from pais;
select * from categoria;

delete from orden;
delete from producto;
delete from vendedor;
delete from cliente;
delete from pais;
delete from categoria;

truncate categoria cascade;
truncate pais cascade;
truncate cliente cascade;
truncate vendedor cascade;
truncate producto cascade;
truncate orden cascade;
