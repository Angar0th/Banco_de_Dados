import mysql.connector as mysql
from datetime import datetime 

class Condutor:
    def __init__(self):
        self.db = mysql.connect(user = 'root', 
                        password = 'Lukada852@', 
                        host = '127.0.0.1',
                        database = 'meleva')
        self.cursor = self.db.cursor()

    def cadastrarCondutor(self):
        cpf = input("Digite o CPF: ")
        nome = input("Digite o nome do condutor: ")
        telefone = input("Digite o telefone: ")
        query = ("insert into condutor(cpf_motorista, nome_cond, telefone_cond, data_cadastro_cond) values(\"%s\",\"%s\",\"%s\",now())"%(cpf, nome, telefone) )
        self.execute(query)

    def execute(self,query):
        try:
            self.cursor.execute(query)
            self.db.commit()
        except (mysql.Error) as e:
            print(e)
        return None
    
    def exit(self):
        self.db.close()