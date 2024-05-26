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

def inserir_processo_judicial():
    print("\nInserindo processo judicial")
    nro_processo = input('Digite o numero do processo: ')
    data_do_processo = (input(f'{"Digite a data do processo"} {colored("(ex: YYYY-MM-DD)", "grey")}: '))
    acusado = (input(f'{"Digite o cpf do acusado"} {colored("(ex: 123.123.123-AA)", "grey")}: '))

    functions.inserir_processo_judicial(nro_processo, data_do_processo, acusado)

def inserir_partido():
    print("\nInserindo partido")
    nome = input('Digite o nome do partido: ')
    abreviacao = input('Digite a abreviação do partido: ')
    nro_integrantes = input('Digite o numero de integrantes: ')

    functions.inserir_partido(nome, abreviacao, nro_integrantes)

def inserir_programa_partido():
    print("\nInserindo programa_partido")
    partido = input('Digite o ID do partido: ')
    descricao = input('Digite a descrição do partido: ')

    functions.inserir_programa_partido(partido, descricao)

def inserir_candidato():
    print("\nInserindo candidato")
    cpf = (input(f'{"Digite o cpf do candidato"} {colored("(ex: 123.123.123-AA)", "grey")}: '))
    vice = (input(f'{"Digite se o candidato é vice"} {colored("(Y/N)", "grey")}: '))
    partido = input('Digite o ID do partido: ')

    functions.inserir_candidato(cpf, vice, partido)

def inserir_pleito():
    print("\nInserindo pleito")
    nome = input('Digite o nome do pleito: ')
    quantidade_votos = input('Digite a quantidade de votos: ')
    
    functions.inserir_pleito(nome, quantidade_votos)

def inserir_cargo():
    print("\nInserindo cargo")
    titulo = input('Digite o titulo: ')
    tipo = (input(f'{"Digite se o tipo de cargo"} {colored("(Municipal/Estadual/Federal)", "grey")}: '))
    
    functions.inserir_cargo(titulo, tipo)

def inserir_equipe_de_apoio():
    print("\nInserindo equipe de apoio")
    nome = input('Digite o nome da equipe de apoio: ')
    nro_membros = input('Digite o numero de membros: ')
    
    functions.inserir_equipe_de_apoio(nome, nro_membros)

def inserir_candidatura():
    print("\nInserindo candidatura")
    candidato_principal = input('Digite o CPF do candidato principal: ')
    candidato_vice = input('Digite o CPF do candidato vice: ')
    cargo = input('Digite o Id do cargo: ')
    equipe_de_apoio = input('Digite o ID da equipe de apoio: ')
    pleito = input('Digite o nome do pleito: ')
    
    functions.inserir_candidatura(candidato_principal, candidato_vice, cargo, equipe_de_apoio, pleito)

def inserir_doadores():
    print("\nInserindo doador")
    cpf = input('Digite o cpf do individuo: ')
    valor_doacao = input('Digite o valor da doação: ')
    candidatura = input('Digite o Id da candidatura que corresponde a doação: ')
    
    functions.inserir_doadores(cpf, valor_doacao, candidatura)

def inserir_empresa():
    print("\nInserindo empresa")
    cnpj = input('Digite o CNPJ da empresa: ')
    nome = input('Digite o nome da empresa: ')
    localizacao = input('Digite a localização da empresa: ')
    valor_doacao = input('Digite o valor da doação: ')
    candidatura = input('Digite o Id da candidatura que corresponde a doação: ')
    
    functions.inserir_empresa(cnpj, nome, localizacao, valor_doacao, candidatura)

def inserir_participantes_equipe_de_apoio():
    print("\nInserindo participantes equipe de apoio")
    cpf = input('Digite o cpf do individuo: ')
    equipe_de_apoio = input('Digite o ID da equipe de apoio: ')
    
    functions.inserir_participantes_equipe_de_apoio(cpf, equipe_de_apoio)


def exibir_opcoes():
    print("\nOpções:")
    print("1 - Inserir individuo")
    print("2 - Inserir processo judicial")
    print("3 - Inserir partido")
    print("4 - Inserir programa partido")
    print("5 - Inserir candidato")
    print("6 - Inserir pleito")
    print("7 - Inserir cargo")
    print("8 - Inserir equipe de apoio")
    print("9 - Inserir candidatura")
    print("10 - Inserir doadores")
    print("11 - Inserir empresa")
    print("12 - Inserir participantes da equipe de apoio")

operacao = -1
while operacao != 0:
    exibir_opcoes()
    operacao = int(input("\nDigite o código do comando: "))
    if operacao == 1:
        inserir_individuo()
    if operacao == 2:
        inserir_processo_judicial()
    if operacao == 3:
        inserir_partido()
    if operacao == 4:
        inserir_programa_partido()
    if operacao == 5:
        inserir_candidato()
    if operacao == 6:
        inserir_pleito()
    if operacao == 7:
        inserir_cargo()
    if operacao == 8:
        inserir_equipe_de_apoio()
    if operacao == 9:
        inserir_candidatura()
    if operacao == 10:
        inserir_doadores()
    if operacao == 11:
        inserir_empresa()
    if operacao == 12:
        inserir_participantes_equipe_de_apoio()
    
# Fechar cursor e conexão
cur.close()
conn.close()