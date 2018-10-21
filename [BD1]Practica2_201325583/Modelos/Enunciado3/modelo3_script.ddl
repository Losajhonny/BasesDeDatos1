create table ADN (
    codigo      integer not null,
    tipo_sangre varchar(5) not null,
    descripcion varchar(100),
    constraint ADN_PK primary key (codigo)
);

create table CARACTERISTICA (
    correlativo                integer not null,
    nombre                     varchar(30) not null,
    CARACTERISTICA_correlativo integer,
    constraint CARACTERISTICA_PK primary key (correlativo),
    constraint CARACT_CARACT_FK foreign key (CARACTERISTICA_correlativo) references CARACTERISTICA (correlativo)
);

create table DENUNCIA (
    fecha              date not null,
    fecha_desaparecido date not null,
    VICTIMA_codigo     integer not null,
    DENUNCIANTE_cui    integer not null,
    constraint DENUNCIA_PK primary key (DENUNCIANTE_cui, VICTIMA_codigo),
    constraint DENUNCIA_DENUNCIANTE_FK foreign key (DENUNCIANTE_cui) references DENUNCIANTE (cui),
    constraint DENUNCIA_VICTIMA_FK foreign key (VICTIMA_codigo) references VICTIMA (codigo)
);

create table DENUNCIANTE (
    cui        integer not null,
    nombre     varchar(50) not null,
    ADN_codigo integer not null,
    constraint DENUNCIANTE_PK primary key (cui),
    constraint DENUNCIANTE_ADN_FK foreign key (ADN_codigo) references ADN (codigo)
);

create table TIPO_UBICACION (
    codigo integer not null,
    nombre varchar(30) constraint TIPO_UBICACION_nombre_UN unique not null,
    constraint TIPO_UBICACION_PK primary key (codigo)
);

create table TIPO_VICTIMA (
    codigo integer not null,
    nombre varchar(30) constraint TIPO_VICTIMA_nombre_UN unique not null,
    constraint TIPO_VICTIMA_PK primary key (codigo)
);

create table UBICACION (
    codigo                integer not null,
    nombre                varchar(30) not null,
    UBICACION_codigo      integer,
    VICTIMA_codigo        integer not null,
    TIPO_UBICACION_codigo integer not null,
    constraint UBICACION_PK primary key (codigo),
    constraint UBICACION_TIPO_UBICACION_FK foreign key (TIPO_UBICACION_codigo) references TIPO_UBICACION (codigo),
    constraint UBICACION_UBICACION_FK foreign key (UBICACION_codigo) references UBICACION (codigo),
    constraint UBICACION_VICTIMA_FK foreign key (VICTIMA_codigo) references VICTIMA (codigo)
);

create table VICTIMA (
    codigo              integer not null,
    nombre              varchar(50) not null,
    apellido            varchar(50) not null,
    fecha_nac           date not null,
    telefono            varchar(10),
    profesion           varchar(30),
    TIPO_VICTIMA_codigo integer not null,
    ADN_codigo          integer not null,
    constraint VICTIMA_PK primary key (codigo),
    constraint VICTIMA_ADN_FK foreign key (ADN_codigo) references ADN (codigo),
    constraint VICTIMA_TIPO_VICTIMA_FK foreign key (TIPO_VICTIMA_codigo) references TIPO_VICTIMA (codigo)
);

create table VICT_CARACT (
    VICTIMA_codigo             integer not null,
    CARACTERISTICA_correlativo integer not null,
    constraint VICT_CARACT_CARACTERISTICA_FK foreign key (CARACTERISTICA_correlativo) references CARACTERISTICA (correlativo),
    constraint VICT_CARACT_VICTIMA_FK foreign key (VICTIMA_codigo) references VICTIMA (codigo)
);
