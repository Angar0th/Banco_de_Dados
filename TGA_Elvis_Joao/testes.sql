INSERT INTO Jogador(Nome_jogador,Posicao) VALUES ("Elvis Bugs","Zagueiro");
INSERT INTO Jogador(Nome_jogador,Posicao) VALUES ("João Hoffmann","Atacante");
INSERT INTO Jogador(Nome_jogador,Posicao) VALUES ("Armando Keller","Meio-campo");
INSERT INTO Jogador(Nome_jogador,Posicao) VALUES ("Joaquim Uzumaki","Goleiro");
INSERT INTO Jogador(Nome_jogador,Posicao) VALUES ("Gabriel Becker","Atacante");
INSERT INTO Jogador(Nome_jogador,Posicao) VALUES ("Renato Uchiha","Lateral");
INSERT INTO Jogador(Nome_jogador,Posicao) VALUES ("Paolo Guerreiro","Atacante");

insert into Time_(Nome_time) values ("Grêmio"				);
insert into Time_(Nome_time) values ("Inter"				);
insert into Time_(Nome_time) values ("Palmeiras"	        );
insert into Time_(Nome_time) values ("Corinthians"	        );
insert into Time_(Nome_time) values ("São Paulo"	        );
insert into Time_(Nome_time) values ("Santos"			    );
insert into Time_(Nome_time) values ("Fluminense"		    );
insert into Time_(Nome_time) values ("Flamengo"			    );
insert into Time_(Nome_time) values ("Vasco"			    );
insert into Time_(Nome_time) values ("Botafogo"				);
insert into Time_(Nome_time) values ("Atlético-Paranaense"	);
insert into Time_(Nome_time) values ("Atlético-Mineiro"		);
insert into Time_(Nome_time) values ("Cruzeiro"				);

INSERT INTO Contrato(Nome_time,id_jogador) VALUES ("Inter",1);
INSERT INTO Contrato(Nome_time,id_jogador) VALUES ("Grêmio",2);
INSERT INTO Contrato(Nome_time,id_jogador) VALUES ("Palmeiras",3);
INSERT INTO Contrato(Nome_time,id_jogador) VALUES ("São Paulo",4);
INSERT INTO Contrato(Nome_time,id_jogador) VALUES ("Flamengo",5);
INSERT INTO Contrato(Nome_time,id_jogador) VALUES ("Flamengo",6);
INSERT INTO Contrato(Nome_time,id_jogador) VALUES ("Inter",7);

INSERT INTO Campeonato(Nome_camp,Ano) VALUES ("Brasileiro",2019);
INSERT INTO Campeonato(Nome_camp,Ano) VALUES ("Libertadores",2019);
INSERT INTO Campeonato(Nome_camp,Ano) VALUES ("Copa do Brasil",2019);
INSERT INTO Campeonato(Nome_camp,Ano) VALUES ("Copa do Brasil",2021);

INSERT INTO Partida(Data_,Resultado,id_partida,id_camp,Nome_time)
 VALUES ("2019-10-02",2,1,1,"Inter");
 INSERT INTO Partida(Data_,Resultado,id_partida,id_camp,Nome_time)
 VALUES ("2019-10-02",3,3,3,"Inter");
INSERT INTO Partida(Data_,Resultado,id_partida,id_camp,Nome_time)
 VALUES ("2019-10-02",0,1,1,"Grêmio");
INSERT INTO Partida(Data_,Resultado,id_partida,id_camp,Nome_time)
 VALUES ("2019-10-02",3,2,1,"Palmeiras");
INSERT INTO Partida(Data_,Resultado,id_partida,id_camp,Nome_time)
 VALUES ("2019-10-02",0,2,1,"São Paulo");

 INSERT INTO Desempenho
 (RB,G,A,SG,FS,FF,FD,FT,DD,DP,GC,CV,CA,GS,PP,FC,I,PE,id_partida,id_jogador,Nome_time)
 values
 (1,4,3,4,5,6,7,8,9,0,7,8,9,1,3,4,42,3,1,1,"Inter");
 INSERT INTO Desempenho
(RB,G,A,SG,FS,FF,FD,FT,DD,DP,GC,CV,CA,GS,PP,FC,I,PE,id_partida,id_jogador,Nome_time)
 values
 (1,1,3,4,5,6,7,8,9,8,7,8,9,7,3,4,42,3,1,2,"Grêmio");
 INSERT INTO Desempenho
 (RB,G,A,SG,FS,FF,FD,FT,DD,DP,GC,CV,CA,GS,PP,FC,I,PE,id_partida,id_jogador,Nome_time)
 values
 (1,2,3,4,5,6,7,8,9,3,7,8,9,1,3,4,42,3,2,3,"Palmeiras");
 INSERT INTO Desempenho
 (RB,G,A,SG,FS,FF,FD,FT,DD,DP,GC,CV,CA,GS,PP,FC,I,PE,id_partida,id_jogador,Nome_time)
 values
 (1,0,3,4,5,6,7,8,9,1,7,8,9,200,3,4,42,3,2,4,"São Paulo");
  INSERT INTO Desempenho
 (RB,G,A,SG,FS,FF,FD,FT,DD,DP,GC,CV,CA,GS,PP,FC,I,PE,id_partida,id_jogador,Nome_time)
 values
 (1,1,3,4,5,6,7,8,9,0,7,8,9,7,3,4,42,3,2,7,"Inter");
 INSERT INTO Desempenho
 (RB,G,A,SG,FS,FF,FD,FT,DD,DP,GC,CV,CA,GS,PP,FC,I,PE,id_partida,id_jogador,Nome_time)
 values
 (1,1,3,4,5,6,7,8,9,0,7,8,9,7,3,4,42,3,3,7,"Inter");

SELECT 'Acabou, nao tem mais scripts para rodar' as '';
 
