create table AREA_LABOR (
    codigo integer not null,
    nombre varchar(30) constraint AREA_LABOR_nombre_UN unique not null,
    constraint AREA_LABOR_PK primary key (codigo)
);

create table ASISTENCIA (
    hora_entrada    date not null,
    hora_salida     date not null,
    tipo_asistencia varchar(30) not null,
    descripcion     varchar(100),
    JORNADA_codigo  integer not null,
    EMPLEADO_cui    integer not null,
    constraint ASISTENCIA_EMPLEADO_FK foreign key (EMPLEADO_cui) references EMPLEADO (cui),
    constraint ASISTENCIA_JORNADA_FK foreign key (JORNADA_codigo) references JORNADA (codigo)
);

create table AVION (
    codigo        integer not null,
    modelo        varchar(30),
    matricula     varchar(30) not null,
    num_primera   integer not null,
    num_economica integer not null,
    num_ejecutivo integer not null,
    altura_max    integer not null,
    constraint AVION_PK primary key (codigo)
);

create table BOLETO (
    num_boleto       integer not null,
    tipo_vuelo       varchar(30) not null,
    clase            varchar(30) not null,
    fecha_validacion date not null,
    fecha_viaje      date not null,
    fecha_regreso    date not null,
    PASAJERO_cui     integer not null,
    constraint BOLETO_PK primary key (num_boleto),
    constraint BOLETO_PASAJERO_FK foreign key (PASAJERO_cui) references PASAJERO (cui)
);

create table DESTINO (
    codigo         integer not null,
    nombre         varchar(30) not null,
    DESTINO_codigo integer,
    constraint DESTINO_PK primary key (codigo),
    constraint DESTINO_DESTINO_FK foreign key (DESTINO_codigo) references DESTINO (codigo)
);

create table EMPLEADO (
    cui                  integer not null,
    AREA_LABOR_codigo    integer not null,
    nombre               varchar(50) not null,
    apellido             varchar(50) not null,
    direccion            varchar(100),
    fecha_nac            date not null,
    correo               varchar(100),
    puesto               varchar(30) not null,
    fecha_ini            date not null,
    fecha_fin            date,
    TIPO_EMPLEADO_codigo integer not null,
    EMPLEADO_cui         integer,
    constraint EMPLEADO_PK primary key (cui),
    constraint EMPLEADO_AREA_LABOR_FK foreign key (AREA_LABOR_codigo) references AREA_LABOR (codigo),
    constraint EMPLEADO_TIPO_EMPLEADO_FK foreign key (TIPO_EMPLEADO_codigo) references TIPO_EMPLEADO (codigo),
    constraint EMPLEADO_EMPLEADO_FK foreign key (EMPLEADO_cui) references EMPLEADO (cui)
);

create table IDIOMA (
    codigo integer not null,
    nombre varchar(30) constraint IDIOMA_nombre_UN unique not null,
    constraint IDIOMA_PK primary key (codigo)
);

create table JORNADA (
    codigo   integer not null,
    nombre   varchar(30) constraint JORNADA_nombre_UN unique not null,
    hora_ini date not null,
    hora_fin date not null,
    constraint JORNADA_PK primary key (codigo)
);

create table LENGUAJE (
    IDIOMA_codigo integer not null,
    EMPLEADO_cui  integer not null,
    constraint LENGUAJE_PK primary key (IDIOMA_codigo, EMPLEADO_cui),
    constraint LENGUAJE_EMPLEADO_FK foreign key (EMPLEADO_cui) references EMPLEADO (cui),
    constraint LENGUAJE_IDIOMA_FK foreign key (IDIOMA_codigo) references IDIOMA (codigo)
);

create table MANTENIMIENTO (
    codigo           integer not null,
    fecha_programado date not null,
    AVION_codigo     integer not null,
    constraint MANTENIMIENTO_PK primary key (codigo),
    constraint MANTENIMIENTO_AVION_FK foreign key (AVION_codigo) references AVION (codigo)
);

create table MECANICO (
    hora                 date not null,
    observacion          varchar(100),
    EMPLEADO_cui         integer not null,
    MANTENIMIENTO_codigo integer not null,
    constraint MECANICO_PK primary key (EMPLEADO_cui, MANTENIMIENTO_codigo),
    constraint MECANICO_EMPLEADO_FK foreign key (EMPLEADO_cui) references EMPLEADO (cui),
    constraint MECANICO_MANTENIMIENTO_FK foreign key (MANTENIMIENTO_codigo) references MANTENIMIENTO (codigo)
);

create table PAGO (
    correlativo       integer not null,
    num_tarjeta       integer,
    tipo_pago         varchar(30) not null,
    monto             NUMBER (10,2) not null,
    PASAJERO_cui      integer not null,
    BOLETO_num_boleto integer not null,
    constraint PAGO_PK primary key (correlativo),
    constraint PAGO_BOLETO_FK foreign key (BOLETO_num_boleto) references BOLETO (num_boleto),
    constraint PAGO_PASAJERO_FK foreign key (PASAJERO_cui) references PASAJERO (cui)
);

create table PASAJERO (
    cui           integer not null,
    nombre        varchar(50) not null,
    apellido      varchar(50) not null,
    fecha_nac     date not null,
    correo        varchar(100),
    direccion     varchar(100),
    telefono      varchar(10) not null,
    codigo_postal integer not null,
    num_pasaporte integer constraint Pa_num_pasa_un unique not null,
    constraint PASAJERO_PK primary key (cui)
);

create table TIPO_EMPLEADO (
    codigo integer not null,
    nombre varchar(30) constraint TIPO_EMPLEADO__UN unique not null,
    constraint TIPO_EMPLEADO_PK primary key (codigo)
);

create table TRIPULACION (
    EMPLEADO_cui   integer not null,
    VIAJE_no_vuelo integer not null,
    constraint TRIPULACION_PK primary key (EMPLEADO_cui, VIAJE_no_vuelo),
    constraint TRIPULACION_EMPLEADO_FK foreign key (EMPLEADO_cui) references EMPLEADO (cui),
    constraint TRIPULACION_VIAJE_FK foreign key (VIAJE_no_vuelo) references VIAJE (no_vuelo)
);

create table VIAJE (
    no_vuelo      integer not null,
    no_galones    integer not null,
    distancia_max integer,
    fecha_despegue    date not null,
    fecha_aterrizaje  date,
    AVION_codigo  integer not null,
    constraint VIAJE_PK primary key (no_vuelo),
    constraint VIAJE_AVION_FK foreign key (AVION_codigo) references AVION (codigo)
);

create table VUELO (
    VIAJE_no_vuelo    integer not null,
    BOLETO_num_boleto integer not null,
    DESTINO_codigo    integer not null,
    constraint VUELO_PK primary key (VIAJE_no_vuelo, BOLETO_num_boleto, DESTINO_codigo)
    constraint VUELO_BOLETO_FK foreign key (BOLETO_num_boleto) references BOLETO (num_boleto),
    constraint VUELO_DESTINO_FK foreign key (DESTINO_codigo) references DESTINO (codigo),
    constraint VUELO_VIAJE_FK foreign key (VIAJE_no_vuelo) references VIAJE (no_vuelo)
);
