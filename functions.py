import psycopg2
from config import config
from termcolor import colored

params = config()

# connect to the PostgreSQL server
conn = psycopg2.connect(**params)
cur = conn.cursor()

def inserir_individuo(cpf, nome, tipo, rg, data_de_nascimento, nacionalidade, titulo_eleitor):
  try:
    query = "INSERT INTO individuo (cpf, nome, tipo, rg, data_de_nascimento, nacionalidade, titulo_eleitor) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    values = (cpf, nome, tipo, rg, data_de_nascimento, nacionalidade, titulo_eleitor)
    cur.execute(query, values)
    conn.commit()
    print(colored("Individuo inserido com sucesso!", "green"))
  except Exception as e:
    # ROLLBACK
    conn.rollback()
    print(colored("Erro ao inserir individuo: ", "red"))
    print(colored(e, "red"));