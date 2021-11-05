import mysql.connector


class CRUD:

    banco = None 
    cursor = None
    tabela = None
    
    def novo(self):
        raise Exception ("Função CRIAR não implementada")
    
    def ler(self):
        raise Exception("Função LER não implementada")
    
    def atualizar(self):
        raise Exception("Função ATUALIZAR não implementada")

    def apagar(self):
        raise Exception("Função APAGAR não implementada")
     


class Marinheiro(CRUD):
    
    banco = None
    cursor = None
    tabela = "Marinheiros"

    def __init__(self,dados=None):
        Marinheiro.banco = super().banco
        Marinheiro.cursor = super().cursor
        if dados == None:
            self.__id_marin     = None
            self.__nome_marin   = None
            self.__avaliacao    = None
            self.__idade        = None
        else:
            self.fromTuple(dados)

    
    @property
    def id_marin(self):
        return self.__id_marin
    
    @property
    def nome_marin(self):
        return self.__nome_marin
    
    @nome_marin.setter
    def nome_marin(self,nome):
        self.__nome_marin = nome
        self.atualizar()

    @property
    def avaliacao(self):
        return self.__avaliacao
    
    @avaliacao.setter
    def avaliacao(self,avaliacao):
        self.__avaliacao = avaliacao
        self.atualizar()
    
    @property
    def idade(self):
        return self.__idade
    
    @idade.setter
    def idade(self,idade):
        self.__idade = idade
        self.atualizar()
    
    def novo(self, nome = None, avaliacao = None, idade = None):
        self.cursor.execute(f"INSERT INTO {self.tabela} (nome_marin,avaliacao,idade) values (%s,%s,%s)",(nome,avaliacao,idade,))
        self.banco.commit()
        self.__id_marin = self.cursor.lastrowid
        


    def ler(self,id=None):
        if id:
            self.cursor.execute(f"SELECT * FROM {self.tabela} WHERE id_marin=%s",(id,))    
        elif self.__nome_marin != None:
            self.cursor.execute(f"SELECT * FROM {self.tabela} WHERE id_marin=%s",(self.__id_marin,))
        else:
            raise Exception("Necessário passar o ID_MARIN")
        resultado = self.cursor.fetchone()
        self.fromTuple(resultado)

    def atualizar(self):
        if self.__id_marin:
            self.cursor.execute(f"UPDATE {self.tabela} SET nome_marin=%s, idade=%s, avaliacao=%s WHERE id_marin=%s",(self.__nome_marin, self.__idade, self.__avaliacao, self.__id_marin,))
            self.banco.commit()
            return self.cursor.rowcount
        else:
            raise Exception("É necessário possuir um ID_MARIN para atualizar")
    
    def apagar(self):
        if self.__id_marin:
            pass # SQL apagar e zerar o id
        else:
            raise Exception("Necessário ID_MARIN para remover")
    
    def fromTuple(self,dados):
        if len(dados) == 4:
            self.__id_marin = dados[0]
            self.__nome_marin = dados[1]
            self.__avaliacao= dados[2]
            self.__idade = dados[3] 

    def toTuple(self):
        if self.__id_marin:
            return (self.__id_marin,self.__nome_marin, self.__avaliacao, self.__idade)
    
    def __str__(self):
        return f""" ---------------Marinheiro---------------
        id_marin:\t{self.__id_marin}
        nome_marin:\t{self.__nome_marin}
        avaliação:\t{self.__avaliacao}
        idade:\t{self.__idade}"""



if __name__ == "__main__":
    
    CRUD.banco = mysql.connector.connect(
        host = "127.0.0.1",
        user = "usuario",
        passwd = "#Senha123",
        database = "marinheiros"
    )
    CRUD.cursor = CRUD.banco.cursor()
    
    CRUD.cursor.execute("SELECT * FROM Marinheiros")

    marinheiros = [Marinheiro(dados=item) for item in CRUD.cursor.fetchall()]
    
    for m in marinheiros:
        print(m)

    #m1 = Marinheiro()
    #m1.ler(22)
    #m1.idade = 45
    

