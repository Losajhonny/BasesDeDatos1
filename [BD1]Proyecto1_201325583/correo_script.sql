create database proyecto1;
use proyecto1;


create table CUENTA (
	ident varchar(50) not null,
	nombre_completo varchar(100) not null,
	nombre_empresa varchar(50),
	dominio varchar(50) not null,
	pass varchar(50) not null,
	constraint PK_cuenta_ident primary key(ident)
);

create table CARPETA (
	codigo integer not null identity(1,1),
	nivel integer not null,
	nombre varchar(50) not null,
	tipo varchar(30) not null,
	CUENTA_ident varchar(50) not null,
	CARPETA_cod integer,
	constraint CH_carpeta_tipo check (tipo = 'privado' or tipo = 'publico'),
	constraint PK_carpeta_codigo primary key (codigo),
	constraint FK_carpeta_CUENTA_ident foreign key (CUENTA_ident) references CUENTA (ident),
	constraint FK_carpeta_CARPETA_codigo foreign key (CARPETA_cod) references CARPETA (codigo)
);

create table MENSAJE (
	codigo integer not null identity(1,1),
	texto varchar(256),
	asunto varchar(50),
	constraint PK_mensaje_codigo primary key (codigo)
);

create table ARCHIVO (
	codigo integer not null identity(1,1),
	ruta varchar(50) not null,
	MENSAJE_codigo integer not null,
	constraint PK_archivo_codigo primary key (codigo),
	constraint FK_archivo_MENSAJE_codigo foreign key (MENSAJE_codigo) references MENSAJE (codigo)
);

create table USRMSG (
	codigo integer not null identity(1,1),
	tipo_envio varchar(30) not null,
	fecha datetime not null,
	estado integer not null,
	MENSAJE_codigo integer not null,
	CARPETA_codigo integer not null,
	CUENTA_ident varchar(50),
	constraint CH_usrmsg_tipo check (tipo_envio = 'to' or tipo_envio = 'cc' or tipo_envio = 'bcc'),
	constraint CH_usrmsg_estado check (estado = 0 or estado = 1),
	constraint PK_usrmsg_codigo primary key (codigo),
	constraint FK_usrmsg_MENSAJE_codigo foreign key (MENSAJE_codigo) references MENSAJE (codigo),
	constraint FK_usrmsg_CARPETA_codigo foreign key (CARPETA_codigo) references CARPETA (codigo),
	constraint FK_usrmsg_CUENTA_ident foreign key (CUENTA_ident) references CUENTA (ident)
);

use proyecto1;

drop table USRMSG;
drop table ARCHIVO;
drop table MENSAJE;
drop table CARPETA;
drop table CUENTA;