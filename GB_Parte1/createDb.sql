DROP DATABASE IF EXISTS MeLeva;
CREATE DATABASE MeLeva;
USE MeLeva;

drop table if exists Condutor;
create table Condutor(
    cpf_motorista varchar(11) primary key,
    nome_cond varchar(255) not null,
    telefone_cond varchar(9) not null UNIQUE,
    data_cadastro_cond TIMESTAMP not null,
    CHECK(CHAR_LENGTH(cpf_motorista) = 11),
    CHECK(CHAR_LENGTH(telefone_cond) = 9)
);
SELECT 'Criou Condutor' as '';

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
SELECT 'Criou veiculo' as '';

drop table if exists motorista;
create table motorista(
    data_inicio_mot timestamp not null,
    data_fim_mot timestamp not null, 
    renavam varchar(9),
    cpf_motorista varchar(11) not null,
    id_motorista  int PRIMARY KEY auto_increment,
    CONSTRAINT DIRIGE FOREIGN KEY (cpf_motorista) REFERENCES Condutor(cpf_motorista) on update cascade,
    CONSTRAINT ALUGADO FOREIGN KEY (renavam) REFERENCES veiculo(renavam) on update cascade,
    UNIQUE(renavam, cpf_motorista, data_inicio_mot, data_fim_mot),
    check(DATEDIFF(data_inicio_mot,data_fim_mot) >= 0)
    
);
SELECT 'Criou motorista' as '';

drop table if exists passageiros;
create table passageiros(
    nome_pass varchar(255) not null,
    telefone_pass varchar(9) not null UNIQUE,
    data_cadastro_pass timestamp not null,
    cpf_passageiro varchar(11) PRIMARY KEY,
    CHECK(CHAR_LENGTH(telefone_pass) = 9)
    
);
SELECT 'Criou passageiros' as '';

drop table if exists corrida;
create table corrida(
    id_corrida integer auto_increment,
    avaliacao_condutor INT UNSIGNED,
    avaliacao_veiculo INT UNSIGNED,
    data_inicio_corr TIMESTAMP,
    data_fim_corr TIMESTAMP,
    origem varchar(255),
    destino varchar(255),
    tarifa real,
    distancia real UNSIGNED,
    id_motorista integer,
    cpf_passageiro varchar(11),
    PRIMARY KEY(id_corrida, id_motorista , cpf_passageiro),
    CONSTRAINT ACEITA FOREIGN KEY (id_motorista) REFERENCES motorista(id_motorista) on update cascade,
    CONSTRAINT SOLICITA FOREIGN KEY (cpf_passageiro) REFERENCES passageiros(cpf_passageiro) on update cascade,
    CHECK( avaliacao_condutor <= 5),
    CHECK( avaliacao_veiculo <= 5),
    check(DATEDIFF(data_inicio_corr, data_fim_corr) >= 0)
    
);
SELECT 'Criou corrida' as '';


/*CHECK(data_cadastro_cond <= now()) fazer numa trigger */

/*CHECK(data_inicio <= now()),
    CHECK(data_fim <= now()) trigger*/

/*CHECK(data_cadastro_pass <= now()) trigger*/

/*CHECK( data_inicio <= now()),
    CHECK( data_fim <= now()) trigger*/