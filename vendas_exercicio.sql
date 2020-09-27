create database if not exists vendas; -- criar database

drop database if exists vendas; -- excluir database

create database if not exists vendas
default character set utf8 -- uft8 (8-bit Unicode Transformation Format - Pode representar qualquer caracter universal padrão do Unicode, sendo também compatível com o ASCII)
default collate utf8_general_ci;

use vendas;-- selecionar banco de dados
/*
Outros comandos:
show database; -- lista os banco de dados criados
show tables;  -- lista as tabelas do database
describe ou desc "nome da tabela"; -- descreve os itens da tabela
*/

CREATE TABLE IF NOT EXISTS clientes ( -- criar tabela
    id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(200),
    cidade VARCHAR(50),
    cep CHAR(8),
    uf CHAR(2),
    cnpj VARCHAR(20) NOT NULL UNIQUE,
    ie varchar (30),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS vendedores (
    id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    salario DECIMAL(7 , 2 ) NOT NULL,
    faixa_comissao ENUM('A', 'B', 'C'),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS pedidos (
    id INT NOT NULL,
    prazo_entrega INT UNSIGNED NOT NULL,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_cliente)
        REFERENCES clientes (id),
    FOREIGN KEY (id_vendedor)
        REFERENCES vendedores (id)
);

CREATE TABLE IF NOT EXISTS produtos (
    id INT NOT NULL,
    unidade VARCHAR(5) NOT NULL,
    descricao VARCHAR(100) NOT NULL UNIQUE,
    valor_unitario DECIMAL(4 , 2 ),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS itens_pedido2 (
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_pedido , id_produto),
    FOREIGN KEY (id_pedido)
        REFERENCES pedidos (id),
    FOREIGN KEY (id_produto)
        REFERENCES produtos (id)
);

CREATE TABLE tabela_para_excluir (
    id INT
);

insert into tabela_para_excluir values -- inserção de valores
(1),
(2),
(3);

SELECT *
FROM tabela_para_excluir; -- apresenta a tabela

TRUNCATE tabela_para_excluir;-- excluir somente os registros

SELECT *
FROM tabela_para_excluir; -- apresenta a tabela

DROP TABLE tabela_para_excluir; -- comando para excluir tabela

ALTER TABLE itens_pedido2 RENAME itens_pedido; -- alterar nome da tabela

INSERT INTO clientes (nome, cnpj) VALUES ('Teste', '12345678910');-- inserir valores na tabela (insere sem o id (erro) que será deletado abaixo)

SELECT *
FROM clientes;-- selecionar todos os registros da tabela
    
DELETE FROM clientes 
WHERE id = 0;

SELECT *
FROM clientes;-- selecionar todos os registros da tabela

insert into clientes (id, nome, cnpj) values ('1','Teste', '12345678910'); -- inserção correta 

SELECT *
FROM clientes;-- selecionar todos os registros da tabela

insert into clientes values  -- inserção de varios valores (todas as colunas. Também é possível realizar várias inserções considerando apenas algumas colunas)
('2', 'Ana', 'Rua A n. 2034', 'Brasilia', '24358310', 'DF', '11111', ''),
('3', 'Flavio', 'Av. Pres. Vagas 10', 'São Paulo', '22763931', 'SP', '222', '123');

desc clientes;

insert into clientes values 
('4', 'Ana', 'Rua 17 n. 19', 'Niteroi', '24358310', 'RJ', '44444', NULL);

SELECT *
FROM clientes
WHERE ie = '';

SELECT *
FROM clientes
WHERE ie is null;

insert into vendedores values
('209', 'José', '1800','C'),
('111', 'Carlos', '2490','A');

select * from vendedores;

insert into pedidos values
('121', '20','870','209'),
('97', '20','720','209');

insert into produtos values -- obs.: os valores decimais devem ser inseridos com '.' não ','. Os valores não serão inseridos. 
('25', 'kg', 'Queijo', '0,97'),
('31', 'bar', 'Chocolate', '0,87');

select * from produtos;

insert into itens_pedido values 
('121','25','10'),
('121','31','35'),
('97','25','100');

UPDATE produtos 
SET valor_unitario = 0.97, descricao = 'presunto'
WHERE id = 25;

UPDATE produtos 
SET valor_unitario = 0.87
where id = 31;
-- Para mudar esta "preferencia" acesse: Edit -> Preferences - SQL Editor - Safe Updates

DELETE FROM clientes 
WHERE nome = 'Ana';
-- não se permite a exclusão de linhas vinculadas a outras tabelas.

-- INDEX
/*Index trazem mais agilidade a consultas.
Há dois tipos de index: clusterizados e não clusterizados. 
Clusterizados: Unique, Primary Key e Foreign Key são automaticamente criadas como index
Classifica as linhas de acordo com o index. 
Não clusterizados: criados nas tabelas e não altera a ordem dos objetos mas cria  um o
outro objeto que facilita a busca. Pode se ter vários index. 
OBS.: escolher os campos mais acessados para busca e menos acessado para alterações.
*/
show index from clientes; -- mostra os index da tabela
 
explain select * from clientes -- explain mostra como o select está sendo realizado
where nome = 'Ana';

create index index_nome -- cria o index
on clientes (nome);

explain select * from clientes
where nome = 'Ana';

drop index index_nome on clientes;
/* OUTROS COMANDOS
ALTER TABLE table_name
DROP INDEX index_name;

ALTER TABLE table_name
ADD INDEX index_name;
*/


