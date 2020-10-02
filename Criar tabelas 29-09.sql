create database juncoes;

use juncoes;

create table ramo(
cd_ramo int,
ds_ramo varchar(50),
constraint PK_ramo primary key (cd_ramo));

create table tipo(
cd_tipo int,
ds_tipo varchar(50),
constraint PK_tipo primary key (cd_tipo));

create table municipio(
cd_municipio int,
nome varchar(50),
constraint PK_municipio primary key (cd_municipio));

create table assinante(
cd_assinante int,
nome varchar(50),
cd_ramo int,
cd_tipo int,
constraint PK_assinante primary key (cd_assinante),
constraint FK_assinante1 foreign key (cd_ramo) references ramo (cd_ramo),
constraint FK_assinante2 foreign key (cd_tipo) references tipo (cd_tipo));

create table endereco(
cd_endereco int,
rua varchar(50),
complemento varchar(50),
bairro varchar(50),
CEP varchar(50),
cd_assinante int,
cd_municipio int,
constraint PK_endereco primary key (cd_endereco),
constraint FK_end foreign key (cd_assinante) references assinante (cd_assinante),
constraint FK_end2 foreign key (cd_municipio) references municipio (cd_municipio));

create table telefone(
cd_fone int,
ddd varchar(3),
n_fone varchar(10),
cd_endereco int,
constraint PK_telefone primary key (cd_fone),
constraint FK_fone foreign key (cd_endereco) references endereco (cd_endereco));

insert into tipo values 
(1, 'PREMIUM'),
(2, 'BÁSICO'),
(3, 'GRÁTIS'),
(4, 'RESIDENCIAL');

insert into ramo values 
(1, 'INFORMÁTICA'),
(2, 'MEDICINA'),
(3, 'COMÉRCIO');

insert into municipio values 
(1, 'JOÃO CÂMARA'),
(2, 'CEARA MIRIM'),
(3, 'NATAL'),
(4, 'SÃO MIGUEL'),
(5, 'PELOTAS');

INSERT INTO assinante VALUES 
(1, 'JOÃO', 1, 2),	
(2, 'JOSÉ', 2, 1),	
(3, 'MARIA', 2, 1),	
(4, 'MARIA BETÂNIA', 3, 3),	
(5, 'JOANA', 1, 1);	

INSERT INTO endereco VALUES 
(1, 'RUA ABC', 'APTO 201', 'CEILANDIA', '75120-120', 1, 1),
(2, 'RUA VILA GÓIS', 'CASA 2', 'ASA NORTE', '87999-45', 1, 1),
(3, 'RUA JUNDIAI', 'APTO 1509', 'CENTRO', '76897-000', 2, 4),
(4, 'RUA ENGENHEIRO PORTELA', 'Q.2, L.4', 'CENTRO', '75345-098', 3, 5),
(5, 'RUA GERTULINO ARTIAGA', 'APTO 1', 'CENTRO', '44876-009', 4, 2),
(6, 'RUA 8', 'CASA 9', 'CENTRO', '999999-000', 5, 3);

INSERT INTO telefone VALUES 
(1, '84', '98765-0987', 1),
(2, '84', '98764-3243', 5),
(3, '84', '99872-9876', 6),
(4, '84', '99993-0987', 2);