#!/usr/bin/python

import psycopg2
from tabulate import tabulate
from termcolor import colored
from config import config
from utils import *

def query_data(query):
    """Executa uma consulta específica no banco de dados PostgreSQL."""
    conn = None
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()

        campos_personalizaveis = get_query_fields(query)

        dict_campos_personalizaveis = {}
        if campos_personalizaveis:
            print(colored("Esta consulta possui campos personalizáveis:", "yellow"))
            for campo in campos_personalizaveis:
                # se o campo for uma data, exibe um exemplo de data válida
                if "data" in campo.lower():
                    print(f'{colored(campo, "cyan")} {colored("(ex: 2020-01-01)", "grey")}: ', end="")
                else:
                    print(colored(f"{campo}: ", 'cyan'), end="")

                valor = input()

                # Coloca o valor no dicionário de campos personalizáveis
                dict_campos_personalizaveis[campo] = valor

        # Substitui os campos personalizáveis por placeholders -> %(NOME_DO_CAMPO)s
        query = set_query_fields(query, dict_campos_personalizaveis)

        # Executa a consulta selecionada seguindo o padrão do psycopg2
        # Essa abordagem é segura contra ataques de injeção de SQL
        cur.execute(query, dict_campos_personalizaveis)

        rows = cur.fetchall()

        # Obter os nomes das colunas em maiúsculas
        column_names = [desc[0].upper() for desc in cur.description]

        # Imprimir resultados com tabulate
        if rows:
            print(colored("Contagem de tuplas resultantes: ", 'grey'), cur.rowcount)
            print(tabulate(rows, headers=column_names, tablefmt='rounded_outline'))
        else:
            print(colored("\nNenhum resultado encontrado.", 'red'))

        cur.close()
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print(colored("\n[ERRO] Erro ao executar a consulta.", 'red'))
        print(colored(error, 'grey'))
        conn.rollback()
    finally:
        if conn is not None:
            conn.close()

def main():
    # """Exibe um menu de seleção e executa a consulta escolhida."""
    # queries = extract_queries("./sql/consultasTotais.sql")

    print(colored("Escolha se deseja executar as consultas totais ou especificas:", 'yellow'))
    print(colored("1: Consultas Totais", 'magenta'))
    print(colored("2: Consultas Específicas", 'magenta'))
    choiceTipoConsulta = int(input(colored("Digite o número do tipo da consulta: ", 'yellow')))
    if choiceTipoConsulta == 1:
        queries = extract_queries("./sql/consultasTotais.sql")
    elif choiceTipoConsulta == 2:
        queries = extract_queries("./sql/consultasEspecificas.sql")
    else:
        print(colored("Escolha inválida.", 'red'))
        return

    # Exibe as opções de consulta
    print(colored("Selecione uma consulta para executar:", 'yellow'))
    for idx, title in enumerate(queries, 1):
        print(f"{colored(idx, 'magenta')}: {title}")

    # Obtém a escolha do usuário
    choice = int(input(colored("Digite o número da consulta: ", 'yellow')))

    # Executa a consulta escolhida
    if choice in range(1, len(queries) + 1):
        query_title = list(queries)[choice - 1]
        print(colored(f"\nExecutando consulta: {colored(query_title, 'white')}", 'blue'), end="\n")
        query_data(queries[query_title])
    else:
        print(colored("Escolha inválida.", 'red'))

if __name__ == '__main__':
    main()
