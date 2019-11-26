# -*- coding: UTF-8 -*-
import mysql.connector as mysql
from datetime import datetime 
from ResumoCorrida import ResumoCorrida
from Corrida import Corrida

class Passageiro:
    db = None
    cursor = None
    cpf = None
    nome = None
    def __init__(self):
        self.db = mysql.connect(user = 'root', 
                        password = 'Lukada852@', 
                        host = '127.0.0.1',
                        database = 'meleva')
        self.cursor = self.db.cursor()

    def logar(self):
        self.cpf = input("Digite o CPF: ").strip()
        self.nome = input ('Digite seu nome: ').strip()
        query = ("select * from Passageiros"
            " where nome_pass = \"%s\" and cpf_passageiro = \"%s\"" %(self.nome,self.cpf))
        results = self.select(query)
        if results == [] or results == None:
            print("Usuario ou senha errado!")
            return False
        else:
            print("Bem vind(x) " + self.nome)
            return True   

    def cadastrarPassageiro(self):
        cpf = input("Digite o CPF: ").strip
        nome = input("Digite o nome do passageiro: ").strip
        telefone = input("Digite o telefone: ").strip
        query = ("insert into condutor(cpf_passageiro, nome_pass,"
            "telefone_pass, data_cadastro_pass) "
            "values(\"%s\",\"%s\",\"%s\",now())"%(cpf, nome, telefone))
        if not self.execute(query):
            print("Algo deu errado!")

    def verCorridas(self):
        query = ResumoCorrida.consultarCorridas(False)
        results = self.select (query)
        if results == [] or results == None:
            print("Algo deu errado!")
            return None

        for i in results:
                if(i[7] != None):
                    print("Passageiro: %s, Motorista: %s, Origem: %s, Destino: %s," 
                        " Distância (km): %f, Valor(R$): %f, Inicio: %s, Duração: %s"
                        " Nota ao veículo: %d , Nota ao Condutor: %d"
                        %(i[3],i[1],i[4],i[5],i[6],i[7],
                        str(i[8]),i[9],i[11],i[12]))
        
    def realizarCorrida(self):
        query = Corrida.realizarCorrida()
        if not self.execute(query):
            print("Algo deu errado!")

    def encerrarCorrida(self):
        query = Corrida.encerrarCorrida()
        if not self.execute(query):
            print("Algo deu errado!")

    def realizarCorrida(self):
        query = Corrida.realizarCorrida()
        if not self.execute(query):
            print("Algo deu errado!")

    def execute(self,query):
        try:
            self.cursor.execute(query)
            self.db.commit()
            tbd = self.cursor.fetchall()
            return True
        except (mysql.Error) as e:
            print(e)
            return False
    
    def select(self,query):
        try:
            self.cursor.execute(query)
            tbd = self.cursor.fetchall()
            return tbd
        except (mysql.Error) as e:
            print(e)
            return None
    
    def exit(self):
        self.db.close()