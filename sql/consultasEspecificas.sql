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