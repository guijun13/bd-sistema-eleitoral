-- Deletar registros das tabelas dependentes
DELETE FROM participantes_equipe_de_apoio;
DELETE FROM doadores;
DELETE FROM empresa;
DELETE FROM candidatura;
DELETE FROM candidato;
DELETE FROM programa_partido;
DELETE FROM processo_judicial;
-- Deletar registros das tabelas independentes
DELETE FROM equipe_de_apoio;
DELETE FROM pleito;
DELETE FROM cargo;
DELETE FROM partido;
DELETE FROM individuo;