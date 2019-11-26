# -*- coding: UTF-8 -*-
import mysql.connector as mysql
from datetime import datetime 

class Motorista:
    def reservarCarro(cpf):
        renavam = input("Digite o renavam do carro: ")
        query = ("insert into motorista(cpf_motorista,"
            "data_inicio_mot,renavam) values(\"%s\", now(),\"%s\")"%(cpf, renavam))
        return query
    
    def entregarCarro(cpf):
        query = ("update motorista set data_fim_mot = now() "
            "where cpf_motorista = \"%s\"" %(cpf))
        return query