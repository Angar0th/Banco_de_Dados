drop table if exists Reservas;
drop table if exists Marinheiros;
drop table if exists Barcos;

DROP DATABASE IF EXISTS EXE1;
CREATE DATABASE EXE1;
USE EXE1;

create table Marinheiros (
  id_marin integer primary key,
  nome_marin text,
  avaliacao integer,
  idade real
);

create table Barcos (
  id_barco integer primary key,
  nome_barco text,
  cor text
);

create table Reservas (
  id_marin integer,
  id_barco integer,
  dia date,
  primary key (id_marin, id_barco, dia),
  FOREIGN KEY (id_marin) references Marinheiros(id_marin),
  FOREIGN KEY (id_barco) references Barcos(id_barco)
);

insert into Marinheiros
(id_marin, nome_marin, avaliacao, idade) values
(22, 'Dustin', 7, 45.0),
(29, 'Brutus', 1, 33),
(31, 'Lubber', 8, 55.5),
(32, 'Andy', 8, 25.5),
(58, 'Rusty', 10, 35),
(64, 'Horatio', 7, 35),
(71, 'Zorba', 9, 25.5),
(74, 'Horatio', 9, 35),
(85, 'Art', 3, 25.5),
(95, 'Bob', 3, 63.5);

insert into Barcos
(id_barco, nome_barco, cor) values
(101, 'Interlake', 'azul'),
(102, 'Interlake', 'vermelho'),
(103, 'Clipper', 'verde'),
(104, 'Marine', 'vermelho');

insert into Reservas
(id_marin, id_barco, dia) values
(22, 101, '1998-10-10'),
(22, 102, '1998-10-10'),
(22, 103, '1998-08-10'),
(22, 104, '1998-07-10'),
(31, 102, '1998-10-11'),
(31, 103, '1998-06-11'),
(31, 104, '1998-12-11'),
(64, 101, '1998-05-09'),
(64, 102, '1998-05-09'),
(74, 103, '1998-08-09');