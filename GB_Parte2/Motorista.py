# -*- coding: UTF-8 -*-
import mysql.connector as mysql
from datetime import datetime 

class Motorista:
    def reservarCarro():
        cpf = input("Digite seu CPF: ")#ver LOGIN DPS
        renavam = input("Digite o renavam do carro: ")
        query = ("insert into motorista(cpf_motorista,"
            "data_inicio_mot,renavam) values(\"%s\", now(),\"%s\")"%(cpf, renavam))
        return query
    
    def entregarCarro():
        cpf = input("Digite seu CPF: ")#ver LOGIN DPS
        query = ("update motorista set data_fim_mot = now() "
            "where cpf_motorista = \"%s\"" %(cpf))
        return query