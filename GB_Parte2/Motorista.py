# -*- coding: UTF-8 -*-
import mysql.connector as mysql
from datetime import datetime 

class Motorista:
    def __init__(self):
        self.db = mysql.connect(user = 'root', 
                        password = 'Lukada852@', 
                        host = '127.0.0.1',
                        database = 'meleva')
        self.cursor = self.db.cursor()

    def reservarCarro(self):
        cpf = input("Digite seu CPF: ")#ver LOGIN DPS
        renavam = input("Digite o renavam do carro: ")
        query = ("insert into motorista(cpf_motorista, data_inicio_mot,renavam) values(\"%s\", now(),\"%s\")"%(cpf, renavam) )
        print('----------------------------')
        if self.execute(query):
            print('Carro reservado com sucesso!')
        else:
            print('Erro ao reservar, confira as informações digitadas!')
        print('----------------------------')
    
    def entregarCarro(self):
        cpf = input("Digite seu CPF: ")#ver LOGIN DPS
        query = ("update motorista set data_fim_mot = now() where cpf_motorista = \"%s\"" %(cpf))
        print('----------------------------')
        if self.execute(query):
            print('Carro entregue com sucesso!')
        else:
            print('Erro ao entregar, confira as informações digitadas!')
        print('----------------------------')

    def execute(self,query):
        try:
            self.cursor.execute(query)
            self.db.commit()
            tbd = self.cursor.fetchall()
            return True
        except (mysql.Error) as e:
            print(e)
            return False
    
    def exit(self):
        self.db.close()