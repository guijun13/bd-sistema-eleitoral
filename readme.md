# Sistema eleitoral

SCC0240 - Base de dados - Prof. Jose Fernando Rodrigues Junior
- Guilherme Jun Y. Grillo - 11208350
- Leonardo Leitão Zanardo - 11814231
- Lucas Issao Omati - 13673090
- Samuel Victorio Bernacci - 12703455

## Estrutura do Projeto

A estrutura do projeto é delineada pelas seguintes diretórios:

- `/07.Prototipo` que contém o prototipo da aplicação:
  - `config.py`: Configurações iniciais do sistema.
  - `create.py`: Scripts para criação de entidades no banco de dados.
  - `database.ini`: Arquivo de configuração para conexão com o banco de dados.
  - `insert.py`: Scripts para inserção de dados no sistema.
  - `query.py`: Scripts para consultas e operações de dados.

## Instruções de Uso

1. Instale um servidor local postgreSQL no seu PC, a depender do seu sistema operacional
2. Faça uma copia do projeto
```
git clone https://github.com/guijun13/bd-sistema-eleitoral.git
```

3. Entre na pasta 07.Prototipo
```
cd 07.Prototipo
```
4. Preencha as informações do seu banco de dados correspondente com o arquivo `database.ini`, ou então altere-o com as suas configurações de host, database, user, password, port

5. Verifique se você tem instalado o Python3
```
python3 --version
```

6. Instale as bibliotecas requisito para o código com o comando
```
pip install -r requirements.txt
```

7. Execute os comandos conforme a operação que deseja realizar
  - `create.py`: criar tabelas do `esquema.sql`
  - `insert.py`: inserir dados do `dados.sql`
  - `query.py`: realizar consultas do `consultasTotais.sql` e `consultasEspecificas.sql`
  - `delete.py`: deletar todos os dados inseridos (não da drop nas tabela)
  - `src.py`: inserir manualmente dados nas tabelas
```
python3 <nome-arquivo.py>
```
