-- GROUP BY
-- Informe o número de clientes por Estado
select uf, count(idCliente)
from cliente
group by uf;

-- Informe a média salarial por faixa de comissão
select faixa_comissao, avg(salario)
from vendedor
group by faixa_comissao;

-- Informe a média salarial por faixa de comissão ordenado de forma descrescente por valor
select faixa_comissao, avg(salario) as mediaSalario
from vendedor
group by faixa_comissao
order by mediaSalario desc;

-- HAVING
-- Informe a média salarial por faixa de comissão apenas das faixas com ganho acima de 2000
select faixa_comissao, avg(salario) as mediaSalario
from vendedor
group by faixa_comissao
having mediaSalario > 2000;

-- Informe a média salarial por faixa de comissão apenas das faixas com ganho acima de 2000 ordenado de forma descrescente por valor
select faixa_comissao, avg(salario) as mediaSalario
from vendedor
group by faixa_comissao
having mediaSalario > 2000
order by mediaSalario desc;

-- COLUNAS CALCULADAS
-- Calcular o novo salário fixo dos vendedores, de faixa de comissão ‘A’, calculado com base no reajuste de 75% acrescido de R$ 120,00 de bonificação. Ordenar pelo nome do vendedor
select nome, salario, (salario *0.75) + salario + 120 as novoSalario from vendedor order by nome asc;

-- JOIN
-- Listar todos os pedidos realizados, exibindo o nome dos clientes
select p.idPedido, p.prazo, c.nome, p.idVendedor 
from pedido as p
inner join cliente as c
on p.idCliente = c.idCliente;

-- Listar todos os pedidos realizados, exibindo o nome dos vendedores
select p.idPedido, p.prazo, p.idCliente, v.nome as nomeVendedor
from pedido as p
inner join vendedor as v
on p.idVendedor = v.idVendedor;

-- Listar todos os pedidos realizados, exibindo o nome dos vendedores e clientes, ordenados por prazo de entrega
select p.idPedido, p.prazo, c.nome as nomeCliente, v.nome as nomeVendedor
from pedido as p
inner join cliente as c on p.idCliente = c.idCliente
inner join vendedor as v on p.idVendedor = v.idVendedor
order by p.prazo;

-- Listar o id e prazo de entrega dos pedidos realizados pela cliente 'Susana', incluindo o nome do vendedor
select p.idPedido, p.prazo, c.nome as nomeCliente, v.nome as nomeVendedor
from pedido as p
inner join vendedor as v on p.idVendedor = v.idVendedor
inner join cliente as c on p.idCliente = c.idCliente
where c.nome = "Susana";

-- Listar o prazo_entrega mínima para cada cliente, apresentando nome do vendedor
select c.nome as nomeCliente, MIN(p.prazo) as prazo_minimo, v.nome as nomeVendedor
from pedido as p
inner join cliente as c on p.idCliente = c.idCliente
inner join vendedor as v on p.idVendedor = v.idVendedor
group by c.nome;

-- Listar os clientes e vendedores com prazo de entrega entre 10 e 20 dias e ordene por prazo de entrega. O nome do campo deve ser alterado
select c.nome as nomeCliente, p.prazo, v.nome as nomeVendedor
from pedido as p
inner join cliente as c on p.idCliente = c.idCliente
inner join vendedor as v on p.idVendedor = v.idVendedor
where p.prazo between 10 and 20
group by c.nome;

-- Listar cliente e média de prazo para entrega, considerando apenas os clientes com prazo acima de 10 dias
select c.nome as nomeCliente, avg (p.prazo) as mediaPrazo
from pedido as p
inner join cliente as c on p.idCliente = c.idCliente
where  p.prazo > 10
group by c.nome;

-- Ao final, apresente somente os clientes cuja média é superior a 15 dias
select c.nome as nomeCliente, avg (p.prazo) as mediaPrazo
from pedido as p
inner join cliente as c on p.idCliente = c.idCliente
group by c.nome
having mediaPrazo > 15;

-- Ordene por prazo máximo
select p.idPedido, MAX(p.prazo) as prazoMaximo, c.nome as nomeCliente, v.nome as nomeVendedor
from pedido as p
inner join cliente as c on p.idCliente = c.idCliente
inner join vendedor as v on p.idVendedor = v.idVendedor
group by c.nome
order by prazoMaximo asc, nomeCliente asc;

-- Listar os nomes dos produtos com quantidade somada,
select i.idPedido, prod.Descricao as produto, SUM(i.quantidade)
from item_pedido as i
inner join produto as prod on i.idProduto = prod.idProduto
group by prod.Descricao;

-- porém, considerando apenas os itens com quantidade inferior a 30.
select i.idPedido, prod.Descricao as produto, sum(i.quantidade) as quantidade
from item_pedido as i
inner join produto as prod on i.idProduto = prod.idProduto
group by prod.Descricao
having quantidade < 30;

-- Ao final, apresente apenas os itens cuja soma é superior a 40
select i.idPedido, prod.Descricao as produto, sum(i.quantidade) as quantidade
from item_pedido as i
inner join produto as prod on i.idProduto = prod.idProduto
group by prod.Descricao
having quantidade > 40;