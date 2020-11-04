-- MySQL Workbench Synchronization (ARRUMADO)
-- Generated: 2020-10-26 17:17
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: llayl

drop database if exists biblioteca;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS biblioteca
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci;

use biblioteca;

CREATE TABLE IF NOT EXISTS `Usuarios` (
  `idUsuario` INT(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `idade` INT(11) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `dataCadastro` DATE NOT NULL,
  PRIMARY KEY (`idUsuario`)
  );

CREATE TABLE IF NOT EXISTS `Alugueis` (
  `idAluguel` INT(11) NOT NULL,
  `dataEmprestimo` DATE NOT NULL,
  `dataDevolucao` DATE,
  `Usuarios_idUsuario` INT(11) NOT NULL,
  `Livros_idLivro` INT(11) NOT NULL,
  PRIMARY KEY (`idAluguel`),
  INDEX `fk_Alugueis_Usuarios1_idx` (`Usuarios_idUsuario` ASC) ,
  INDEX `fk_Alugueis_Livros1_idx` (`Livros_idLivro` ASC) ,
  CONSTRAINT `fk_Alugueis_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuario`)
    REFERENCES `biblioteca`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alugueis_Livros1`
    FOREIGN KEY (`Livros_idLivro`)
    REFERENCES `biblioteca`.`Livros` (`idLivro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `biblioteca`.`Livros` (
  `idLivro` INT(11) NOT NULL,
  `titulo` VARCHAR(50) NOT NULL,
  `qtdPaginas` INT(11) NOT NULL,
  `numeroEdicao` INT(11) NOT NULL,
  `anoPublicado` YEAR NOT NULL,
  `locallizacao` VARCHAR(30) NOT NULL,
  `Escritores_idEscritor` INT(11) NOT NULL,
  PRIMARY KEY (`idLivro`),
  INDEX `fk_Livros_Escritores1_idx` (`Escritores_idEscritor` ASC) ,
  CONSTRAINT `fk_Livros_Escritores1`
    FOREIGN KEY (`Escritores_idEscritor`)
    REFERENCES `biblioteca`.`Escritores` (`idEscritor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `biblioteca`.`Escritores` (
  `idEscritor` INT(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `Editoras_idEditora` INT(11) NOT NULL,
  PRIMARY KEY (`idEscritor`),
  INDEX `fk_Escritores_Editoras1_idx` (`Editoras_idEditora` ASC) ,
  CONSTRAINT `fk_Escritores_Editoras1`
    FOREIGN KEY (`Editoras_idEditora`)
    REFERENCES `biblioteca`.`Editoras` (`idEditora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `biblioteca`.`Editoras` (
  `idEditora` INT(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `anoFundacao` YEAR NULL DEFAULT NULL,
  PRIMARY KEY (`idEditora`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `biblioteca`.`Categorias` (
  `idCategoria` INT(11) NOT NULL,
  `genero` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `biblioteca`.`Bibliotecarios` (
  `idBibliotecário` INT(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `Livros_idLivro` INT(11) NOT NULL,
  PRIMARY KEY (`idBibliotecário`),
  INDEX `fk_Bibliotecários_Livros1_idx` (`Livros_idLivro` ASC) ,
  CONSTRAINT `fk_Bibliotecários_Livros1`
    FOREIGN KEY (`Livros_idLivro`)
    REFERENCES `biblioteca`.`Livros` (`idLivro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `biblioteca`.`Categorias_has_Livros` (
  `Categorias_idCategoria` INT(11) NOT NULL,
  `Livros_idLivro` INT(11) NOT NULL,
  PRIMARY KEY (`Categorias_idCategoria`, `Livros_idLivro`),
  INDEX `fk_Categorias_has_Livros_Livros1_idx` (`Livros_idLivro` ASC) ,
  INDEX `fk_Categorias_has_Livros_Categorias1_idx` (`Categorias_idCategoria` ASC) ,
  CONSTRAINT `fk_Categorias_has_Livros_Categorias1`
    FOREIGN KEY (`Categorias_idCategoria`)
    REFERENCES `biblioteca`.`Categorias` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Categorias_has_Livros_Livros1`
    FOREIGN KEY (`Livros_idLivro`)
    REFERENCES `biblioteca`.`Livros` (`idLivro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `biblioteca`.`Usuarios_has_Bibliotecarios` (
  `Usuarios_idUsuario` INT(11) NOT NULL,
  `Bibliotecários_idBibliotecário` INT(11) NOT NULL,
  PRIMARY KEY (`Usuarios_idUsuario`, `Bibliotecários_idBibliotecário`),
  INDEX `fk_Usuarios_has_Bibliotecários_Bibliotecários1_idx` (`Bibliotecários_idBibliotecário` ASC) ,
  INDEX `fk_Usuarios_has_Bibliotecários_Usuarios1_idx` (`Usuarios_idUsuario` ASC) ,
  CONSTRAINT `fk_Usuarios_has_Bibliotecários_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuario`)
    REFERENCES `biblioteca`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_has_Bibliotecários_Bibliotecários1`
    FOREIGN KEY (`Bibliotecários_idBibliotecário`)
    REFERENCES `biblioteca`.`Bibliotecarios` (`idBibliotecário`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

insert into Usuarios values
(1 , "Joao", 14, 12345678932, 20190414), 
(2 , "Maria", 15, 27032009125, 20190515), 
(3 , "Julia", 17, 18853488369, 20190616), 
(4 , "Samara", 19, 14591722880, 20190717), 
(5 , "Ricardo", 22, 41885478287, 20190818), 
(720, "Ana" , 24, 13231000134, 20150806),
(870, "Flavio", 22, 53412693879, 20010821),
(110, "Jorge" , 30, 1451276498349, 20201027),
(222, "Lucia" , 21, 31521393488, 20090805),
(830, "Mauricio" , 31, 81698574656, 19930403),
(130, "Edmar" , 37, 34632842349, 20071201),
(410, "Rodolfo" , 38, 83512823469, 20170430),
(20, "Beth" , 25, 48512673268, 20090218),
(157, "Paulo" , 67, 28482233242, 20190223),
(180, "Livio", 30, 73657123474,20140627),
(260, "Susana", 34, 17635712329, 20050310),
(290, "Renato", 32, 27657112314, 20181220),
(390, "Sebastiao", 33,  321765472133, 20091007),
(234, "Jose", 28, 76357612323, 20020923),
(6 , "Pedro", 16, 38049467763, 20190914);


insert into Alugueis values
(1 , 20190914, 20191014, 6, 1),
(121,20180430,20180530,410,25), 
(97,20200806, 20200906,720,31),
(101,20150821,NULL,720,78),
(137,20200101,NULL,720,25),
(148,20200821,20200921,720,22),
(189,20150101, NULL,870,30),
(104,20030712, NULL,110,53),
(2 , 20190818, 20190915, 5, 2), 
(3 , 20190717, 20190816, 4, 3), 
(4 , 20190616, 20190717, 3, 4), 
(5 , 20190515, 20190618, 2, 5), 
(6 ,  20190414, 20190514, 1, 6);

insert into Livros values
(1 , "Maze Runner: Correr ou Morrer", 426 , 1, 2010, "Bloco A", 1), 
(2 , "Harry Potter e a Pedra Filosofal", 264, 1, 2000, "Bloco B", 2), 
(3 , "Ladrão de olhos", 424  , 1, 2012, "Bloco C", 3), 
(4 , "Percy Jackson e o Ladrão de Raios", 400, 1, 2008, "Bloco D", 4), 
(5 , "O herói perdido", 440, 1, 2011, "Bloco E", 4), 
(6 , "A Droga da Obediência",  192 , 5, 2014, "Bloco F", 5),
(25, "Corte de Espinhos e Rosas", "434",1,2015 , "Bloco A", 6),
(31, "Corte de Névoa e Fúria", "885",1, 2016, "Bloco A", 6),
(78, "Corte de Asas e Ruína", "705", 1, 2017, "Bloco A", 6),
(22, "Cidade dos Ossos", "462", 51, 2007, "Bloco D", 7),
(30, "Cidade das Cinzas", "406", 20, 2008, "Bloco D", 7),
(53, "Cidade de Vidro", "476", 14, 2009, "Bloco D", 7),
(13, "Cidade dos Anjos Caídos", "432", 13, 2011, "Bloco D", 7),
(45, "Cidade das Almas Perdidas", "434", 12, 2014, "Bloco D", 7),
(87, "Cidade do Fogo Celestial", "532", 10, 2014, "Bloco D", 7),
(77, "Eu sou o Número Quatro", "350",1, 2011, "Bloco C", 8);

insert into editoras values
(1, "Dell Publishing", 1921),
(2, "Bloomsbury", 1986),
(3, "Leya", 2007),
(4, "Disney Publishing Worldwide", 1991),
(6, "Moderna", 1968),
(7, "Galera", 2007),
(8, "Intrínseca", 2003);

insert into escritores values
(1, "James Dashner", 1),
(2, "J. K. Rowling", 2),
(3, "Jonathan Auxier", 3),
(4, "Rick Riordan", 4),
(5, "Pedro Bandeira", 5),
(6, "Sarah J. Maas", 7),
(7, "Cassandra Clare", 7),
(8, "Pittacus Lore", 8);

insert into bibliotecarios values
(1, "Joao", 1),
(2, "Lucas", 2),
(3, "Gabriel", 3),
(4, "Carla", 4), 
(5, "Flávia", 5),
(6, "Luana", 6),
(7, "Ana", 25),
(8, "Layla", 31),
(9, "Philippe", 78),
(10, "Raposo", 22),
(11, "Matheus", 30),
(12, "Christian", 53),
(13, "Luiz", 13),
(14, "Thiago", 45),
(15, "Letícia", 87),
(16, "Gabriel Souza", 77);

insert into categorias values
(1, "Terror"),
(2, "Romance"),
(3, "Suspense"),
(4, "Comédia"),
(5, "Ficção"),
(6, "Aventura");

insert into categorias_has_livros values
(6, 1),
(5, 2),
(5, 3),
(3, 4),
(4, 5),
(5, 6),
(2,25),
(5,25),
(6,25),
(2,31),
(5,31),
(6,31),
(2,78),
(5,78),
(6,78),
(6,22),
(6,30),
(6,53),
(6,13),
(6,45),
(6,87),
(5,77);

insert into usuarios_has_bibliotecarios values
(1, 6),
(2, 5),
(3, 1),
(4, 2),
(5, 4),
(720, 7),
(870, 8),
(110, 9),
(222, 10),
(830, 11),
(130, 12),
(410, 13),
(20, 14),
(157, 15),
(180, 16),
(260, 15),
(290, 14),
(390, 13),
(234, 12),
(6, 4);

select * from usuarios order by nome; -- ver a tabela de usuarios ordenada por nome dos usuarios  

select nome from bibliotecarios nome where nome like 'Ga%'; -- ver nomes de bibliotecarios que começam com Ga

select * from bibliotecarios; -- ver toda a tabela 

select count(idUsuario) as qtdClientes from usuarios; -- quantidade de usuarios cadastrados no sistema 

select idade from usuarios where idade <18; -- usuarios menores de idade

SELECT Usuarios_idUsuario  -- saber quem alugou o livro do rick riordan
from alugueis 
inner join usuarios on usuarios.idUsuario = alugueis.Usuarios_idUsuario 
inner join livros on alugueis.Livros_idLivro = livros.idLivro 
inner join escritores on escritores.idEscritor = livros.Escritores_idEscritor 
where escritores.idEscritor = 4;

select count(qtdPaginas) as qtdPaginasMaior from livros where qtdPaginas > 400; -- quantidade de livros com mais de 400 paginas

select count(Usuarios_idUsuario) from alugueis where dataDevolucao is null; -- quantidade de usuarios que nao devolveram ainda os livros

select idLivro from livros where numeroEdicao > 3; -- ver quais livros tem mais de 3 edições 

select nome from bibliotecarios where Livros_idLivro = 6; -- ver qual bibliotecario cadastrou um livro especifico

select idLivro,titulo FROM livros where idLivro IN (SELECT Livros_idLivro FROM alugueis inner join livros on livros.idLivro = alugueis.Livros_idLivro where livros.idLivro <= 30) ORDER BY idLivro;

