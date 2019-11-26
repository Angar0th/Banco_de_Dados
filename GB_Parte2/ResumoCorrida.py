# -*- coding: UTF-8 -*-
import mysql.connector as mysql

class ResumoCorrida():   
    #faz o select na tabela tabela de acordo com parametro blnMotorista
    #se for true faz o select pelo motorista, se for false faz pelo passageiro
    def consultarCorridas(blnMotorista,cpf):
        if blnMotorista:
            query = ("select * from ResumoCorrida "
                "where cpf_motorista = %s "%(cpf))
        else:
            query = ("select * from ResumoCorrida " 
                "where cpf_passageiro = %s "%(cpf))
        return query