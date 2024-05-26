INSERT INTO individuo (cpf, nome, tipo, rg, data_de_nascimento, nacionalidade, titulo_eleitor)
VALUES
    ('42519862358', 'Ana Maria Souza', 'Física', '123456789', '1980-03-25', 'Brasileira', '987654321012'),
    ('12486525482', 'Carlos Alberto Santos', 'Física', '987654321', '1975-09-12', 'Brasileira', '123456789012'),
    ('46603592128', 'Maria Luiza Oliveira', 'Física', '567891234', '1995-01-18', 'Brasileira', '321654987012'),
    ('66507824902', 'Pedro Henrique Almeida', 'Física', '123987456', '2002-06-30', 'Brasileira', NULL),
    ('84166501982', 'Fernanda Cristina Lima', 'Física', '789456123', '1988-11-05', 'Brasileira', '543216789012'),
    ('19726485225', 'João Paulo Ferreira', 'Física', '456123789', '1992-04-10', 'Brasileira', NULL),
    ('49925812673', 'Luciana dos Santos', 'Física', '465298027', '2010-08-22', 'Brasileira', NULL),
    ('75395102846', 'Paulo Roberto Risco', 'Física', '', '2005-02-15', 'Brasileira', NULL),
    ('45619732808', 'André Gustavo Zanardi', 'Física', '', '1998-07-03', 'Brasileira', NULL),
    ('48265913870', 'Simão dos Santos Cruz', 'Física', '', '2015-12-09', 'Brasileira', NULL);

INSERT INTO processo_judicial (nro_processo, data, acusado)
VALUES 
    ('0216907846952317854925648', '2014-06-17', '12486525482'), -- Carlos Alberto Santos
    ('2594625871034950134858154', '2019-03-21', '46603592128'), -- Maria Luiza Oliveira 
    ('0218468405018306198120554', '2012-09-10', '19726485225'), -- João Paulo Ferreira
    ('0987982019875065420651980', '2017-02-02', '48265913870'), -- Simão dos Santos Cruz
    ('7989119588562058892020819', '2021-04-03', '84166501982'); -- Fernanda Cristina Lima

INSERT INTO partido (id_partido, nome, abreviação, nro_integrantes) --Preencher
VALUES 
    ('', 'Partido do Trabalho Intenso', 'PTI', ''),
    ('', 'Partido Azul', 'PA', ''),
    ('', 'Partido Brasileiro Político', 'PBP', ''),
    ('', 'Partido da Liberdade Cinza', 'PLC', ''),
    ('', 'Partido da Folha', 'PF', ''),
    ('', 'Partido Esquerda Libertário', 'PEL', '');

INSERT INTO programa_partido (id_programa, partido, descrição) -- Preencher
VALUES 
    ('', 'Partido do Trabalho Intenso', ''),
    ('', 'Partido Azul', ''),
    ('', 'Partido Brasileiro Político', ''),
    ('', 'Partido da Liberdade Cinza', ''),
    ('', 'Partido da Folha', ''),
    ('', 'Partido da Esquerda Libertário', '');

INSERT INTO candidato (candidato, vice, partido)
VALUES 
    ('', '', ''),
    ('', '', ''),
    ('', '', ''),
    ('', '', ''),
    ('', '', ''),
    ('', '', '');

INSERT INTO pleito (nome, quantidade_votos)
VALUES 
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', '');

INSERT INTO cargo (id_cargo, titulo, tipo)
VALUES 
    ('', '', ''),
    ('', '', ''),
    ('', '', ''),
    ('', '', ''),
    ('', '', ''),
    ('', '', '');

INSERT INTO equipe_de_apoio (id_equipe, nome, nro_membros)
VALUES 
    ('', '', ''),
    ('', '', ''),
    ('', '', ''),
    ('', '', ''),
    ('', '', ''),
    ('', '', '');

INSERT INTO candidatura (id_candidatura, candidato_principal, candidato_vice, cargo, equipe_de_apoio, pleito, ano)
VALUES 
    ('', '', '', '', '', '', ''),
    ('', '', '', '', '', '', ''),
    ('', '', '', '', '', '', ''), 
    ('', '', '', '', '', '', ''),
    ('', '', '', '', '', '', ''),
    ('', '', '', '', '', '', '');

INSERT INTO doadores (cpf, valor_doação, candidatura)
VALUES 
    ('', '', ''),
    ('', '', ''),
    ('', '', ''),
    ('', '', ''),
    ('', '', ''),
    ('', '', '');

INSERT INTO empresa (cnpj, nome, localização, valor_doação, candidatura)
VALUES 
    ('', '', '', '', ''),
    ('', '', '', '', ''),
    ('', '', '', '', ''), 
    ('', '', '', '', ''),
    ('', '', '', '', ''),
    ('', '', '', '', '');

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


















