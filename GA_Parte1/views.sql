drop view if exists ResumoCorrida;

create view ResumoCorrida (Cpf_motorista, Nome_Motorista, cpf_passageiros, nome_passageiro, origem, destino, 
        distância, valor, horário de início, tempo de duração, placa_veículo, avaliação_veículo, avaliação_condutor)

    select cpf_passageiros, avaliação_veículo, avaliação_condutor, origem, destino, data_inicio, data_fim, tarifa, distancia, valor
    motorista.cpf_motorista, condutor.nome_motorista from Corrida C
    inner join motorista on motorista.id_motorista = corrida.id_motorista
    inner join condutor on motorista.cpf_motorista = condutor.cpf_motorista
    natural join Passageiros;        

drop view if exists ResumoCondutor ;

create view ResumoCondutor (Cpf_motorista, Nome_Motorista, aval, média, cont_corrida, salario)

    select Cpf_motorista, Nome_Motorista, count(corrida.avaliação_condutor) as aval, avg(corrida.avaliação_condutor) as media, count(corrida.Cpf_motorista) as cont_corrida, 
    corrida.distancia, 

    from Condutor
    
    natural join corrida


    inner join (select ( (5 + 𝑑𝑖𝑠𝑡â𝑛𝑐𝑖𝑎 × 0,8 + 𝑚𝑖𝑛𝑢𝑡𝑜𝑠𝑡𝑜𝑡𝑎𝑖𝑠 × 0,2) × 𝑡𝑎𝑟𝑖𝑓𝑎) as valor from Corrida where corrida.cpf_motorista = motorista.cpf_motorista)

create view ResumoVeiculo (renavam, placa, modelo, ano, media_carro, aval_corrida)

    select renavam, placa, modelo, ano from veiculo
    inner join (select count(placa) as cont_carro from veiculo where veiculo.renavam = motorista.renavam)
    inner join (select avg(avaliação_veiculo) as media_carro from Corrida where corrida.renavam = motorista.renavam)
    inner join (select count(avaliação_veiculo) as aval_corrida from Corrida where corrida.renavam = motorista.renavam)
