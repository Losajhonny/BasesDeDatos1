CREATE TABLE CATEGORIA (
    id_categoria    NUMERIC NOT NULL ,
    nombreCategoria VARCHAR (50) NOT NULL ,
    CONSTRAINT CATEGORIA_PK PRIMARY KEY ( id_categoria )
);

CREATE TABLE CLIENTE (
    id_cliente     NUMERIC NOT NULL ,
    nombre         VARCHAR (50) NOT NULL ,
    apellido       VARCHAR (50) NOT NULL ,
    direccion      VARCHAR (100) NOT NULL ,
    telefono       NUMERIC NOT NULL ,
    tarjetaCredito NUMERIC NOT NULL ,
    edad           NUMERIC NOT NULL ,
    salario        NUMERIC (10,2) NOT NULL ,
    genero         CHAR (1) NOT NULL ,
    PAIS_id_pais   NUMERIC NOT NULL ,
    CONSTRAINT CLIENTE_CH CHECK ( genero = 'M' or genero = 'F' ) ,
    CONSTRAINT CLIENTE_PK PRIMARY KEY ( id_cliente ) ,
    CONSTRAINT CLIENTE_PAIS_FK FOREIGN KEY ( PAIS_id_pais ) REFERENCES PAIS ( id_pais )
);

CREATE TABLE ORDEN (
    id_orden             NUMERIC NOT NULL ,
    linea_orden          NUMERIC NOT NULL ,
    PRODUCTO_id_producto NUMERIC NOT NULL ,
    VENDEDOR_id_vendedor NUMERIC NOT NULL ,
    cantidad             NUMERIC NOT NULL ,
    fecha_orden          DATE NOT NULL ,
    CLIENTE_id_cliente   NUMERIC NOT NULL ,
    CONSTRAINT ORDEN_PK PRIMARY KEY ( id_orden, linea_orden ) ,
    CONSTRAINT ORDEN_CLIENTE_FK FOREIGN KEY ( CLIENTE_id_cliente ) REFERENCES CLIENTE ( id_cliente ) ,
    CONSTRAINT ORDEN_PRODUCTO_FK FOREIGN KEY ( PRODUCTO_id_producto ) REFERENCES PRODUCTO ( id_producto ) ,
    CONSTRAINT ORDEN_VENDEDOR_FK FOREIGN KEY ( VENDEDOR_id_vendedor ) REFERENCES VENDEDOR ( id_vendedor )
);

CREATE TABLE PAIS (
    id_pais    NUMERIC NOT NULL ,
    nombrePais VARCHAR (50) NOT NULL ,
    CONSTRAINT PAIS_PK PRIMARY KEY ( id_pais )
);

CREATE TABLE PRODUCTO (
    id_producto            NUMERIC NOT NULL ,
    nombreProducto         VARCHAR (50) NOT NULL ,
    precio                 NUMERIC (10,2) NOT NULL ,
    CATEGORIA_id_categoria NUMERIC NOT NULL ,
    CONSTRAINT PRODUCTO_PK PRIMARY KEY ( id_producto ) ,
    CONSTRAINT PRODUCTO_CATEGORIA_FK FOREIGN KEY ( CATEGORIA_id_categoria ) REFERENCES CATEGORIA ( id_categoria )
);

CREATE TABLE VENDEDOR (
    id_vendedor    NUMERIC NOT NULL ,
    nombreVendedor VARCHAR (50) NOT NULL ,
    CONSTRAINT VENDEDOR_PK PRIMARY KEY ( id_vendedor )
);