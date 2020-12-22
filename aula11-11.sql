-- procedure
delimiter $$
create procedure listarEscritores()
begin
    select nome from escritores;
end $$
delimiter ;
call listarEscritores();

-- function
delimiter $$
create function classificaCategoria(id int)
returns varchar(30)
deterministic
begin
    declare categoria varchar(30);
    IF id =  1 THEN
        SET categoria = 'Terror';
    ELSEIF id = 2 THEN
        SET categoria = 'Romance';
    END IF;
    return categoria;
end$$
delimiter ;

-- trigger
create trigger emprestimoFeriado before insert
on alugueis
for each row
set new.dataEmprestimo = new.dataEmprestimo + 2;


