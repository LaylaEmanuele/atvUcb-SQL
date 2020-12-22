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

USE biblioteca;
SELECT idAluguel,
CASE
WHEN dayname(dataEmprestimo) = "Monday" THEN "Segunda-feira"
WHEN dayname(dataEmprestimo) = "Tuesday" THEN "Terça-feira"
WHEN dayname(dataEmprestimo) = "Wednesday" THEN "Quarta-feira"
WHEN dayname(dataEmprestimo) = "Thursday" THEN "Quinta-feira"
WHEN dayname(dataEmprestimo) = "Friday" THEN "Sexta-feira"
WHEN dayname(dataEmprestimo) = "Saturday" THEN "Sábado"
WHEN dayname(dataEmprestimo) = "Sunday" THEN "Domingo"
END AS nomeDia
FROM alugueis;

USE biblioteca;
CREATE OR REPLACE VIEW listaLivros AS
SELECT titulo, localizacao FROM livros;

SELECT * FROM listaLivros;

delimiter $$
create procedure listarEscritores()
begin
	select nome from escritores;
end $$
delimiter ;
call listarEscritores(); 

delimiter $$
create function classificaPgsLivros (qtdPaginas int)
returns varchar(30)
deterministic
begin
	declare categoria varchar(30);
    IF qtdPaginasqtdPaginas < 100 THEN
        SET categoria = 'Leitura leve';
    ELSEIF qtdPaginas < 300 THEN
        SET categoria = 'Leitura média';
	ELSE
        SET categoria = 'Leitura intensa';
    END IF;
    return categoria;
end$$
delimiter ;


create trigger devolucaoFeriado before insert
on alugueis
for each row
set new.dataDevolucao = new.dataDevolucao - 2;
