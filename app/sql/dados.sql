-- Inserindo valores na tabela individuo
INSERT INTO individuo (
    cpf,
    nome,
    tipo,
    rg,
    data_de_nascimento,
    nacionalidade,
    titulo_eleitor
  )
VALUES (
    '12345678901',
    'José da Silva',
    'Eleitor',
    'RG123456',
    '1980-01-01',
    'Brasileira',
    'TE1234567890'
  ),
  (
    '12345678902',
    'Maria Oliveira',
    'Eleitor',
    'RG123457',
    '1981-02-02',
    'Brasileira',
    'TE1234567891'
  ),
  (
    '12345678903',
    'João Souza',
    'Eleitor',
    'RG123458',
    '1982-03-03',
    'Brasileira',
    'TE1234567892'
  ),
  (
    '12345678904',
    'Ana Lima',
    'Eleitor',
    'RG123459',
    '1983-04-04',
    'Brasileira',
    'TE1234567893'
  ),
  (
    '12345678905',
    'Pedro Santos',
    'Eleitor',
    'RG123460',
    '1984-05-05',
    'Brasileira',
    'TE1234567894'
  ),
  (
    '12345678906',
    'Paula Costa',
    'Eleitor',
    'RG123461',
    '1985-06-06',
    'Brasileira',
    'TE1234567895'
  ),
  (
    '12345678907',
    'Carlos Pereira',
    'Eleitor',
    'RG123462',
    '1986-07-07',
    'Brasileira',
    'TE1234567896'
  ),
  (
    '12345678908',
    'Fernanda Almeida',
    'Eleitor',
    'RG123463',
    '1987-08-08',
    'Brasileira',
    'TE1234567897'
  ),
  (
    '12345678909',
    'Lucas Fernandes',
    'Eleitor',
    'RG123464',
    '1988-09-09',
    'Brasileira',
    'TE1234567898'
  ),
  (
    '12345678910',
    'Juliana Rodrigues',
    'Eleitor',
    'RG123465',
    '1989-10-10',
    'Brasileira',
    'TE1234567899'
  );
-- Inserindo valores na tabela partido
INSERT INTO partido (nome, abreviacao, nro_integrantes)
VALUES ('Partido dos Trabalhadores', 'PT', 100),
  (
    'Partido da Social Democracia Brasileira',
    'PSDB',
    200
  ),
  ('Movimento Democrático Brasileiro', 'MDB', 300),
  ('Partido Socialista Brasileiro', 'PSB', 400),
  ('Partido Progressista', 'PP', 500),
  ('Democratas', 'DEM', 600),
  ('Partido Comunista do Brasil', 'PCdoB', 700),
  ('Partido Liberal', 'PL', 800),
  ('Partido Verde', 'PV', 900),
  ('Partido Socialismo e Liberdade', 'PSOL', 1000);
-- Inserindo valores na tabela programa_partido
INSERT INTO programa_partido (partido, descricao)
VALUES (1, 'Programa de Governo do PT'),
  (2, 'Programa de Governo do PSDB'),
  (3, 'Programa de Governo do MDB'),
  (4, 'Programa de Governo do PSB'),
  (5, 'Programa de Governo do PP'),
  (6, 'Programa de Governo do DEM'),
  (7, 'Programa de Governo do PCdoB'),
  (8, 'Programa de Governo do PL'),
  (9, 'Programa de Governo do PV'),
  (10, 'Programa de Governo do PSOL');
-- Inserindo valores na tabela candidato
INSERT INTO candidato (cpf, vice, partido)
VALUES ('12345678901', false, 1),
  ('12345678902', true, 2),
  ('12345678903', false, 3),
  ('12345678904', true, 4),
  ('12345678905', false, 5),
  ('12345678906', true, 6),
  ('12345678907', false, 7),
  ('12345678908', true, 8),
  ('12345678909', false, 9),
  ('12345678910', true, 10);
-- Inserindo valores na tabela pleito
INSERT INTO pleito (nome, quantidade_votos)
VALUES ('Eleições Presidenciais 2024', 10000000),
  ('Eleições Governamentais 2024', 8000000),
  ('Eleições Municipais 2024', 6000000),
  ('Eleições Legislativas 2024', 7000000),
  ('Eleições Suplementares 2024', 2000000),
  ('Eleições Presidenciais 2028', 11000000),
  ('Eleições Governamentais 2028', 8500000),
  ('Eleições Municipais 2028', 6500000),
  ('Eleições Legislativas 2028', 7500000),
  ('Eleições Suplementares 2028', 2500000);
-- Inserindo valores na tabela cargo
INSERT INTO cargo (titulo, tipo)
VALUES ('Presidente', 'Federal'),
  ('Governador', 'Estadual'),
  ('Prefeito', 'Municipal'),
  ('Senador', 'Federal'),
  ('Deputado Federal', 'Federal'),
  ('Deputado Estadual', 'Estadual'),
  ('Vereador', 'Municipal'),
  ('Vice-Presidente', 'Federal'),
  ('Vice-Governador', 'Estadual'),
  ('Vice-Prefeito', 'Municipal');
-- Inserindo valores na tabela equipe_de_apoio
INSERT INTO equipe_de_apoio (nome, nro_membros)
VALUES ('Equipe de Campanha Presidencial', 50),
  ('Equipe de Campanha Governamental', 40),
  ('Equipe de Campanha Municipal', 30),
  ('Equipe de Marketing', 20),
  ('Equipe Jurídica', 10),
  ('Equipe de Logística', 15),
  ('Equipe de Finanças', 25),
  ('Equipe de Comunicação', 35),
  ('Equipe de Relações Públicas', 45),
  ('Equipe de Pesquisa', 55);
-- Inserindo valores na tabela candidatura
INSERT INTO candidatura (
    candidato_principal,
    candidato_vice,
    cargo,
    equipe_de_apoio,
    pleito,
    ano
  )
VALUES (
    '12345678901',
    '12345678902',
    1,
    1,
    'Eleições Presidenciais 2024',
    2024
  ),
  (
    '12345678903',
    '12345678904',
    2,
    2,
    'Eleições Governamentais 2024',
    2024
  ),
  (
    '12345678905',
    '12345678906',
    3,
    3,
    'Eleições Municipais 2024',
    2024
  ),
  (
    '12345678907',
    '12345678908',
    4,
    4,
    'Eleições Legislativas 2024',
    2024
  ),
  (
    '12345678909',
    '12345678910',
    5,
    5,
    'Eleições Suplementares 2024',
    2024
  ),
  (
    '12345678901',
    '12345678903',
    6,
    6,
    'Eleições Presidenciais 2028',
    2028
  ),
  (
    '12345678902',
    '12345678904',
    7,
    7,
    'Eleições Governamentais 2028',
    2028
  ),
  (
    '12345678905',
    '12345678907',
    8,
    8,
    'Eleições Municipais 2028',
    2028
  ),
  (
    '12345678906',
    '12345678908',
    9,
    9,
    'Eleições Legislativas 2028',
    2028
  ),
  (
    '12345678909',
    '12345678901',
    10,
    10,
    'Eleições Suplementares 2028',
    2028
  );
-- Inserindo valores na tabela doadores
INSERT INTO doadores (cpf, valor_doacao, candidatura)
VALUES ('12345678901', 50000, 1),
  ('12345678902', 40000, 2),
  ('12345678903', 30000, 3),
  ('12345678904', 20000, 4),
  ('12345678905', 10000, 5),
  ('12345678906', 60000, 6),
  ('12345678907', 70000, 7),
  ('12345678908', 80000, 8),
  ('12345678909', 90000, 9),
  ('12345678910', 100000, 10);
-- Inserindo valores na tabela empresa
INSERT INTO empresa (
    cnpj,
    nome,
    localizacao,
    valor_doacao,
    candidatura
  )
VALUES (
    '12345678000101',
    'Construtora ABC',
    'São Paulo - SP',
    100000,
    1
  ),
  (
    '12345678000201',
    'Indústria XYZ',
    'Rio de Janeiro - RJ',
    200000,
    2
  ),
  (
    '12345678000301',
    'Tech Solutions',
    'Belo Horizonte - MG',
    150000,
    3
  ),
  (
    '12345678000401',
    'Agropecuária Silva',
    'Curitiba - PR',
    50000,
    4
  ),
  (
    '12345678000501',
    'Serviços Gerais Ltda',
    'Porto Alegre - RS',
    75000,
    5
  ),
  (
    '12345678000601',
    'Educação e Cultura',
    'Recife - PE',
    85000,
    6
  ),
  (
    '12345678000701',
    'Financeira S.A.',
    'Fortaleza - CE',
    95000,
    7
  ),
  (
    '12345678000801',
    'Transporte e Logística',
    'Salvador - BA',
    105000,
    8
  ),
  (
    '12345678000901',
    'Consultoria Alpha',
    'Brasília - DF',
    110000,
    9
  ),
  (
    '12345678001001',
    'Energia Renovável',
    'Manaus - AM',
    120000,
    10
  );
-- Inserindo valores na tabela participantes_equipe_de_apoio
INSERT INTO participantes_equipe_de_apoio (cpf, equipe_de_apoio)
VALUES ('12345678901', 1),
  ('12345678902', 2),
  ('12345678903', 3),
  ('12345678904', 4),
  ('12345678905', 5),
  ('12345678906', 6),
  ('12345678907', 7),
  ('12345678908', 8),
  ('12345678909', 9),
  ('12345678910', 10);