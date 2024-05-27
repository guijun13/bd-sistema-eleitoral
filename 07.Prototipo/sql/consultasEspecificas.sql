-- Listagem de candidaturas ordenadas por ano
SELECT c.id_candidatura,
  c.ano,
  i_principal.nome AS candidato_principal,
  i_vice.nome AS candidato_vice,
  cargo.titulo AS cargo
FROM candidatura c
  JOIN candidato candidato_principal ON c.candidato_principal = candidato_principal.cpf
  JOIN individuo i_principal ON candidato_principal.cpf = i_principal.cpf
  LEFT JOIN candidato candidato_vice ON c.candidato_vice = candidato_vice.cpf
  LEFT JOIN individuo i_vice ON candidato_vice.cpf = i_vice.cpf
  JOIN cargo ON c.cargo = cargo.id_cargo
ORDER BY c.ano;
-- Listagem de candidaturas ordenadas pelo nome do candidato principal
SELECT c.id_candidatura,
  c.ano,
  i_principal.nome AS candidato_principal,
  i_vice.nome AS candidato_vice,
  cargo.titulo AS cargo
FROM candidatura c
  JOIN candidato candidato_principal ON c.candidato_principal = candidato_principal.cpf
  JOIN individuo i_principal ON candidato_principal.cpf = i_principal.cpf
  LEFT JOIN candidato candidato_vice ON c.candidato_vice = candidato_vice.cpf
  LEFT JOIN individuo i_vice ON candidato_vice.cpf = i_vice.cpf
  JOIN cargo ON c.cargo = cargo.id_cargo
ORDER BY i_principal.nome;
-- Listagem de candidaturas ordenadas pelo título do cargo
SELECT c.id_candidatura,
  c.ano,
  i_principal.nome AS candidato_principal,
  i_vice.nome AS candidato_vice,
  cargo.titulo AS cargo
FROM candidatura c
  JOIN candidato candidato_principal ON c.candidato_principal = candidato_principal.cpf
  JOIN individuo i_principal ON candidato_principal.cpf = i_principal.cpf
  LEFT JOIN candidato candidato_vice ON c.candidato_vice = candidato_vice.cpf
  LEFT JOIN individuo i_vice ON candidato_vice.cpf = i_vice.cpf
  JOIN cargo ON c.cargo = cargo.id_cargo
ORDER BY cargo.titulo;
-- Relatório de candidaturas eleitas, incluindo candidatos principais e vices
SELECT c.ano,
  i1.nome AS candidato_eleito,
  i2.nome AS vice_eleito,
  c.nro_votos
FROM candidatura c
  JOIN candidato cp ON c.candidato_principal = cp.cpf
  JOIN individuo i1 ON cp.cpf = i1.cpf
  LEFT JOIN candidato cv ON c.candidato_vice = cv.cpf
  LEFT JOIN individuo i2 ON cv.cpf = i2.cpf
WHERE c.nro_votos = (
    SELECT MAX(c1.nro_votos)
    FROM candidatura c1
    WHERE c1.ano = c.ano
  );
-- Consulta SQL para Listar Pessoas Ficha Limpa
WITH processos_recente AS (
  SELECT acusado
  FROM processo_judicial
  WHERE data >= (CURRENT_DATE - INTERVAL '5 YEARS')
)
SELECT i.cpf,
  i.nome,
  i.tipo,
  i.rg,
  i.data_de_nascimento,
  i.nacionalidade,
  i.titulo_eleitor
FROM individuo i
  LEFT JOIN (
    SELECT acusado
    FROM processo_judicial
    WHERE data >= (CURRENT_DATE - INTERVAL '5 YEARS')
  ) pr ON i.cpf = pr.acusado
WHERE pr.acusado IS NULL;