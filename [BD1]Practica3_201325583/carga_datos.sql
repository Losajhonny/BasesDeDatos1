-- CARGA DE DATOS DESDE EXCEL

copy categoria (id_categoria, nombrecategoria)
from 'C:/Users/jhonny/Desktop/Practica3/categoria.csv' delimiter ';' csv header;

copy pais (id_pais, nombrepais)
from 'C:/Users/jhonny/Desktop/Practica3/pais.csv' delimiter ';' csv header;

copy cliente (id_cliente, nombre, apellido, direccion, telefono, tarjetacredito, edad, salario, genero, pais_id_pais)
from 'C:/Users/jhonny/Desktop/Practica3/cliente.csv' delimiter ';' csv header;

copy vendedor (id_vendedor, nombrevendedor)
from 'C:/Users/jhonny/Desktop/Practica3/vendedor.csv' delimiter ';' csv header;

copy producto (id_producto, nombreproducto, precio, categoria_id_categoria)
from 'C:/Users/jhonny/Desktop/Practica3/producto.csv' delimiter ';' csv header;

copy orden (id_orden, linea_orden, producto_id_producto, vendedor_id_vendedor, cantidad, fecha_orden, cliente_id_cliente)
from 'C:/Users/jhonny/Desktop/Practica3/orden.csv' delimiter ';' csv header;