#!/usr/bin/python

import psycopg2
from termcolor import colored
from config import config

def create_tables():
    conn = None
    try:
        params = config()

        # connect to the PostgreSQL server
        conn = psycopg2.connect(**params)
        cur = conn.cursor()

        # run the remocoes.sql file that empties all the tables
        with open('./sql/remocoes.sql', 'r') as file:
            cur.execute(file.read())

        print(colored("Todos os dados das tabelas foram apagadas.", 'green'))

        # close communication with the PostgreSQL database server
        cur.close()

        # commit the changes
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
        conn.rollback()

    finally:
        if conn is not None:
          conn.close()

if __name__ == '__main__':
    create_tables()
