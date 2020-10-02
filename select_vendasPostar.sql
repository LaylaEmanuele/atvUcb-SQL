-- Listar todos os produtos com as respectivas descrições, unidades e valores unitários, obtendo o seguinte resultado:
SELECT descricao, unidade, valor_unitario FROM produtos;
-- Listar todo o conteúdo de vendedor, obtendo o seguinte resultado, usando *:
SELECT * FROM vendedores;
-- Listar da tabela CLIENTE o CNPJ, o nome do cliente e seu endereço, obtendo o seguinte resultado:
SELECT cnpj, nome, endereco FROM clientes;
-- Listar todas as cidades em que há clientes
SELECT DISTINCT cidade FROM clientes;
-- Listar todas as cidades e estados em que há clientes
SELECT DISTINCT cidade, uf FROM clientes;
-- Quais são os clientes que moram em Niterói?
SELECT nome FROM clientes WHERE cidade = 'Niteroi';
-- Listar os produtos que tenham unidade igual a ‘M’ e valor unitário igual a R$ 1,05 da tabela produto:
SELECT descricao FROM produtos WHERE unidade = 'M' AND valor_unitario = 1.05;
-- Listar o código, a descrição e o valor unitario dos produtos que tenham o valor unitário na faixa de R$ 0,32 até R$ 2,00:
SELECT id, descricao, valor_unitario FROM produtos WHERE valor_unitario >= 0.32 AND valor_unitario <= 2; 
SELECT id, descricao, valor_unitario FROM produtos WHERE valor_unitario BETWEEN 0.32 AND 2; 
-- Listar oo código, a descrição e o valor unitario dos produtos que NÃO tenham o valor unitário na faixa de R$ 0,32 até R$ 2,00:
SELECT id, descricao, valor_unitario FROM produtos WHERE valor_unitario NOT BETWEEN 0.32 AND 2; 
-- Listar os nomes entre Ana e Jorge
SELECT nome FROM clientes WHERE nome BETWEEN 'Ana' AND 'Jorge'; 
-- Between: https://www.w3schools.com/sql/sql_between.asp
-- Listar Listar os vendedores com faixas de comissão A ou B
SELECT nome, faixa_comissao FROM vendedores WHERE faixa_comissao = 'a' OR faixa_comissao ='B'; -- não é sentive case
SELECT nome, faixa_comissao FROM vendedores WHERE faixa_comissao IN ('A','B');
SELECT nome, faixa_comissao FROM vendedores WHERE faixa_comissao NOT IN ('C');
SELECT nome, faixa_comissao FROM vendedores WHERE NOT faixa_comissao = 'C'; 
-- Listar todos os clientes SEM Inscrição Estadual (IE)
SELECT nome FROM clientes WHERE ie IS NULL;
-- Listar todos os clientes COM Inscrição Estadual (IE)
SELECT nome FROM clientes WHERE ie IS NOT NULL; -- Lembrando que NULL é diferente de '' (string vazia)
-- Listar apenas os dois primeiros vendedores
SELECT * FROM vendedores LIMIT 2; -- https://www.w3schools.com/sql/sql_top.asp: O MySQL suporta a cláusula LIMIT para selecionar um número limitado de registros. Pode ser útil em grandes tabelas com milhares de registros.
/* 
LIKE: 
Existem dois curingas:
%   o sinal de porcentagem representa zero, um ou vários caracteres
_   o sublinhado representa um único caractere
https://www.w3schools.com/sql/sql_like.asp
*/
-- Listar todos os produtos que tenham o seu nome começando por Q:
SELECT * FROM produtos WHERE descricao LIKE 'Q%';
-- Listar os vendedores que não começam por ‘Jo’:
SELECT * FROM vendedores WHERE nome NOT LIKE 'Jo%';
-- Listar todos os produtos cujo nome termina com 's';
SELECT * FROM produtos WHERE descricao LIKE '%s'; -- no banco original não há s
-- Listar os produtos que contenham as letras "inh"
SELECT * FROM produtos WHERE descricao LIKE '%inh%'; 
-- Listar os chocolates e valores 
SELECT descricao, valor_unitario FROM produtos WHERE descricao LIKE '%Chocolate%'; -- no banco original não há chocolate amargo e ao leite
-- Listar os vendedores cuja segunda letra do nome seja 'a'
SELECT * FROM vendedores WHERE nome LIKE '_a%';

-- ORDER BY
-- Listar todos os vendedores ordenados por nome
SELECT * FROM vendedores ORDER BY nome;
SELECT * FROM vendedores ORDER BY nome ASC; -- por default, o order by é ASC
-- Listar todos os vendedores ordenados por nome de forma descrescente
SELECT * FROM vendedores ORDER BY nome DESC; 
-- Listar todos os vendedores ordenados por nome e salario 
SELECT * FROM vendedores ORDER BY nome, salario DESC; 
-- Listar todos os clientes com seus estados, sendo que o estado deverá ser ordenado em ordem crescente e o nome por ordem descrescente
SELECT * FROM clientes ORDER BY uf ASC, nome DESC;
-- Listar todos os vendedores que ganham MENOS de 1000 reais e apresentar em ordem crescente
SELECT * FROM vendedores WHERE salario < 1000 ORDER BY nome;
-- Listar os vendedores que não começam por ‘Jo’ e apresentar ordenado de forma descrescente
SELECT * FROM vendedores WHERE nome NOT LIKE 'Jo%' ORDER BY nome DESC;

-- FUNÇÕES COUNT(), AVG(), SUM(), MIN() e MAX()
-- Informe quantos clientes foram cadastrados
SELECT COUNT(id) AS NumeroClientes FROM clientes; -- Valores NULL não são contados 
-- Informe quantos produtos tem valor unitário abaixo de 0.50 centavos
SELECT COUNT(id) FROM produtos WHERE valor_unitario < 0.5; 
-- Informe a média de salario dos vendedores
SELECT AVG(salario) FROM vendedores; -- Valores null são ignorados
-- Informe a média de valores unitarios dos produtos vendidos a M
SELECT AVG(valor_unitario) FROM produtos WHERE unidade = 'M';
-- Somar o valor de todos os salários
SELECT SUM(salario) FROM vendedores; 
-- Somar o valor dos salarios da comissão A
SELECT SUM(salario) FROM vendedores WHERE faixa_comissao = 'A';
-- Somar a quantidade de itens de pedidos
SELECT SUM(quantidade) FROM itens_pedido;
-- Informe o menor salario do vendedores
SELECT MIN(salario) FROM vendedores;
-- Informe o maior salario do vendedores
SELECT MAX(salario) FROM vendedores;
-- Informe o maior salario do vendedores da faixa de comissão B
SELECT MAX(salario) FROM vendedores WHERE faixa_comissao = 'B';
-- Listar os nomes entre Ana e Jorge, ordenado de forma descrescente
SELECT * FROM clientes WHERE nome BETWEEN 'Ana' AND 'Jorge' ORDER BY uf; 
 -- MySQL Functions: https://www.w3schools.com/sql/sql_ref_mysql.asp  
 
 -- COLUNAS CALCULADAS
 -- Mostrar o novo salário fixo dos vendedores, de faixa de comissão ‘C’, calculado com base no reajuste de 75% 
 -- acrescido de R$ 120,00 de bonificação. Ordenar pelo nome do vendedor
 SELECT nome, salario * 0.75 + salario + 120 as novoSalario FROM vendedores where faixa_comissao = 'C' ORDER BY nome;
 
 -- GROUP BY
 -- Informe o número de clientes por Estado
SELECT COUNT(id) AS n_clientes_uf, uf FROM clientes GROUP BY uf;
-- Informe a média salarial por faixa de comissão
SELECT AVG(salario) AS media_salarial_faixa, faixa_comissao FROM vendedores GROUP BY faixa_comissao;
-- Informe a média salarial por faixa de comissão ordenado de forma descrescente por valor
SELECT AVG(salario) AS media_salarial_faixa, faixa_comissao FROM vendedores GROUP BY faixa_comissao ORDER BY media_salarial_faixa DESC;


-- HAVING
-- Informe a média salarial por faixa de comissão apenas das faixas com ganho acima de 2000
SELECT AVG(salario) AS media_salarial_faixa, faixa_comissao FROM vendedores GROUP BY faixa_comissao HAVING media_salarial_faixa > 2000;
-- Informe a média salarial por faixa de comissão apenas das faixas com ganho acima de 2000 ordenado de forma descrescente por valor
SELECT AVG(salario) AS media_salarial_faixa, faixa_comissao FROM vendedores GROUP BY faixa_comissao HAVING media_salarial_faixa > 2000 ORDER BY media_salarial_faixa DESC;

-- INNER JOIN
-- Listar tudo
SELECT * FROM pedidos INNER JOIN clientes;
SELECT * FROM clientes JOIN pedidos;
-- Listar todos os dados dos pedidos feitos por clientes
SELECT * FROM pedidos INNER JOIN clientes ON pedidos.id_cliente = clientes.id;
SELECT * FROM pedidos, clientes WHERE pedidos.id_cliente = clientes.id;

SELECT clientes.nome, MAX(pedidos.prazo_entrega) AS Prazo 
FROM pedidos 
JOIN clientes 
ON pedidos.id_cliente = clientes.id
GROUP BY nome
ORDER BY prazo;

-- Listar os pedidos com seus respectivos vendedores
SELECT * FROM pedidos INNER JOIN vendedores ON pedidos.id_vendedor = vendedores.id;

SELECT pedidos.id_cliente, vendedores.nome AS vendedor, pedidos.prazo_entrega 
FROM pedidos 
INNER JOIN vendedores 
ON pedidos.id_vendedor = vendedores.id;

-- Listar o numero do pedido, o código do produto e a quantidade dos itens do pedido com a quantidade maior a 35 da tabela item de pedido
SELECT ip.id_pedido, p.descricao, ip.quantidade 
FROM itens_pedido AS ip 
INNER JOIN produtos AS p 
ON p.id = ip.id_produto 
WHERE quantidade > 35
ORDER BY p.descricao;

SELECT ip.id_pedido, p.descricao, SUM(ip.quantidade) AS qtdTotal
FROM itens_pedido AS ip 
INNER JOIN produtos AS p 
ON p.id = ip.id_produto 
WHERE quantidade > 35
GROUP BY p.descricao
HAVING qtdTotal > 100
ORDER BY p.descricao;


-- Listar os pedidos com seus respectivos clientes e vendedores
SELECT pedidos.id, pedidos.prazo_entrega, vendedores.nome, clientes.nome 
FROM pedidos 
INNER JOIN vendedores ON pedidos.id_vendedor = vendedores.id 
INNER JOIN clientes ON pedidos.id_cliente = clientes.id;

-- Litar a quantidade de itens vendidos por produto ordenados de forma crescente
SELECT itens_pedido.id_pedido, produtos.descricao, SUM(quantidade) FROM itens_pedido INNER JOIN produtos ON itens_pedido.id_produto = produtos.id GROUP BY produtos.descricao ORDER BY produtos.descricao; 





