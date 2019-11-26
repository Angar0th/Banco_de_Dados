# -*- coding: UTF-8 -*-
import mysql.connector as mysql

class ResumoVeiculos():   
    #faz o select na tabela tabela de acordo com parametro blnMotorista
    #se for true faz o select pelo motorista, se for false faz pelo passageiro
    def verCarros(cpf):
        query = ("select * from ResumoVeiculo")
        return query