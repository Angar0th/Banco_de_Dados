# -*- coding: UTF-8 -*-
import mysql.connector as mysql
from datetime import datetime 
from Motorista import Motorista
from ResumoCorrida import ResumoCorrida
from ResumoCondutor import ResumoCondutor
from ResumoVeiculos import ResumoVeiculos

class Condutor:
    cpf = None
    nome = None
    db = None
    cursor = None

    def __init__(self):
        self.db = mysql.connect(user = 'root', 
                        password = 'Lukada852@', 
                        host = '127.0.0.1',
                        database = 'meleva')
        self.cursor = self.db.cursor()
        
    def logar(self):
        self.cpf = input("Digite o CPF: ").strip()
        self.nome = input ('Digite seu nome: ').strip()
        query = ("select * from Condutor"
            " where nome_cond = \"%s\" and cpf_motorista = \"%s\"" %(self.nome,self.cpf))
        results = self.select(query)
        if results == []:
            print("Usuario ou cpf errado!")
            return False
        else:
            print("Bem vind(x) " + self.nome)
            return True   

    def cadastrarCondutor(self):
        self.cpf = input("Digite o CPF: ")
        self.nome = input("Digite o nome do condutor: ")
        telefone = input("Digite o telefone: ")
        query = ("insert into condutor(cpf_motorista," 
        "nome_cond, telefone_cond, data_cadastro_cond) "
        "values(\"%s\",\"%s\",\"%s\",now())"%(self.cpf, self.nome, telefone) )
        if self.execute(query):
            print('Condutor Cadastrado com sucesso!')
            return True
        else:
            print('Erro ao cadastrar, confira as informações digitadas!')
            return False
    
    def reservarCarro(self):
       query = Motorista.reservarCarro(self.cpf)
       if self.execute(query):
            print('Carro Reservado com sucesso!')
       else:
            print('Erro, confira as informações digitadas!')           
    
    def entregarCarro(self):
        query = Motorista.entregarCarro(self.cpf)
        if self.execute(query):
            print('Carro entregue com sucesso!')
        else:
            print('Erro, confira as informações digitadas!')

    def consultarCorridas(self):
        query = ResumoCorrida.consultarCorridas(True,self.cpf)
        results = self.select(query)

        #se algo foi digitado errado
        if results == []:
            print('Não há corridas para mostrar!')
            return None

        for i in results:
            if(i[7] != None):
                print("Motorista: %s, Passageiro: %s, Origem: %s, Destino: %s," 
                    " Distância (km): %f, Valor(R$): %f, Inicio: %s, Duração: %s"
                    " Nota ao veículo: %d , Nota ao Condutor: %d"
                    %(i[1],i[3],i[4],i[5],i[6],i[7],
                    str(i[8]),i[9],i[11],i[12]))

    def consultarPerfil(self):
        query = ResumoCondutor.consultarPerfil(self.cpf)
        results = self.select(query)

        if results == []:
            print("Não há Corridas realizadas ainda")
            return None

        result = results [0]
        cpf = result[0]
        nome = result[1]
        qtd_aval = 0 if result[2] == None else result[2]
        media_aval = 0 if result[3] == None else float(result[3])
        qtd_corr = 0 if result[4] == None else result[4]
        saldo = 0 if result[5] == None else result[5]
        
        print("Motorista: %s, CPF: %s, Qtd. Aval.: %d, Media Aval.: %f, "
            "Qtd. Corrida: %d, Saldo Gerado: %f"
            %(nome,cpf,qtd_aval,media_aval,qtd_corr,saldo))

    def verCarros(self):
        query = ResumoVeiculos.verCarros(self.cpf)
        results = self.select(query)

        if results == []:
                print("Algo não se saiu muito bem, tente novamente mais tarde!")
                return None

        for result in results:
            renavam = result [0]
            placa = result [1]
            marca = result[2]
            modelo = result[3]
            ano = 0 if result[4] == None else result[4]
            qtd_aval = result[5]
            qtd_corrida = result[6]
            media_aval = 0 if result[7] == None else float(result[7])
            print("Renavam: %s, Placa: %s, Marca: %s, Modelo: %s, Ano: %d, "
                "Qtd. Aval.: %d, Qtd. Corrida: %d, Media Aval.: %f"
            %(renavam,placa,marca,modelo,ano,qtd_aval,qtd_corrida,media_aval))
            if(modelo == 'Delorean' and ano == 1985):
                print("             __---~~~~--__                      __--~~~~---__")
                print("            `\\---~~~~~~~~\\\\                    //~~~~~~~~---/")
                print("              \\/~~~~~~~~~\\||                  ||/~~~~~~~~~\\/ ")
                print("                          `\\\\                //\'")
                print("                            `\\\\            //\'")
                print("                              ||          ||      Hey Doc!")
                print("                    ______--~~~~~~~~~~~~~~~~~~--______       ")
                print("               ___ // _-~                        ~-_ \\\\ ___  ")
                print("              `\\__)\\/~                              ~\\/(__/\' ")
                print("               _--`-___                            ___-\'--_  ")
                print("             /~     `\\ ~~~~~~~~------------~~~~~~~~ /\'     ~\\")
                print("            /|        `\\                          /\'        |\\")
                print("           | `\\   ______`\\_         DMC        _/\'______   /\' |")
                print("           |   `\\_~-_____\\ ~-________________-~ /_____-~_/\'   |")
                print("           `.     ~-__________________________________-~     .\'")
                print("            `.      [_______/------|~~|------\\_______]      .\'")
                print("             `\\--___((____)(________\\/________)(____))___--/\'")
                print("              |>>>>>>||                            ||<<<<<<|")
                print("              `\\<<<<</\'                            `\\>>>>>/\' ")
                print("\n           Roads? Where We're Going We Don't Need Roads!\n")
                
    def execute(self,query):
        try:
            self.cursor.execute(query)
            self.db.commit()
            return True
        except (mysql.Error) as e:
            print(e)
            return False

    def select(self,query):
        try:
            self.cursor.execute(query)
            results = self.cursor.fetchall()
            return results
        except (mysql.Error) as e:
            print(e)
            return None

    def exit(self):
        self.db.close()