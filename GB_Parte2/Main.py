# -*- coding: UTF-8 -*-
from Condutor import Condutor
from Passageiros import Passageiro

def loginScreen(funcLogin, funcCadastro, listLogin):
    loginOption = 1
    while(loginOption != 0):
        loginOption = askOption(listLogin)
        if loginOption == 1:#logar-se
            if funcLogin():
                return True               
        elif loginOption == 2:
            if funcCadastro():
                return True
        return False 


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

login = []
login.append('1-Logar-se')
login.append('2-Cadastrar-se')
login.append('0-Sair')

condutorMenu = []
condutorMenu.append('1- Reservar Carro')
condutorMenu.append('2- Entregar Carro')
condutorMenu.append('3- Consultar corridas')
condutorMenu.append('4- Resumo do Perfil')
condutorMenu.append('0- Voltar')

passageiroMenu = []
passageiroMenu.append('1- Iniciar corrida')
passageiroMenu.append('2- Consultar corridas')
passageiroMenu.append('3- Encerrar corrida')
passageiroMenu.append('0- Voltar')
        
mode = 1
while(mode != 0):
    mode = askOption(modes)
    if mode == 1:#iniciado como condutor
        objCondutor = Condutor()

        if not loginScreen(objCondutor.logar, objCondutor.cadastrarCondutor,login):
            break

        option = 1
        while(option):
            option = askOption(condutorMenu)#pede options

            if option == 1:#cadastrar condutor
                objCondutor.cadastrarCondutor()

            elif option == 2:#reservar carro
                optsCarros = []
                optsCarros.append('1- Ver Carros')
                optsCarros.append('2- Digitar Renavam')
                optCarro = 1

                while(optCarro != 0):
                    option = askOption(optsCarros)#pede options
                    if(optCarro == 1):
                        objCondutor.verCarros()
                    else:
                        objCondutor.reservarCarro()
                        optCarro = 0 # força a sair

            elif option == 3:#entregar carro
                objCondutor.entregarCarro()

            elif option == 4:#consultar corridas
                objCondutor.consultarCorridas()

            elif option == 5:#consultar saldo
                objCondutor.consultarPerfil()

            else:
                objCondutor.exit()
                del objCondutor

    elif mode == 2:#inciado como passageiro
        objPassageiro = Passageiro()

        if not loginScreen(objPassageiro.logar, objPassageiro.cadastrarPassageiro,login):
            break

        option = 1

        while(option):
            option = askOption(passageiroMenu)#pergunta options

            if option == 1:# Cadastrar Passageiro
                objPassageiro.cadastrarPassageiro()  

            elif option == 2:#Iniciar corrida
                objPassageiro.realizarCorrida()

            elif option == 3:#Consultar corridas
                objPassageiro.verCorridas()

            elif option == 4:#Encerrar corrida
                objPassageiro.encerrarCorrida()

            else:
                objPassageiro.exit()
                del objPassageiro

print("Tchau!")

