# Sistema eleitoral

## Estrutura do Projeto

A estrutura do projeto é delineada pelas seguintes diretórios e arquivos essenciais:

- `config.py`: Configurações iniciais do sistema.
- `create.py`: Scripts para criação de entidades no banco de dados.
- `database.ini`: Arquivo de configuração para conexão com o banco de dados.
- `insert.py`: Scripts para inserção de dados no sistema.
- `query.py`: Scripts para consultas e operações de dados.

## Instruções de Uso

1. Instale um servidor local postgreSQL no seu PC, a depender do seu sistema operacional

2. Preencha as informações do seu banco de dados correspondente com o arquivo `database.ini`, ou então altere-o com as suas configurações de host, database, user, password, port

3. Verifique se você tem instalado o Python3
```
python3 --version
```

4. Instale as bibliotecas requisito para o código com o comando
```
pip install -r requirements.txt
```

5. Execute os comandos conforme a operação que deseja realizar
  - `create.py`: criar tabelas do `esquema.sql`
  - `insert.py`: inserir dados do `dados.sql`
  - `query.py`: realizar consultas do `consultas.sql`
```
python3 <nome-arquivo.py>
```