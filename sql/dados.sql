INSERT INTO individuo (cpf, nome, tipo, rg, data_de_nascimento, nacionalidade, titulo_eleitor)
VALUES
    ('42519862358', 'Ana Maria Souza', 'Física', '123456789', '1980-03-25', 'Brasileira', '987654321012'), -- Candidata 1
    ('12486525482', 'Carlos Alberto Santos', 'Física', '987654321', '1975-09-12', 'Brasileira', '123456789012'), -- Vice 1
    ('46603592128', 'Maria Luiza Oliveira', 'Física', '567891234', '1995-01-18', 'Brasileira', '321654987012'), -- Candidata 2
    ('66507824902', 'Pedro Henrique Almeida', 'Física', '123987456', '2002-06-30', 'Brasileira', '106582164520'), -- Vice 2
    ('84166501982', 'Fernanda Cristina Lima', 'Física', '789456123', '1988-11-05', 'Brasileira', '543216789012'), -- Candidata 3
    ('19726485225', 'João Paulo Ferreira', 'Física', '456123789', '1992-04-10', 'Brasileira', '016087246158'), -- Candidata 4
    ('49925812673', 'Luciana dos Santos', 'Física', '465298027', '2010-08-22', 'Brasileira', '021854159357'), -- Vice 4
    ('75395102846', 'Paulo Roberto Risco', 'Física', '', '2005-02-15', 'Brasileira', '159258357852'), -- Doador 1
    ('45619732808', 'André Gustavo Zanardi', 'Física', '', '1998-07-03', 'Brasileira', '159357852645'), -- Doador 2
    ('48265913870', 'Simão dos Santos Cruz', 'Física', '', '2015-12-09', 'Brasileira', '123789357159'); -- Doador 3 
    ('85296374100', 'Juliana Aparecida Ferreira', 'Física', '852963741', '1998-09-28', 'Brasileira', '741852963001'), -- Doador 4


INSERT INTO processo_judicial (nro_processo, data, acusado)
VALUES 
    ('0216907846952317854925648', '2014-06-17', '12486525482'), -- Carlos Alberto Santos
    ('2594625871034950134858154', '2019-03-21', '46603592128'), -- Maria Luiza Oliveira 
    ('7989119588562058892020819', '2021-04-03', '84166501982'); -- Fernanda Cristina Lima

INSERT INTO partido (id_partido, nome, abreviação, nro_integrantes) --Preencher
VALUES 
    ('', 'Partido do Trabalho Intenso', 'PTI', '13'),
    ('', 'Partido Azul', 'PA', '11'),
    ('', 'Partido Brasileiro Político', 'PBP', '8'),
    ('', 'Partido da Liberdade Cinza', 'PLC', '14'),
    -- ('', 'Partido da Folha', 'PF', '13'),
    -- ('', 'Partido Esquerda Libertário', 'PEL', '11');

INSERT INTO programa_partido (id_programa, partido, descrição) -- Preencher
VALUES 
    ('', 'Partido do Trabalho Digno', 'Somos um partido que busca a dignidade no trabalho, sendo ele político ou laboroso!'),
    ('', 'Partido Azul', 'Um partido que busca o equilíbrio ambiental acima de tudo, bem como o desenvolvimento sustentável!'),
    ('', 'Partido Brasileiro Político', 'Um partido que busca alianças dignas de políticas que vão de encontro aos interesses do Brasil!'),
    ('', 'Partido da Liberdade Cinza', 'Liberdade não deve ser algo intangível, assim como a cor cinza, deve ser comum e igualitária.');
    -- ('', 'Partido da Folha', 'Um partido que busca transparência acima de tudo, logo, a folha sempre trará a verdade!'),
    -- ('', 'Partido da Esquerda Libertária', 'Os princípios de Karl nunca foram implantados com seriedade, este nosso interesse!');

INSERT INTO candidato (cpf, vice, partido)
VALUES 
    ('42519862358', 'YES', ''), -- 1
    ('46603592128', 'YES', ''), -- 2
    ('84166501982', 'NO', ''), -- 3
    ('19726485225', 'YES', ''); -- 4

INSERT INTO pleito (nome, quantidade_votos)
VALUES 
    ('Eleições Gerais para o Estado Brasileiro', '77982024');

INSERT INTO cargo (id_cargo, titulo, tipo)
VALUES 
    ('Presidente', 'Federal');
    ('Vice-Presidente', 'Federal');

INSERT INTO equipe_de_apoio (id_equipe, nome, nro_membros)
VALUES 
    ('', 'Equipe 1', '11'),
    ('', 'Equipe 2', '12'),
    ('', 'Equipe 3', '13'),
    ('', 'Equipe 4', '11'),

INSERT INTO candidatura (id_candidatura, candidato_principal, candidato_vice, cargo, equipe_de_apoio, pleito, ano)
VALUES 
    ('', '42519862358', '12486525482', 'Presidente', 'Equipe 1', 'Eleições Gerais para o Estado Brasileiro', '2022'),
    ('', '46603592128', '66507824902', 'Presidente', 'Equipe 2', 'Eleições Gerais para o Estado Brasileiro', '2022'),
    ('', '84166501982', NULL, 'Presidente', 'Equipe 3', 'Eleições Gerais para o Estado Brasileiro', '2022'), 
    ('', '19726485225', '49925812673', 'Presidente', 'Equipe 4', 'Eleições Gerais para o Estado Brasileiro', '2022');

INSERT INTO doadores (cpf, valor_doação, candidatura)
VALUES 
    ('75395102846', '85000', ''),
    ('45619732808', '270000', ''),
    ('48265913870', '1000000', ''),
    ('85296374100', '510000', '');

INSERT INTO empresa (cnpj, nome, localização, valor_doação, candidatura)
VALUES 
    ('12345678000198', 'Tech Solutions SA', 'São Paulo', '500000', 'Candidata 1'),
    ('98765432000102', 'InovaTech LTDA', 'Rio de Janeiro', '2000000', 'Candidata 2'),
    ('54321098000187', 'Green Energy Corp', 'Minas Gerais', '2500000', 'Candidata 3'),
    ('87654321000165', 'AgroTech Solutions', 'Paraná', '4000000', 'Candidata 4'),
    ('21098765000154', 'HealthTech Innovations', 'Santa Catarina', '3000000', 'Candidata 1'),
    ('65432109000132', 'EduTech Group', 'Rio Grande do Sul', '4500000', 'Candidata 2'),
    ('09876543000121', 'FinTech Services', 'Bahia', '8000000', 'Candidata 3'),
    ('32109876000110', 'BioTech Research', 'Pernambuco', '850000', 'Candidata 4');


INSERT INTO participantes_equipe_de_apoio (cpf, equipe_de_apoio)
VALUES 
    ('', ''),
    ('', ''),
    ('', ''), 
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''), 
    ('', ''),
    ('', ''),
    ('', '');


















