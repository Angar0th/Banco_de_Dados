# -*- coding: UTF-8 -*-
import mysql.connector as mysql
from datetime import datetime 
import random

class Corrida:
    def realizarCorrida():
        origem = input("Digite a sua localização:").strip()
        destino = input("Digite o destino: ").strip()
        tarifa = random.random() * 2
        distancia = random.random() * 5
        cpf = input("Digite o seu CPF: ").strip()
        id_motorista = int(input("Id Motorista: ").strip())
        query = ("insert into corrida"
            "(data_inicio_corr, origem, destino ,tarifa, distancia_km,"
            " id_motorista, cpf_passageiro) values(now(),"
            "\"%s\",\"%s\",%f,%f,%d,\"%s\")"%( origem, destino, 
            tarifa, distancia, id_motorista, cpf))
        return query

    def encerrarCorrida():
        cpf = input("Digite o seu CPF: ").strip()
        avaliacao_condutor = input("Avalie o condutor: ").strip()
        avaliacao_veiculo = input("Avalie o veículo: ").strip()
        query = ("UPDATE corrida SET avaliacao_condutor = \"%s\","
            "avaliacao_veiculo = \"%s\", data_fim_corr = now()"
            "WHERE cpf_pass = \"%s\")" %(avaliacao_condutor, avaliacao_veiculo, cpf))
        return query