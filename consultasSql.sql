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