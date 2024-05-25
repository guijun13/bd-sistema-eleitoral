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
    print(colored(e, "red"))

def inserir_processo_judicial(nro_processo, data_do_processo, acusado):
  try:
    query = "INSERT INTO processo_judicial (nro_processo, data, acusado) VALUES (%s, %s, %s)"
    values = (nro_processo, data_do_processo, acusado)
    cur.execute(query, values)
    conn.commit()
    print(colored("Processo Judicial inserido com sucesso!", "green"))
  except Exception as e:
    # ROLLBACK
    conn.rollback()
    print(colored("Erro ao inserir processo judicial: ", "red"))
    print(colored(e, "red"))

def inserir_partido(nome, abreviacao, nro_integrantes):
  try:
    query = "INSERT INTO partido (nome, abreviacao, nro_integrantes) VALUES (%s, %s, %s)"
    values = (nome, abreviacao, nro_integrantes)
    cur.execute(query, values)
    conn.commit()
    print(colored("Partido inserido com sucesso!", "green"))
  except Exception as e:
    # ROLLBACK
    conn.rollback()
    print(colored("Erro ao inserir partido: ", "red"))
    print(colored(e, "red"))

def inserir_programa_partido(partido, descricao):
  try:
    query = "INSERT INTO programa_partido (partido, descricao) VALUES (%s, %s)"
    values = (partido, descricao)
    cur.execute(query, values)
    conn.commit()
    print(colored("Programa partido inserido com sucesso!", "green"))
  except Exception as e:
    # ROLLBACK
    conn.rollback()
    print(colored("Erro ao inserir programa partido: ", "red"))
    print(colored(e, "red"))
    
def inserir_candidato(cpf, vice, partido):
  try:
    query = "INSERT INTO candidato (cpf, vice, partido) VALUES (%s, %s, %s)"
    values = (cpf, vice, partido)
    cur.execute(query, values)
    conn.commit()
    print(colored("Candidato inserido com sucesso!", "green"))
  except Exception as e:
    # ROLLBACK
    conn.rollback()
    print(colored("Erro ao inserir candidato: ", "red"))
    print(colored(e, "red"))
    
def inserir_pleito(nome, quantidade_votos):
  try:
    query = "INSERT INTO pleito (nome, quantidade_votos) VALUES (%s, %s)"
    values = (nome, quantidade_votos)
    cur.execute(query, values)
    conn.commit()
    print(colored("Pleito inserido com sucesso!", "green"))
  except Exception as e:
    # ROLLBACK
    conn.rollback()
    print(colored("Erro ao inserir pleito: ", "red"))
    print(colored(e, "red"))
    
def inserir_cargo(titulo, tipo):
  try:
    query = "INSERT INTO cargo (titulo, tipo) VALUES (%s, %s)"
    values = (titulo, tipo)
    cur.execute(query, values)
    conn.commit()
    print(colored("Cargo inserido com sucesso!", "green"))
  except Exception as e:
    # ROLLBACK
    conn.rollback()
    print(colored("Erro ao inserir cargo: ", "red"))
    print(colored(e, "red"))
    
def inserir_equipe_de_apoio(nome, nro_membros):
  try:
    query = "INSERT INTO equipe_de_apoio (nome, nro_membros) VALUES (%s, %s)"
    values = (nome, nro_membros)
    cur.execute(query, values)
    conn.commit()
    print(colored("Equipe de apoio inserido com sucesso!", "green"))
  except Exception as e:
    # ROLLBACK
    conn.rollback()
    print(colored("Erro ao inserir equipe de apoio: ", "red"))
    print(colored(e, "red"))
    
def inserir_candidatura(candidato_principal, candidato_vice, cargo, equipe_de_apoio, pleito):
  try:
    query = "INSERT INTO candidatura (candidato_principal, candidato_vice, cargo, equipe_de_apoio, pleito) VALUES (%s, %s, %s, %s, %s)"
    values = (candidato_principal, candidato_vice, cargo, equipe_de_apoio, pleito)
    cur.execute(query, values)
    conn.commit()
    print(colored("Candidatura inserido com sucesso!", "green"))
  except Exception as e:
    # ROLLBACK
    conn.rollback()
    print(colored("Erro ao inserir candidatura: ", "red"))
    print(colored(e, "red"))
    
def inserir_doadores(cpf, valor_doacao, candidatura):
  try:
    query = "INSERT INTO doadores (cpf, valor_doacao, candidatura) VALUES (%s, %s, %s)"
    values = (cpf, valor_doacao, candidatura)
    cur.execute(query, values)
    conn.commit()
    print(colored("Doador inserido com sucesso!", "green"))
  except Exception as e:
    # ROLLBACK
    conn.rollback()
    print(colored("Erro ao inserir doador: ", "red"))
    print(colored(e, "red"))
    
def inserir_empresa(cnpj, nome, localizacao, valor_doacao, candidatura):
  try:
    query = "INSERT INTO empresa (cnpj, nome, localizacao, valor_doacao, candidatura) VALUES (%s, %s, %s, %s, %s)"
    values = (cnpj, nome, localizacao, valor_doacao, candidatura)
    cur.execute(query, values)
    conn.commit()
    print(colored("Empresa inserido com sucesso!", "green"))
  except Exception as e:
    # ROLLBACK
    conn.rollback()
    print(colored("Erro ao inserir empresa: ", "red"))
    print(colored(e, "red"))
    
def inserir_participantes_equipe_de_apoio(cpf, equipe_de_apoio):
  try:
    query = "INSERT INTO participantes_equipe_de_apoio (cpf, equipe_de_apoio) VALUES (%s, %s)"
    values = (cpf, equipe_de_apoio)
    cur.execute(query, values)
    conn.commit()
    print(colored("Participante da equipe de apoio inserido com sucesso!", "green"))
  except Exception as e:
    # ROLLBACK
    conn.rollback()
    print(colored("Erro ao inserir participante da equipe de apoio: ", "red"))
    print(colored(e, "red"))
    