
-- Commit e Rollback
create trigger emprestimoFeriado before insert
on alugueis
for each row
set new.dataEmprestimo = new.dataEmprestimo + 2;
commit; 
rollback;

-- Grant e Rovoke
create user 'Admin'@'localhost' identified by '123';
grant all on biblioteca to 'Admin'@'localhost';
revoke select on bibliotecarios from  'Admin'@'localhost';

create user 'user'@'localhost' identified by '123';
grant select, update on usuarios to 'user'@'localhost';


