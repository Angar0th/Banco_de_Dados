# -*- coding: UTF-8 -*-
from Condutor import Condutor
from Corrida import Corrida
# import Motorista
from Passageiros import Passageiro
# import ResumoCondutor
from ResumoCorrida import resumoCorrida


def printOptions(options):
    while 1:
        for option in options:
            print(option)
        print("------------------------------------")
        print("Digite a opçao que deseja escolher: ")
        option = input()

        try:
            option = int(option)
            return option
        except ValueError:
            print("Opção inválida")
            continue

def askOption(options):
    option = printOptions(options)
    while option < 0 or option > len(options):
        option = printOptions(options)
        print("Opção inválida")

    return option
    
modes = []
modes.append('1- Iniciar como Condutor')
modes.append('2- Iniciar como Passageiro')
modes.append('0- Sair')

condutorMenu = []
condutorMenu.append('1- Cadastrar Condutor')
condutorMenu.append('2- Reservar Carro')
condutorMenu.append('3- Entregar Carro')
condutorMenu.append('4- Consultar corridas')
condutorMenu.append('5- Consultar saldo')
condutorMenu.append('0- Voltar')

passageiroMenu = []
passageiroMenu.append('1- Cadastrar Passageiro')
passageiroMenu.append('2- Iniciar corrida')
passageiroMenu.append('3- Consultar corridas')
passageiroMenu.append('4- Encerrar corrida')
passageiroMenu.append('0- Voltar')

mode = 1
while(mode != 0):
    mode = askOption(modes)
    if mode == 1:#iniciado como condutor
        option = 1
        while(option):
            option = askOption(condutorMenu)
            if option == 1:#cadastrar condutor
                objCondutor = Condutor()
                objCondutor.cadastrarCondutor()
            elif option == 2:#reservar carro
                pass
            elif option == 3:#entregar carro
                pass
            elif option == 4:#consultar corridas
                pass
            elif option == 5:#consultar saldo
                pass

    elif mode == 2:#inciado como passageiro
        option = askOption(passageiroMenu)
        if option == 1:# Cadastrar Passageiro
            objPassageiro = Passageiro()
            objPassageiro.cadastrarPassageiro()            
        elif option == 2:#Iniciar corrida
            objCorrida = Corrida()
            objCorrida.realizarCorrida()
        elif option == 3:#Consultar corridas
            objResumoCorrida = resumoCorrida()
            objResumoCorrida.verCorridas()
        elif option == 4:#Encerrar corrida
            objCorrida = Corrida()
            objCorrida.encerrarCorrida()

print("Tchau!")

