DROP DATABASE IF EXISTS MeLeva;
CREATE DATABASE MeLeva;
USE MeLeva;

/*------------TABLES-------------*/
drop table if exists Condutor;
create table Condutor(
    cpf_motorista varchar(11) primary key,
    nome_cond varchar(255) not null,
    telefone_cond varchar(9) not null UNIQUE,
    data_cadastro_cond TIMESTAMP not null,
    CHECK(CHAR_LENGTH(cpf_motorista) = 11),
    CHECK(CHAR_LENGTH(telefone_cond) = 9)
);

drop table if exists veiculo;
create table veiculo(
    renavam varchar(9) PRIMARY KEY,
    placa varchar(7) not null UNIQUE,
    marca varchar(255) not null,
    modelo varchar(255) not null,
    ano int(4),
    CHECK(CHAR_LENGTH(placa) = 7),
    CHECK(CHAR_LENGTH(renavam) = 9),
    CHECK(ano >= 1900)
);

drop table if exists motorista;
create table motorista(
    data_inicio_mot timestamp not null,
    data_fim_mot timestamp null default null, 
    renavam varchar(9) not null,
    cpf_motorista varchar(11) not null,
    id_motorista  int PRIMARY KEY auto_increment,
    CONSTRAINT DIRIGE FOREIGN KEY (cpf_motorista) REFERENCES Condutor(cpf_motorista) on update cascade,
    CONSTRAINT ALUGADO FOREIGN KEY (renavam) REFERENCES veiculo(renavam) on update cascade,
    UNIQUE(renavam, cpf_motorista, data_inicio_mot, data_fim_mot),
    check(timediff(data_fim_mot,data_inicio_mot) >= 0)
);

drop table if exists passageiros;
create table passageiros(
    nome_pass varchar(255) not null,
    telefone_pass varchar(9) not null UNIQUE,
    data_cadastro_pass timestamp not null,
    cpf_passageiro varchar(11) PRIMARY KEY,
    CHECK(CHAR_LENGTH(telefone_pass) = 9)
);

drop table if exists corrida;
create table corrida(
    id_corrida integer auto_increment,
    avaliacao_condutor INT UNSIGNED,
    avaliacao_veiculo INT UNSIGNED,
    data_inicio_corr TIMESTAMP not null,
    data_fim_corr TIMESTAMP null default null,
    origem varchar(255),
    destino varchar(255),
    tarifa real,
    distancia_km real UNSIGNED,
    id_motorista integer,
    cpf_passageiro varchar(11),
    PRIMARY KEY(id_corrida, id_motorista , cpf_passageiro),
    CONSTRAINT ACEITA FOREIGN KEY (id_motorista) REFERENCES motorista(id_motorista) on update cascade,
    CONSTRAINT SOLICITA FOREIGN KEY (cpf_passageiro) REFERENCES passageiros(cpf_passageiro) on update cascade,
    CHECK( avaliacao_condutor <= 5),
    CHECK( avaliacao_veiculo <= 5),
    CHECK(timediff(data_fim_corr,data_inicio_corr) >= 0)    
);

/*------------TRIGGERS CHECK INSERTS-------------*/
/*Verifica se a data de cadastro do passageiro é > now()*/
drop trigger if exists chkDataCadPass;
DELIMITER $$
CREATE TRIGGER chkDataCadPass BEFORE INSERT ON passageiros
    FOR EACH ROW BEGIN 
        IF (new.data_cadastro_pass > now()) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Ora ora, temos um passageiro viajante do tempo aqui?!(data de cadastro errada!)';
        END IF; 
    END $$
DELIMITER ;

/*Verifica se a data de cadastro do condutor é > now()*/
drop trigger if exists chkDataCadCond;
DELIMITER $$
CREATE TRIGGER chkDataCadCond BEFORE INSERT ON condutor
    FOR EACH ROW BEGIN 
        IF (new.data_cadastro_cond > now()) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Ora ora, temos um condutor viajante do tempo aqui?! (data de cadastro errada!)';
        END IF; 
    END $$
DELIMITER ;

/*Verifica se as data da corrida é > now*/
drop trigger if exists chkInsDataCorrida;
DELIMITER $$
CREATE TRIGGER chkInsDataCorrida BEFORE INSERT ON corrida
    FOR EACH ROW BEGIN 
        IF (new.data_fim_corr > now()) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Voce e vidente? (data de fim da corrida no futuro)';
        END IF; 
        IF (new.data_inicio_corr > now()) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Voce e vidente? (data de inicio da corrida no futuro)';
        END IF; 
    END $$
DELIMITER ;

/*Não permite que um veiculo seja retirado por mais de um condutor ao mesmo tempo*/
/*Não permite que um condutor retire mais de um carro ao mesmo tempo*/
drop trigger if exists chkInsMotorista;
DELIMITER $$
CREATE TRIGGER chkInsMotorista BEFORE INSERT ON motorista
    FOR EACH ROW BEGIN 
        IF ((SELECT id_motorista from motorista where renavam = new.renavam AND data_fim_mot is null) is not null) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Este carro ja esta com outro motorista!';
        END IF; 
        IF((SELECT id_motorista from motorista where cpf_motorista = new.cpf_motorista AND data_fim_mot is null) is not null) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Voce nao pode estar em dois carros ao mesmo tempo!';
        END IF;
    END $$
DELIMITER ;

/*Verifica se o passageiro e condutor já estão numa corrida*/
drop trigger if exists chkNewCorrida;
DELIMITER $$
CREATE TRIGGER chkNewCorrida BEFORE INSERT ON corrida
    FOR EACH ROW BEGIN 
        /*checa um campo que nunca vai ser nulo caso ache retorne um item nas condicoes abaixo*/
        IF ((SELECT id_corrida from corrida where cpf_passageiro = new.cpf_passageiro AND data_fim_corr is null) is not null) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Ta viajando cara?! (Passageiro tentando realizar uma corrida antes de terminar a atual)';
        END IF; 
        IF ((SELECT id_corrida from corrida where id_motorista = new.id_motorista AND data_fim_corr is null) is not null) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Nao tente ser tao eficiente! (Condutor tentando realizar uma corrida antes de terminar a atual)';
        END IF;
    END $$
DELIMITER ;

/*------------TRIGGERS CHECK UPDATES-------------*/
/*Verifica se a data de cadastro do passageiro é > now()*/
drop trigger if exists chkUpdDataCadPass;
DELIMITER $$
CREATE TRIGGER chkUpdDataCadPass BEFORE UPDATE ON passageiros
    FOR EACH ROW BEGIN 
        IF (new.data_cadastro_pass > now()) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Alguem esta querendo mudar o passado? (data de cadastro passageiro errada!)';
        END IF; 
    END $$
DELIMITER ;

/*Verifica se a data de cadastro do condutor é > now()*/
drop trigger if exists chkUpdDataCadCond;
DELIMITER $$
CREATE TRIGGER chkUpdDataCadCond BEFORE UPDATE ON condutor
    FOR EACH ROW BEGIN 
        IF (new.data_cadastro_cond > now()) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Alguem esta querendo mudar o passado? (data de cadastro condutor errada!)';
        END IF; 
    END $$
DELIMITER ;

/*Verifica se as datas de motorista é > now*/
drop trigger if exists chkUpdDataMotorista;
DELIMITER $$
CREATE TRIGGER chkUpdDataMotorista BEFORE UPDATE ON motorista
    FOR EACH ROW BEGIN 
        IF (new.data_fim_mot > now()) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Voce e vidente? (data de fim do motorista no futuro)';
        END IF; 
        IF (new.data_inicio_mot > now()) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Voce e vidente? (data de inicio do motorista no futuro)';
        END IF; 
        IF (new.data_fim_mot is null and old.data_fim_mot is not null) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Hmmmmm alguem esta querendo burlar as regras do jogo? (nao e permitido alterar dados do historico para null)';
        END IF;
    END $$
DELIMITER ;

/*Verifica se a data de fim da corrida é > now*/
drop trigger if exists chkUpdDataIniCorrida;
DELIMITER $$
CREATE TRIGGER chkUpdDataCorrida BEFORE UPDATE ON corrida
    FOR EACH ROW BEGIN 
        IF (new.data_inicio_corr > now()) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Voce e vidente? (data de inicio da corrida no futuro)';
        END IF; 
        IF (new.data_fim_corr > now()) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Voce e vidente? (data de fim da corrida no futuro)';
        END IF;
        IF (new.data_fim_corr is null and old.data_fim_corr is not null) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Hmmmmm alguem esta querendo burlar as regras do jogo? (nao e permitido alterar dados do historico para null)';
        END IF;
    END $$
DELIMITER ;

/*Verifica se o passageiro e condutor já estão numa corrida*/
drop trigger if exists chkUpdFinalCorrida;
DELIMITER $$
CREATE TRIGGER chkUpdFinalCorrida BEFORE UPDATE ON corrida
    FOR EACH ROW BEGIN 
        /*checa um campo que nunca vai ser nulo caso ache retorne um item nas condicoes abaixo*/
        IF ((SELECT id_corrida from corrida where cpf_passageiro = new.cpf_passageiro AND data_fim_corr is null) is not null) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Ta viajando cara?! (Passageiro tentando realizar uma corrida antes de terminar a atual)';
        END IF; 
        IF ((SELECT id_corrida from corrida where id_motorista = new.id_motorista AND data_fim_corr is null) is not null) THEN
            signal sqlstate '45000' set MESSAGE_TEXT = 'Nao tente ser tao eficiente! (Condutor tentando realizar uma corrida antes de terminar a atual)';
        END IF;
    END $$
DELIMITER ;

/*------------VIEWS-------------*/
drop view if exists ResumoCorrida;
create view ResumoCorrida (
        cpf_motorista, 
        Nome_Motorista,
        cpf_passageiro,
        nome_passageiro, 
        origem, 
        destino, 
        distancia_km, 
        valor,
        horario_de_inicio, 
        tempo_de_duracao, 
        id_veiculo, 
        avaliacao_veiculo, 
        avaliacao_condutor) as

    select cpf_motorista, 
    nome_cond,
    cpf_passageiro,
    nome_pass,
    origem, 
    destino, 
    distancia_km,
    ROUND(((5 + distancia_km * 0.8 + ((TIME_TO_SEC(data_fim_corr) - TIME_TO_SEC(data_inicio_corr))/60)*0.2))*tarifa, 2) as valor,
    TIME(data_inicio_corr) as horario_de_inicio,
    DATE_FORMAT(timediff(data_fim_corr,data_inicio_corr),'%Hh:%imin') as tempo_de_duracao,
    renavam as id_veiculo,
    avaliacao_veiculo, 
    avaliacao_condutor
    from Corrida
    natural join motorista
    natural join Condutor
    natural join passageiros;  

drop view if exists ResumoCondutor;
create view ResumoCondutor 
    (Cpf_motorista,
     Nome_Motorista, 
     qtd_aval, 
     media_aval, 
     qtd_corrida, 
     valor_receber) as

    select cpf_motorista, 
    Nome_Motorista, 
    count(avaliacao_condutor) as qtd_aval,
    round(avg(avaliacao_condutor), 2) as media_aval,
    count(cpf_motorista) as qtd_corrida,
    sum(ROUND(valor*0.1, 2)) as valor_receber
    
    from ResumoCorrida
    group by cpf_motorista;

drop view if exists ResumoVeiculo;
create view ResumoVeiculo 
    (renavam,
     placa,
     marca,
     modelo,
     ano,
     qtd_aval,
     qtd_corrida,
     media_aval) as
    
    select renavam,
    placa,
    marca,
    modelo,
    ano,
    count(avaliacao_veiculo) as qtd_aval,
    count(renavam) as qtd_corrida,
    avg(avaliacao_veiculo) as media_aval

    from corrida
    natural join motorista
    natural join veiculo
    group by renavam;