# -*- coding: UTF-8 -*-
import mysql.connector as mysql
from datetime import datetime 
from Motorista import Motorista
from ResumoCorrida import ResumoCorrida

class Condutor:
    def __init__(self):
        self.db = mysql.connect(user = 'root', 
                        password = 'Lukada852@', 
                        host = '127.0.0.1',
                        database = 'meleva')
        self.cursor = self.db.cursor()
        self.motorista = Motorista()
        self.resCorridas = ResumoCorrida()

    def cadastrarCondutor(self):
        cpf = input("Digite o CPF: ")
        nome = input("Digite o nome do condutor: ")
        telefone = input("Digite o telefone: ")
        query = ("insert into condutor(cpf_motorista," 
        "nome_cond, telefone_cond, data_cadastro_cond) "
        "values(\"%s\",\"%s\",\"%s\",now())"%(cpf, nome, telefone) )
        if self.execute(query):
            print('Condutor Cadastrado com sucesso!')
        else:
            print('Erro ao cadastrar, confira as informações digitadas!')
    
    def reservarCarro(self):
       self.motorista.reservarCarro()
    
    def entregarCarro(self):
        self.motorista.entregarCarro()

    def consultarCorridas(self):
        self.resCorridas.consultarCorridas(True)

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
        self.motorista.exit()