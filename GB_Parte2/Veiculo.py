import Connector.Connector

class Veiculo:
    def __init__(self):
        self.connector = Connector()
    
    def getCarInfos(self,id):
        query = "select * from Condutor where " + " renavam=" + id  
        result = self.connector.selectAll(query)
        return 
