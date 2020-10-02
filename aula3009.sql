-- Listar os nomes dos assinantes, seguido dos dados do endereço e os telefones correspondentes.
select a.nome, e.rua, e.complemento, e.bairro, m.nome as municipio, e.CEP, t.ddd, t.n_fone
from assinante as a
inner join endereco as e on e.cd_assinante = a.cd_assinante
inner join municipio as m on m.cd_municipio = e.cd_municipio
left join telefone as t on t.cd_endereco = e.cd_endereco;

-- Listar os nomes dos assinantes, seguido do seu ramo, ordenados por ramo e posteriormente por nome.
select a.nome, r.ds_ramo from assinante as a
inner join ramo as r
on a.cd_ramo = r.cd_ramo
order by r.ds_ramo asc, a.nome asc;

-- Listar os assinantes do município de Pelotas que são do tipo residencial.
select assinante.nome, assinante.cd_tipo, municipio.nome as municipio from assinante
inner join tipo on assinante.cd_tipo = tipo.cd_tipo
inner join endereco on endereco.cd_assinante = assinante.cd_assinante
inner join municipio on municipio.cd_municipio = endereco.cd_municipio
where tipo.ds_tipo = "RESIDENCIAL" and municipio.nome = "PELOTAS";

-- Listar os nomes dos assinantes que possuem mais de um telefone.
select assinante.nome, count(telefone.cd_fone) as qtdTelefones
from assinante
inner join endereco on assinante.cd_assinante = endereco.cd_assinante
inner join telefone on telefone.cd_endereco = endereco.cd_endereco
group by assinante.nome
having qtdTelefones > 1;

-- Listar os nomes dos assinantes seguido do número do telefone, tipo de assinante básico, com endereço em Natal ou João Câmara.
select assinante.nome, telefone.n_fone, tipo.ds_tipo, municipio.nome as nomeMunicipio
from assinante
inner join tipo on assinante.cd_tipo = tipo.cd_tipo
inner join endereco on endereco.cd_assinante = assinante.cd_assinante
inner join municipio on municipio.cd_municipio = endereco.cd_municipio
left join telefone on telefone.cd_endereco = endereco.cd_endereco
where tipo.ds_tipo = "Basico" and municipio.nome = "NATAL" or municipio.nome = "JOÃO CÂMARA";

-- Listar todos os dados do cliente João (ramo, tipo, endereco, telefone, municipio)
select assinante.nome, ramo.ds_ramo AS ramo, tipo.ds_tipo AS tipoAssinatura, endereco.rua, endereco.bairro, endereco.CEP, telefone.ddd, telefone.n_fone, municipio.nome AS municipio
from assinante
inner join ramo on ramo.cd_ramo = assinante.cd_ramo
inner join tipo on tipo.cd_tipo = assinante.cd_tipo
inner join endereco on endereco.cd_assinante = assinante.cd_assinante
left join telefone on telefone.cd_endereco = endereco.cd_endereco
inner join municipio on municipio.cd_municipio = endereco.cd_municipio
where assinante.nome = "João";
