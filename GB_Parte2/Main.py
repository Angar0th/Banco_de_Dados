# -*- coding: UTF-8 -*-
from Condutor import Condutor
# import Corrida
# import Motorista
# import Passageiros
# import ResumoCondutor
# import ResumoCorrida


def printOptions(options):
    while 1:
        for option in options:
            print(option)
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

condutorMenu = []
condutorMenu.append('1- Cadastrar Condutor')
condutorMenu.append('2- Reservar Carro')
condutorMenu.append('3- Entregar Carro')
condutorMenu.append('4- Consultar corridas')
condutorMenu.append('5- Consultar saldo')

passageiroMenu = []
passageiroMenu.append('1- Cadastrar Passageiro')
passageiroMenu.append('2- Iniciar corrida')
passageiroMenu.append('3- Consultar corridas')
passageiroMenu.append('4- Encerrar corrida')

mode = askOption(modes)

if mode == 1:
    option = askOption(condutorMenu)
    if option == 1:
        objCondutor = Condutor()
        objCondutor.cadastrarCondutor()
    elif option == 2:
        pass
    elif option == 3:
        pass
    elif option == 4:
        pass
    elif option == 5:
        pass

elif mode == 2:
     option = askOption(passageiroMenu)


