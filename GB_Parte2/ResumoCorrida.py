# -*- coding: UTF-8 -*-
import mysql.connector as mysql
from datetime import datetime 

class ResumoCorrida():
    def __init__(self):
        self.db = mysql.connect(user = 'root', 
                        password = 'Lukada852@', 
                        host = '127.0.0.1',
                        database = 'meleva')
        self.cursor = self.db.cursor()
    
    def consultarCorridas(self,blnMotorista):
        cpf = input("Digite o CPF: ").strip()
        if blnMotorista:
            query = ("select * from ResumoCorrida where cpf_motorista = %s "%(cpf))
        else:
            query = ("select * from ResumoCorrida where cpf_passageiro = %s "%(cpf))
        self.execute(query)
    
    def execute(self,query):
        try:
            self.cursor.execute(query)
            tbd = self.cursor.fetchall()
            for i in tbd:
                if(i[7] != None):
                    print("Motorista: %s, Passageiro: %s, Origem: %s, Destino: %s," 
                        " Distância (km): %f, Valor(R$): %f, Inicio: %s, Duração: %s"
                        " Nota ao veículo: %d , Nota ao Condutor: %d"
                        %(i[1],i[3],i[4],i[5],i[6],i[7],
                        str(i[8]),i[9],i[11],i[12]))
            return True
        except (mysql.Error) as e:
            print(e)
            return False
    
    def exit(self):
        self.db.close()
        self.motorista.exit()