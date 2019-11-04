CREATE VIEW GolsPorTime(Gols,Nome_jogador,Nome_time) as
	SELECT sum(Desempenho.G) as Gols, Jogador.Nome_jogador, Desempenho.Nome_time
	FROM (Desempenho
	INNER JOIN Jogador ON Desempenho.id_jogador = Jogador.id_jogador)
	GROUP BY Desempenho.id_jogador, Desempenho.nome_time
	ORDER BY Nome_jogador asc;
	
create view GolsPorCampeonatoAtleta(Gols,Nome_jogador,Nome_time,Nome_camp) as
	SELECT sum(Desempenho.G) as Gols, Jogador.Nome_jogador, Desempenho.Nome_time, Campeonato.Nome_camp
		FROM (((Desempenho
		INNER JOIN Partida ON Desempenho.id_partida = Partida.id_partida)
		INNER JOIN Campeonato ON Partida.id_camp = Campeonato.id_camp)
		INNER JOIN Jogador ON Desempenho.id_jogador = Jogador.id_jogador)
		GROUP BY Desempenho.id_jogador, Partida.id_camp, Desempenho.nome_time
		ORDER BY Nome_jogador asc;
		
CREATE VIEW GolsPorCampeonatoTime(Nome_time,Nome_camp, GolsFeitos, GolsSofridos, SaldoGols) as
	SELECT  
		Desempenho.Nome_time
		,Campeonato.Nome_camp
		,sum(Desempenho.G) as Gols
		,sum(Desempenho.GS) as GolsSofridos
		,sum(Desempenho.G-Desempenho.GS) as SG
	FROM ((Desempenho
	INNER JOIN Partida ON Desempenho.id_partida = Partida.id_partida)
	INNER JOIN Campeonato ON Partida.id_camp = Campeonato.id_camp)
	GROUP BY Desempenho.nome_time,Campeonato.id_camp;
	
CREATE VIEW ItensPorJogador(G,RB,A,SG,FS,FF,FD,FT,DD,DP,GC,CV,CA,GS,PP,FC, I, PE,Nome_time, Nome_jogador, Nome_camp) as
	SELECT sum(Desempenho.G) as G 
	  ,sum(Desempenho.RB) as RB
	  ,sum(Desempenho.A) as A
	  ,sum(Desempenho.SG) as SG
	  ,sum(Desempenho.FS) as FS
	  ,sum(Desempenho.FF) as FF
	  ,sum(Desempenho.FD) as FD
	  ,sum(Desempenho.FT) as FT
	  ,sum(Desempenho.DD) as DD
	  ,sum(Desempenho.DP) as DP
	  ,sum(Desempenho.GC) as GC 
	  ,sum(Desempenho.CV) as CV
	  ,sum(Desempenho.CA) as CA
	  ,sum(Desempenho.GS) as GS
	  ,sum(Desempenho.PP) as PP
	  ,sum(Desempenho.FC) as FC
	  ,sum(Desempenho.I) as I
	  ,sum(Desempenho.PE) as PE
	  ,Desempenho.Nome_time
	  ,Jogador.Nome_jogador
	  ,Campeonato.Nome_camp
	FROM (((Desempenho
	INNER JOIN Partida ON Desempenho.id_partida = Partida.id_partida)
	INNER JOIN Jogador ON Desempenho.id_jogador = Jogador.id_jogador)
	INNER JOIN Campeonato ON Partida.id_camp = Campeonato.id_camp)
	GROUP BY Desempenho.id_jogador, Partida.id_camp, Desempenho.nome_time;
	
	SELECT 'A insercao dos dados esta em um script separado' as '';
