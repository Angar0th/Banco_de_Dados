create database ta_elvis_joao;
use ta_elvis_joao;

CREATE TABLE Time_ (
	Nome_time varchar(255) PRIMARY KEY
);

CREATE TABLE Jogador (
	id_jogador INTEGER PRIMARY KEY AUTO_INCREMENT,
	Nome_jogador varchar(255) NOT NULL UNIQUE,
	Posicao varchar(255)   
);

CREATE TABLE Campeonato (
	Nome_camp varchar(255) NOT NULL,
	id_camp INTEGER AUTO_INCREMENT,
	Ano integer NOT NULL,
	primary key (id_camp, Ano)
);

CREATE TABLE Contrato (
	Num_contrato INTEGER PRIMARY KEY AUTO_INCREMENT,
    Nome_time varchar(255) NOT NULL,
	id_jogador INTEGER NOT NULL UNIQUE,
	CONSTRAINT cont_jogador FOREIGN KEY (id_jogador) REFERENCES Jogador(id_jogador)  ON DELETE CASCADE on UPDATE CASCADE,
    CONSTRAINT cont_time FOREIGN KEY (Nome_time) REFERENCES Time_(Nome_time)  ON DELETE CASCADE on UPDATE CASCADE
);

CREATE TABLE Partida (
	Data_ date NOT NULL,
	Resultado INTEGER NOT NULL,
	id_partida INTEGER,
	id_camp INTEGER NOT NULL,
	Nome_time varchar(255) NOT NULL,
	PRIMARY KEY(id_partida,Nome_time),
	CONSTRAINT part_camp FOREIGN KEY (id_camp) REFERENCES Campeonato (id_camp) on UPDATE CASCADE,
	CONSTRAINT part_time FOREIGN KEY (Nome_time) REFERENCES Time_ (Nome_time) on UPDATE CASCADE
);

CREATE TABLE Desempenho (
	RB INTEGER,
	G  INTEGER,
	A  INTEGER,
	SG INTEGER,
	FS INTEGER,
	FF INTEGER,
	FD INTEGER,
	FT INTEGER,
	DD INTEGER,
	DP INTEGER,
	GC INTEGER,
	CV INTEGER,
	CA INTEGER,
	GS INTEGER,
	PP INTEGER,
	FC INTEGER,
	I  INTEGER,  
	PE INTEGER,
	id_desempenho INTEGER PRIMARY KEY AUTO_INCREMENT,
	id_partida INTEGER NOT NULL,
	id_jogador INTEGER NOT NULL,
	Nome_time varchar(255) NOT NULL,
	CONSTRAINT jogad_desemp FOREIGN KEY (id_jogador) REFERENCES Jogador(id_jogador) on UPDATE CASCADE,
	CONSTRAINT part_desemp FOREIGN KEY (id_partida) REFERENCES Partida (id_partida) on UPDATE CASCADE,
	CONSTRAINT desemp_time FOREIGN KEY (Nome_time) REFERENCES Time_ (Nome_time) on UPDATE CASCADE
);

SELECT 'As views estao em um script separado' as '';