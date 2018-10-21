create table AREA (
    codigo integer not null,
    nombre varchar(30) constraint AREA_nombre_UN unique not null,
    constraint AREA_PK primary key (codigo)
);

create table CLIENTE (
    cui       integer not null,
    nombre    varchar(50) not null,
    apellido  varchar(50) not null,
    fecha_nac date not null,
    direccion varchar(100),
    correo    varchar(100),
    constraint CLIENTE_PK primary key (cui)
);

create table DEPTO (
    codigo      integer not null,
    nombre      varchar(30) constraint DEPTO_nombre_UN unique not null,
    AREA_codigo integer not null,
    constraint DEPTO_PK primary key (codigo),
    constraint DEPTO_AREA_FK foreign key (AREA_codigo) references AREA (codigo)
);

create table EMPLEADO (
    dpi          integer not null,
    nombre       varchar(50) not null,
    apellido     varchar(50) not null,
    fecha_nac    date not null,
    fecha_ini    date not null,
    fecha_fin    date,
    telefono     varchar(10) not null,
    direccion    varchar(100),
    salario      number(10,2) not null,
    puesto       varchar(30) not null,
    EMPLEADO_dpi integer,
    DEPTO_codigo integer not null,
    constraint EMPLEADO_PK primary key (dpi),
    constraint EMPLEADO_EMPLEADO_FK foreign key (EMPLEADO_dpi) references EMPLEADO (dpi),
    constraint EMPLEADO_DEPTO_FK foreign key (DEPTO_codigo) references DEPTO (codigo)
);

create table FUNCION (
    codigo       integer not null ,
    nombre       varchar (30) not null ,
    descripcion  varchar (100) ,
    DEPTO_codigo integer not null,
    constraint FUNCION_PK primary key (codigo),
    constraint FUNCION_DEPTO_FK foreign key (DEPTO_codigo) references DEPTO (codigo)
);

create table LLAMADA (
    nombre        varchar(50) not null,
    telefono      varchar(10) not null,
    fecha         date not null,
    hora          date not null,
    duracion      integer not null,
    EMPLEADO_dpi  integer not null,
    SEGURO_codigo integer not null,
    constraint LLAMADA_EMPLEADO_FK foreign key (EMPLEADO_dpi) references EMPLEADO (dpi),
    constraint LLAMADA_SEGURO_FK foreign key (SEGURO_codigo) references SEGURO (codigo)
);

create table PAGO (
    correlativo   integer not null,
    tarifa        NUMBER(10,2) not null,
    mora          NUMBER(10,2),
    monto         NUMBER(10,2) not null,
    forma_pago    varchar(30) not null,
    fecha         date not null,
    POLIZA_codigo integer not null,
    EMPLEADO_dpi  integer not null,
    CLIENTE_cui   integer not null,
    constraint PAGO_PK primary key (correlativo),
    constraint PAGO_CLIENTE_FK foreign key (CLIENTE_cui) references CLIENTE (cui),
    constraint PAGO_EMPLEADO_FK foreign key (EMPLEADO_dpi) references EMPLEADO (dpi),
    constraint PAGO_POLIZA_FK foreign key (POLIZA_codigo) references POLIZA (codigo)
);

create table PAPELERIA (
    codigo        integer not null,
    nombre        varchar(30) constraint PAPELERIA_nombre_UN unique not null,
    descripcion   varchar(100),
    SEGURO_codigo integer not null,
    constraint PAPELERIA_PK primary key (codigo),
    constraint PAPELERIA_SEGURO_FK foreign key (SEGURO_codigo) references SEGURO (codigo)
);

create table POLIZA (
    codigo           integer not null,
    fecha_ini        date not null,
    fecha_fin        date not null,
    monto            NUMBER(10,2) not null,
    EMPLEADO_dpi     integer not null,
    SEGURO_codigo    integer not null,
    TIPO_PAGO_codigo integer not null,
    CLIENTE_cui      integer not null,
    constraint POLIZA_PK primary key (codigo),
    constraint POLIZA_CLIENTE_FK foreign key (CLIENTE_cui) references CLIENTE (cui),
    constraint POLIZA_EMPLEADO_FK foreign key (EMPLEADO_dpi) references EMPLEADO (dpi),
    constraint POLIZA_SEGURO_FK foreign key (SEGURO_codigo) references SEGURO (codigo),
    constraint POLIZA_TIPO_PAGO_FK foreign key (TIPO_PAGO_codigo) references TIPO_PAGO (codigo)
);

create table SEGURO (
    codigo integer not null,
    nombre varchar(30) constraint SEGURO_nombre_UN unique not null,
    constraint SEGURO_PK primary key (codigo)
);

create table TIPO_PAGO (
    codigo integer not null,
    nombre varchar(30) constraint TIPO_PAGO_nombre_UN unique not null,
    constraint TIPO_PAGO_PK primary key (codigo)
);
