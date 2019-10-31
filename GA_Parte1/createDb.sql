DROP DATABASE IF EXISTS MeLeva;
CREATE DATABASE MeLeva;
USE MeLeva;

drop table if exists Condutor;
create table Condutor(
    nome_cond varchar(255) not null,
    telefone_cond varchar(9) not null,
    cpf_motorista varchar(11) primary key,
    data_cadastra TIMESTAMP not null,
    CHECK(CHAR_LENGTH(cpf_motorista) = 11)
);

drop table if exists veiculo;
create table veiculo(
    renavam integer PRIMARY KEY,
    placa varchar(7) not null,
    marca varchar(255) not null,
    modelo varchar(255) not null,
    ano integer,
    CHECK(CHAR_LENGTH(placa) = 7)
);

drop table if exists motorista;
create table motorista(
    data_inicio timestamp not null,
    data_fim timestamp not null, 
    renavam INTEGER not null,
    cpf_motorista varchar(11) not null,
    id_motorista  integer PRIMARY KEY auto_increment,
    UNIQUE(renavam, cpf_motorista, data_inicio, data_fim),
    FOREIGN KEY (cpf_motorista) REFERENCES Condutor(cpf_motorista),
    FOREIGN KEY (renavam) REFERENCES veiculo(renavam),
    CHECK(CHAR_LENGTH(cpf_motorista) = 11)
);

drop table if exists passageiros;
create table passageiros(
    nome_cond varchar(255),
    telefone_cond varchar(9) not null,
    data_cadastro timestamp not null,
    cpf_passageiro varchar(11) PRIMARY KEY,
    CHECK(CHAR_LENGTH(cpf_passageiro) = 11)
);

drop table if exists corrida;
create table corrida(
    id_corrida integer auto_increment,
    avaliacao_condutor INT UNSIGNED,
    avaliacao_veiculo INT UNSIGNED,
    data_inicio TIMESTAMP,
    data_fim TIMESTAMP,
    origem varchar(255),
    destino varchar(255),
    tarifa real,
    distancia real,
    id_motorista integer,
    cpf_passageiro varchar(11),
    PRIMARY KEY(id_corrida, id_motorista , cpf_passageiro),
    FOREIGN KEY (id_motorista) REFERENCES motorista(id_motorista),
    FOREIGN KEY (cpf_passageiro) REFERENCES passageiros(cpf_passageiro),
    CHECK(CHAR_LENGTH(cpf_passageiro) = 11),
    check( avaliacao_condutor <= 5),
    check( avaliacao_veiculo <= 5)
);
