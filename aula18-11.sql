
-- Commit e Rollback
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
commit; 
rollback;

-- Grant e Rovoke
create user 'gabriel'@'localhost' identified by '123';
grant all on biblioteca to 'gabriel'@'localhost';
revoke select, insert on escritores from  'gabriel'@'localhost';

create user 'user'@'localhost' identified by '123';
grant select, update on categorias to 'user'@'localhost';