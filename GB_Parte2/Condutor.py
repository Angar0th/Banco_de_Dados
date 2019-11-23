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
        cpf = "9898778765"#input("Digite o CPF: ")
        nome = "osdan"#input("Digite o nome do condutor: ")
        telefone = "987676765"#input("Digite o telefone: ")
        data = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        query = ("insert into condutor(cpf_motorista, nome_cond, telefone_cond, data_cadastro_cond) values(\"9898778765\",\"osdan\",\"987676765\",now())")#%(cpf, nome, telefone, data))
        self.execute(query)

    def execute(self,query):
        self.cursor.execute(query)
        self.db.commit()
    
    def exit(self):
        self.db.close()