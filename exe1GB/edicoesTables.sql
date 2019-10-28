/*edita a tabela reservas*/
ALTER TABLE reservas ADD devolucao date;
/*edita a tabela de barcos*/
ALTER TABLE barcos ADD categoria char;
ALTER TABLE barcos ADD disponivel boolean;
update barcos set disponivel = 1;

/*
A–Para qualquer nível de avaliação
B–Somente para marinheiros com avaliação superior a 6
C–Somente para marinheiros com avaliação superior a 9
Atualiza a tabela dos barcos*/
UPDATE barcos SET categoria = 'A' WHERE id_barco = 101;
UPDATE barcos SET categoria = 'B' WHERE id_barco = 102;
UPDATE barcos SET categoria = 'C' WHERE id_barco = 103 OR id_barco = 104;

/*inseri marinheiros para testar o gatilho MonitoraBarcos*/
insert into Marinheiros
(id_marin, nome_marin, avaliacao, idade) values
(1, 'Elvis', 10, 24),
(2, 'Joao', 8, 28),
(3, 'Armando', 5, 30);


/* Crie um gatilho que evite que um marinheiro com avaliação inferior a categoria 
do barco faça a reserva;
remove a trigger se ja tem*/
drop trigger if exists MonitoraBarcos;
/*trigger que avalia a categoria do barco e a avaliacao do marinheiro*/
DELIMITER $$
CREATE TRIGGER MonitoraBarcos BEFORE INSERT ON RESERVAS
    FOR EACH ROW BEGIN 
        IF ((SELECT categoria FROM barcos WHERE new.id_barco = id_barco) = 'B') THEN
            IF ((SELECT avaliacao from marinheiros where id_marin = new.Id_marin) < 6 ) THEN
                signal sqlstate '45000' set MESSAGE_TEXT = 'Este barco nao pode ser retirado por este marinheiro';    
            END IF;
        END IF;
        IF ((SELECT categoria FROM barcos WHERE new.id_barco = id_barco) = 'C') THEN
            IF ((SELECT avaliacao from marinheiros where id_marin = new.Id_marin) < 9 ) THEN
                signal sqlstate '45000' set MESSAGE_TEXT = 'Este barco nao pode ser retirado por este marinheiro';    
            END IF;
        END IF; 
    END $$
DELIMITER ;

/*teste do trigger MonitoraBarcos*/
insert into Reservas
(id_marin, id_barco, dia, devolucao) 
values (3, 102, '1998-10-10', '1998-10-15');
insert into Reservas
(id_marin, id_barco, dia, devolucao)
values (3, 101, '1998-10-10', '1998-10-15');
insert into Reservas
(id_marin, id_barco, dia, devolucao) 
values (2, 103, '1998-10-10', '1998-10-15');
insert into Reservas
(id_marin, id_barco, dia, devolucao) 
values (2, 102, '1998-10-10', '1998-10-15');
insert into Reservas
(id_marin, id_barco, dia, devolucao) 
values (1,104, '1998-10-10', '1998-10-15');

/*Crie um gatilho para que um barco que ainda não foi devolvido não possa ser reservado;*/
drop trigger if exists barcoDevolvido;

DELIMITER $$
CREATE TRIGGER barcoDevolvido BEFORE INSERT ON RESERVAS
    FOR EACH ROW PRECEDES MonitoraBarcos BEGIN
        IF((SELECT devolucao from reservas where id_barco = new.id_barco and devolucao is not NULL and devolucao > now()) is not null)  THEN
            update barcos set disponivel = 0 WHERE id_barco = new.id_barco;
        ELSE 
            update barcos set disponivel = 1 WHERE id_barco = new.id_barco;
        END IF;
        IF ((SELECT disponivel from barcos where id_barco = new.id_barco) = 0) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Este barco esta reservado'; 
        END IF;
    END $$
DELIMITER ;

update barcos set disponivel = 0;

delete from reservas where id_marin = 1;
delete from reservas where id_marin = 58;

insert into reservas (id_marin, id_barco, dia, devolucao)
values (1,104, '1998-10-10', '2019-10-31');
insert into reservas (id_marin, id_barco, dia, devolucao)
values (58,104, '1998-10-10', '2019-10-31');

/*Exercício2: Para o caso dos Marinheiros, crie uma visão que retorne um resumo das reservas, 
utilizando junções, onde deve ser apresentado: 
Id_marin, nome_marin, id_barco, nome_barco e tempo de reserva*/
create view resumo(id_marin, nome_marin, id_barco, nome_barco, tempo_reserva) as 
    select reservas.id_marin as id_marin, 
    marinheiros.nome_marin as nome_marin,
     reservas.id_barco as id_barco, 
     barcos.nome_barco as nome_barco,
     (devolucao - dia) as tempo_reserva
     from ((reservas NATURAL join barcos)
            NATURAL join marinheiros);
