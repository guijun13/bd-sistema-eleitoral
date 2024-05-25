import psycopg2
from config import config
from termcolor import colored
import functions

params = config()

# connect to the PostgreSQL server
conn = psycopg2.connect(**params)
cur = conn.cursor()

def inserir_individuo():
    print("\nInserindo individuo")
    cpf = (input(f'{"Digite o cpf da individuo"} {colored("(ex: 123.123.123-AA)", "grey")}: '))
    nome = input('Digite o nome da individuo: ')
    tipo = (input(f'{"Digite o tipo da pessoa"} {colored("()", "grey")}: '))
    rg = input('Digite o rg da pessoa: ')
    data_de_nascimento = (input(f'{"Digite a data de nascimento individuo"} {colored("(ex: YYYY-MM-DD)", "grey")}: '))
    nacionalidade = input('Digite a nacionalidade do individuo: ')
    titulo_eleitor = input('Digite o titulo de eleitor do individuo: ')

    functions.inserir_individuo(cpf, nome, tipo, rg, data_de_nascimento, nacionalidade, titulo_eleitor)

def exibir_opcoes():
    print("\nOpções:")
    print("1 - Inserir individuo")

operacao = -1
while operacao != 0:
    exibir_opcoes()
    operacao = int(input("\nDigite o código do comando: "))
    if operacao == 1:
        inserir_individuo()
    

# Fechar cursor e conexão
cur.close()
conn.close()