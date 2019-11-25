import mysql.connector as mysql
from datetime import datetime 

class resumoCorrida:
    def __init__(self):
        self.db = mysql.connect(user = 'root', 
                        password = 'Lukada852@', 
                        host = '127.0.0.1',
                        database = 'meleva')
        self.cursor = self.db.cursor()

    def verCorridas(self):
        cpf = input("Digite o seu cpf para consultar suas corridas")
        query = ("SELECT * FROM corrida WHERE cpf_pass = \"%s\")" %(cpf))
        self.cursor.execute(query)
        return self.cursor.fetchone()

    def execute(self,query):
        try:
            self.cursor.execute(query)
            tbt = self.cursor.fetchall()
            print(tbt)
            return True
        except (mysql.Error) as e:
            print(e)
            return False
    
    def exit(self):
        self.db.close()