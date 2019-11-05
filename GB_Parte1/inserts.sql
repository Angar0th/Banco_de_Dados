/*INSERTS validos para condutor*/
insert into condutor
values ("12345678901", "Martin Scorcese", "123456789", now()),
       ("12345678902", "Falcão",          "999999991", now()),
       ("12345678903", "Jorge",           "999999992", now()),
       ("12345678904", "Niki Lauda",      "999999993", now()),
       ("12345678905", "James Hunt",      "999999994", now()),
       ("12345678906", "Frank Martin",    "999999995", now()),
       ("12345678908", "Nathanne",        "999999998", now());
/*INSERTS invalidos para condutor (teste)*/
insert into condutor
values ("12345678907", "Marty McFly",   "999999996", "2020-10-11 12:30:01");/*NÃO PERMITE VIAJANTES DO TEMPO SE CADASTRAREM (data de cadastro > now())*/
update condutor set data_cadastro_cond = DATE_ADD(now(), INTERVAL 1 SECOND) where cpf_motorista = "12345678901";/*NÃO PERMITE VIAJANTES DO TEMPO SE CADASTRAREM (data de cadastro > now())*/


/*INSERTS validos para passageiros*/
insert into passageiros
values  ("Kobayashi",    "012345678", now(), "01234567890"),
        ("Kanna",        "012345679", now(), "01234567891"),
        ("Arthur Fleck", "012345680", now(), "01234567892"),
        ("Tooruh",       "012345681", now(), "01234567893"),
        ("Senku",        "012345682", now(), "01234567894");
/*INSERTS invalidos para passageiros*/
insert into passageiros
values ("Doc Brown", "012345683", "2020-10-11 12:30:01", "01234567895");/*NÃO PERMITE VIAJANTES DO TEMPO SE CADASTRAREM (data de cadastro > now())*/
update passageiros set data_cadastro_pass = DATE_ADD(now(), INTERVAL 1 SECOND) where cpf_passageiro = "01234567890";/*NÃO PERMITE VIAJANTES DO TEMPO SE CADASTRAREM (data de cadastro > now())*/


/*INSERTS validos para veiculo*/
insert into veiculo
values ("012345678", "abc0f12", "Tesla Motors", "Roadster"       , 2015),
       ("012345679", "abc0f13", "Tesla Motors", "Roadster"       , 2015),
       ("012345680", "abc0f14", "Tesla Motors", "Model S"        , 2017),
       ("012345681", "abc0f15", "Tesla Motors", "Model S"        , 2017),
       ("012345682", "abc0f16", "Tesla Motors", "Model S"        , 2017),
       ("012345683", "abc0f17", "Tesla Motors", "Model X"        , 2018),
       ("012345684", "abc0f18", "Tesla Motors", "Model X"        , 2018),
       ("012345685", "abc0f19", "Tesla Motors", "Model X"        , 2018),
       ("012345686", "abc0f20", "Tesla Motors", "Model 3"        , 2019),
       ("012345687", "abc0f21", "Tesla Motors", "Model 3"        , 2019),
       ("012345688", "abc0f22", "Tesla Motors", "Model 3"        , 2019),
       ("012345689", "abc0023", "Fiat",         "Palio"          , 2015),
       ("012345690", "abc0024", "Fiat",         "Uno Sem escada" , 2015),
       ("012345691", "abd0025", "Fiat",         "Uno Com Escada" , 2015),
       ("012345692", "abe0026", "Fiat",         "Fiorino"        , 2001),
       ("012345693", "abe0146", "Chevrolet",    "Corsa"          , 1998),
       ("012345694", "abe0147", "Chevrolet",    "Prisma"         , 2012),
       ("012345695", "abe0148", "Chevrolet",    "Camaro"         , 2012);


/*INSERTS validos para motorista*/
insert into motorista (data_inicio_mot, data_fim_mot,renavam,cpf_motorista)
values (now(), now(), "012345678", "12345678901"),
       (now(), now(), "012345679", "12345678902"),
       (now(), now(), "012345680", "12345678903"),
       (now(), now(), "012345681", "12345678904"),
       (now(), now(), "012345682", "12345678905"),
       (now(), null,  "012345682", "12345678906");
/*INSERTS e UPDATES invalidos para motorista*/
insert into motorista (data_inicio_mot, data_fim_mot,renavam,cpf_motorista) values (now(), null, "012345682", "12345678908");/*NÃO PERMITE RETIRAR UM VEICULO QUE JÁ ESTÁ RETIRADO*/
update motorista set data_fim_mot = DATE_ADD(now(), INTERVAL 1 SECOND) where id_motorista = 6;/*NÃO PERMITE DAR UPDATE COM DATAS NO FUTURO*/
update motorista set data_inicio_mot = DATE_ADD(now(), INTERVAL 1 SECOND) where id_motorista = 6;/*NÃO PERMITE DAR UPDATE COM DATAS NO FUTURO*/
update motorista set data_fim_mot = null where id_motorista = 1;/*NÃO PERMITE MUDAR DATAS VALIDAS PARA NULL*/
update motorista set data_fim_mot = DATE_SUB(data_inicio_mot, INTERVAL 1 SECOND) where id_motorista = 6;/*NÃO PERMITE DAR UPDATE COM DATAS MENORES DO QUE INICIAL*/
insert into motorista (data_inicio_mot, data_fim_mot,renavam,cpf_motorista) values (now(), null, "012345683", "12345678906");/*Não permite retirar mais de um veiculo ao mesmo tempo*/

/*INSERTS validos para corrida*/
insert into corrida (avaliacao_condutor
                     ,avaliacao_veiculo
                     ,data_inicio_corr
                     ,data_fim_corr
                     ,origem
                     ,destino
                     ,tarifa
                     ,distancia_km
                     ,id_motorista
                     ,cpf_passageiro)
values  (5,5,      "2019-10-11 12:30:01", "2019-10-11 12:29:31", "sapiranga",       "sapiranga",          0.3, 0.5, 1, "01234567890"),
        (1,4,      "2019-10-12 12:30:01", "2019-10-12 12:41:31", "novo hamburgo",   "novo hamburgo",      0.6, 0.7, 2, "01234567891"),
        (3,2,      "2019-10-13 12:30:01", "2019-10-13 12:41:31", "são leopoldo",    "novo hamburgo",      0.8, 0.8, 3, "01234567892"),
        (4,1,      "2019-10-14 12:30:01", "2019-10-14 12:41:31", "campo bom",       "campo bom",          0.9, 0.9, 4, "01234567893"),
        (0,0,      "2019-10-15 12:30:01", "2019-10-15 12:41:31", "porto alegre",    "porto alegre",       0.6, 0.1, 5, "01234567894"),
        (2,4,      "2019-10-16 12:30:01", "2019-10-16 12:41:31", "canoas",          "canoas",             0.1, 0.3, 1, "01234567891"),
        (3,4,      "2019-10-17 12:30:01", "2019-10-17 12:41:31", "esteio",          "canoas",             0.2, 0.4, 2, "01234567891"),
        (4,5,      "2019-10-18 12:30:01", "2019-10-18 12:41:31", "sapucaia do sul", "são leopoldo",       0.3, 0.5, 3, "01234567891"),
        (1,4,      "2019-10-19 12:30:01", "2019-10-19 12:41:31", "sapiranga",       "sapiranga",          0.5, 0.6, 4, "01234567892"),
        (1,4,      "2019-10-20 12:30:01", "2019-10-20 12:41:31", "sapiranga",       "sapiranga",          0.7, 1.7, 5, "01234567892"),
        (null,null,"2019-10-20 12:30:01",  null,                 "sapiranga",       "sapiranga",          0.7, 1.7, 5, "01234567892"),
        (null,null,"2019-10-20 12:30:01",  null,                 "sapiranga",       "sapiranga",          0.7, 1.7, 1, "01234567891");
/*INSERTS invalidos para corrida*/
insert into corrida (avaliacao_condutor
                     ,avaliacao_veiculo
                     ,data_inicio_corr
                     ,data_fim_corr
                     ,origem
                     ,destino
                     ,tarifa
                     ,distancia_km
                     ,id_motorista
                     ,cpf_passageiro)
values (null,null,"2019-10-20 12:30:01", null,                  "sapiranga",       "sapiranga",          0.7, 1.7, 1, "01234567892");/*Não permite o passageiro iniciar uma viagem antes de terminar a atual*/
insert into corrida (avaliacao_condutor
                     ,avaliacao_veiculo
                     ,data_inicio_corr
                     ,data_fim_corr
                     ,origem
                     ,destino
                     ,tarifa
                     ,distancia_km
                     ,id_motorista
                     ,cpf_passageiro)
values (null,null,"2019-10-20 12:30:01",  null,                 "sapiranga",       "sapiranga",          0.7, 1.7, 5, "01234567890");/*Não permite o condutor iniciar uma viagem antes de terminar a atual*/
update corrida set data_fim_corr =  DATE_ADD(now(), INTERVAL 1 SECOND) where id_corrida = 11;/*NÃO PERMITE DAR UPDATE COM DATAS NO FUTURO*/
update corrida set data_inicio_corr =  DATE_ADD(now(), INTERVAL 1 SECOND) where id_corrida = 11;/*NÃO PERMITE DAR UPDATE COM DATAS NO FUTURO*/
update corrida set data_fim_corr = DATE_SUB(data_inicio_corr, INTERVAL 1 SECOND) where id_corrida = 11;/*NÃO PERMITE DAR UPDATE COM DATAS MENORES DO QUE INICIAL*/
update corrida set data_fim_corr = null where id_corrida = 4;/*NÃO PERMITE MUDAR DATAS VALIDAS PARA NULL*/
