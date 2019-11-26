# -*- coding: UTF-8 -*-
import mysql.connector as mysql

class ResumoCondutor():   
    #faz o select na tabela tabela de acordo com parametro blnMotorista
    #se for true faz o select pelo motorista, se for false faz pelo passageiro
    def consultarPerfil(cpf):
        query = ("select * from ResumoCondutor"
            " where cpf_motorista = \"%s\" "%(cpf))
        return query