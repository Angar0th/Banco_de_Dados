# -*- coding: UTF-8 -*-
from Condutor import Condutor
# import Corrida
#import Passageiros import Passageiro
# import ResumoCondutor
# import ResumoCorrida


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
condutorMenu.append('5- Resumo do Perfil')
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
        objCondutor = Condutor()
        while(option):
            option = askOption(condutorMenu)
            if option == 1:#cadastrar condutor
                objCondutor.cadastrarCondutor()
            elif option == 2:#reservar carro
                objCondutor.reservarCarro()
            elif option == 3:#entregar carro
                objCondutor.entregarCarro()
            elif option == 4:#consultar corridas
                objCondutor.consultarCorridas()
            elif option == 5:#consultar saldo
                pass
            else:
                del objCondutor

    elif mode == 2:#inciado como passageiro
        option = askOption(passageiroMenu)
        objPassageiro = Passageiros()
        while(option):
            if option == 1:# Cadastrar Passageiro
                objPassageiro.cadastrarCondutor()
            elif option == 2:#Iniciar corrida
                pass
            elif option == 3:#Consultar corridas
                pass
            elif option == 4:#Encerrar corrida
                pass
            else:
                del objPassageiro

print("Tchau!")

