-- LISTA DE EXERCÍCIOS - SQL

-- Listar todos os produtos com as respectivas descrições, unidades e valores unitários
select descricao, unidade, valor_unitario from produto; 
-- Listar todo o conteúdo de vendedor, obtendo o seguinte resultado, usando *:
select * from vendedor;
-- Listar da tabela CLIENTE o CNPJ, o nome do cliente e seu endereço, obtendo o seguinte resultado:
select cnpj, nome, endereco from cliente;
-- Listar todas as cidades em que há clientes
select distinct cidade from cliente;
-- Listar todas as cidades e estados em que há clientes
select distinct cidade, uf from cliente;
-- Quais são os clientes que moram em Niterói?
select * from cliente where cidade = 'Niterói';
-- Listar os produtos que tenham unidade igual a ‘M’ e valor unitário igual a R$ 1,05 da tabela produto:
select * from produto where unidade = 'M' and valor_unitario = 1.05;
-- Listar o código, a descrição e o valor unitario dos produtos que tenham o valor unitário na faixa de R$ 0,32 até R$ 2,00:
select idProduto, descricao, valor_unitario from produto where valor_unitario >= 0.32 and valor_unitario <= 2.00;
-- Listar oo código, a descrição e o valor unitario dos produtos que NÃO tenham o valor unitário na faixa de R$ 0,32 até R$ 2,00:
select idProduto, descricao, valor_unitario from produto where valor_unitario <= 0.32 and valor_unitario >= 2.00;
select idProduto, descricao, valor_unitario from produto where valor_unitario not between 0.32 and 2.00;
-- Listar os nomes entre Ana e Jorge
select * from cliente where nome between 'Ana' and 'Jorge'; 
-- Listar Listar os vendedores com faixas de comissão A ou B
select * from vendedor where comissao = 'A' or comissao = 'B';
select * from vendedor where comissao in ('A', 'b');
-- Listar todos os clientes SEM Inscrição Estadual (IE)
select * from cliente where ie is null;
-- Listar todos os clientes COM Inscrição Estadual (IE)
select * from cliente where ie is not null;
-- Listar apenas os dois primeiros vendedores
select nome from vendedor limit 2;
-- Listar todos os produtos que tenham o seu nome começando por Q:
select descricao from produto where Descricao like'Q%';
-- Listar os vendedores que não começam por ‘Jo’:
select nome from vendedor where nome not like 'Jo%';
-- Listar todos os produtos cujo nome termina com 's';
select descricao from produto where descricao like '%s';
-- Listar os produtos que contenham as letras "inh"
select descricao from produto where descricao like'%inh%';
-- Listar os chocolates e valores 
select descricao, valor_unitario from produto where descricao like '%chocolate%';
-- Listar os vendedores cuja segunda letra do nome seja 'a'
select nome from vendedor where nome like '_a%';


-- ORDER BY
-- Listar todos os vendedores ordenados por nome
select * from vendedor order by nome;
-- Listar todos os vendedores ordenados por nome de forma descrescente
select * from vendedor order by nome desc;
-- Listar todos os vendedores ordenados por nome e salario 
select * from vendedor order by nome, salario;
-- Listar todos os clientes com seus estados, sendo que o estado deverá ser ordenado em ordem crescente e o nome por ordem descrescente[
select * from cliente order by uf asc, nome desc;
-- Listar todos os vendedores que ganham MENOS de 1000 reais e apresentar em ordem crescente
select nome, salario from vendedor where salario<1000 order by salario asc;
-- Listar os vendedores que não começam por ‘Jo’ e apresentar ordenado de forma descrescente
select * from vendedor where nome not like 'Jo%' order by nome desc;


-- FUNÇÕES COUNT(), AVG(), SUM(), MIN() e MAX()
-- Informe quantos clientes foram cadastrados
select count(id) as qtdClient from cliente;
-- Informe quantos produtos tem valor unitário abaixo de 0.50 centavos
select count(idProduto) as qtdProduto from produto where valor_unitario < 0.5;
-- Informe a média de salario dos vendedores
select avg(salario) from vendedor;
-- Informe a média de valores unitarios dos produtos vendidos a M
select avg(valor_unitario) from produto where unidade = 'M';  
-- Somar o valor de todos os salários
select sum(salario) from vendedor;
-- Somar o valor dos salarios da comissão A
select sum(salario) from vendedor where comissao = 'A';
-- Somar a quantidade de itens de pedidos
select sum(quantidade) from itens_pedido;
-- Informe o menor salario do vendedores
select min(salario) from vendedor;
-- Informe o maior salario do vendedores
select max(salario) from vendedor;
-- Informe o maior salario do vendedores da faixa de comissão B
select max(salario) from vendedor where comissao = 'B';
-- Listar os nomes entre Ana e Jorge, ordenado de forma descrescente
select * from cliente where nome between 'Ana' and 'Jorge' order by nome desc;

 
-- GROUP BY
-- Informe o número de clientes por Estado
-- Informe a média salarial por faixa de comissão
-- Informe a média salarial por faixa de comissão ordenado de forma descrescente por valor


-- HAVING
-- Informe a média salarial por faixa de comissão apenas das faixas com ganho acima de 2000 
-- Informe a média salarial por faixa de comissão apenas das faixas com ganho acima de 2000 ordenado de forma descrescente por valor