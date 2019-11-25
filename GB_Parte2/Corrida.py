import mysql.connector as mysql
from datetime import datetime 

class Corrida:
    def __init__(self):
        self.db = mysql.connect(user = 'root', 
                        password = 'Lukada852@', 
                        host = '127.0.0.1',
                        database = 'meleva')
        self.cursor = self.db.cursor()

    def realizarCorrida(self):
        origem = input("Digite a sua localização:")
        destino = input("Digite o destino: ")
        tarifa = 50
        distancia = 100
        cpf = input("Digite o seu CPF: ")
        id_motorista = 1
        query = ("insert into corrida (avaliacao_condutor, avaliacao_veiculo, data_inicio_corr, data_fim_corr, origem, destino ,tarifa, distancia_km, id_motorista, cpf_passageiro) values(NULL, NULL, now(), now() + INTERVAL 1 HOUR,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\")"%( origem, destino, tarifa, distancia, id_motorista, cpf))
        self.execute(query)

    def encerrarCorrida(self):
        cpf = input("Digite o seu CPF: ")
        avaliacao_condutor = input("Avalie o condutor:")
        avaliacao_veiculo = input("Avalie o veículo:")
        query = ("UPDATE corrida SET avaliacao_condutor = \"%s\", avaliacao_veiculo = \"%s\", data_fim_corr = now() WHERE cpf_pass = \"%s\")" %(avaliacao_condutor, avaliacao_veiculo, cpf))
        self.execute(query)

    def execute(self,query):
        try:
            self.cursor.execute(query)
            self.db.commit()
            return False
        except (mysql.Error) as e:
            print(e)
            return True
    
    def exit(self):
        self.db.close()