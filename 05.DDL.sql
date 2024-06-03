CREATE TABLE individuo (
	cpf CHAR(11),
	nome VARCHAR(255) NOT NULL,
	tipo VARCHAR(50),
	rg CHAR(16),
	data_de_nascimento DATE,
	nacionalidade VARCHAR(100),
	titulo_eleitor CHAR(12),
	CONSTRAINT individuo_pk PRIMARY KEY (cpf),
	CONSTRAINT individuo_sk UNIQUE (titulo_eleitor),
	CONSTRAINT individuo_ck CHECK (tipo IN('Candidato', 'Doador', 'Participante equipe de apoio'))
);
CREATE TABLE processo_judicial (
	nro_processo CHAR(25),
	data DATE,
	acusado CHAR(11),
	CONSTRAINT processo_judicial_pk PRIMARY KEY (nro_processo),
	CONSTRAINT processo_judicial_fk FOREIGN KEY (acusado) REFERENCES individuo(cpf) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE partido (
	id_partido SERIAL,
	nome VARCHAR(255) NOT NULL,
	abreviacao VARCHAR(16),
	nro_integrantes NUMERIC,
	CONSTRAINT partido_pk PRIMARY KEY (id_partido)
);
CREATE TABLE programa_partido (
	id_programa SERIAL,
	partido SERIAL,
	descricao TEXT,
	CONSTRAINT programa_partido_pk PRIMARY KEY (id_programa, partido),
	CONSTRAINT programa_partido_fk FOREIGN KEY (partido) REFERENCES partido(id_partido) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE candidato (
	cpf CHAR(11),
	vice BOOLEAN,
	partido SERIAL,
	CONSTRAINT candidato_pf PRIMARY KEY (cpf),
	CONSTRAINT candidato_fk_1 FOREIGN KEY (cpf) REFERENCES individuo(cpf) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT candidato_fk_2 FOREIGN KEY (partido) REFERENCES partido(id_partido) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE pleito (
	nome VARCHAR(255),
	quantidade_votos NUMERIC,
	CONSTRAINT pleito_pk PRIMARY KEY (nome)
);
CREATE TABLE cargo (
	id_cargo SERIAL,
	titulo VARCHAR(255),
	tipo VARCHAR(9),
	CONSTRAINT cargo_pk PRIMARY KEY (id_cargo),
	CONSTRAINT cargo_tipo_ck CHECK (tipo in ('Municipal', 'Estadual', 'Federal'))
);
CREATE TABLE equipe_de_apoio (
	id_equipe SERIAL,
	nome VARCHAR(255),
	nro_membros NUMERIC,
	CONSTRAINT equipe_de_apoio_pk PRIMARY KEY (id_equipe)
);
CREATE TABLE candidatura (
	id_candidatura SERIAL,
	candidato_principal CHAR(11),
	candidato_vice CHAR(11),
	cargo SERIAL,
	equipe_de_apoio SERIAL,
	pleito VARCHAR(255),
	ano NUMERIC,
	nro_votos NUMERIC,
	CONSTRAINT candidatura_pk PRIMARY KEY (id_candidatura),
	CONSTRAINT candidatuta_fk_1 FOREIGN KEY (candidato_principal) REFERENCES candidato(cpf) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT candidatuta_fk_2 FOREIGN KEY (candidato_vice) REFERENCES candidato(cpf) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT candidatuta_fk_3 FOREIGN KEY (cargo) REFERENCES cargo(id_cargo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT candidatuta_fk_4 FOREIGN KEY (equipe_de_apoio) REFERENCES equipe_de_apoio(id_equipe) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT candidatuta_fk_5 FOREIGN KEY (pleito) REFERENCES pleito(nome) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE doadores (
	cpf CHAR(11),
	valor_doacao NUMERIC,
	candidatura SERIAL,
	CONSTRAINT doadores_pk PRIMARY KEY (cpf),
	CONSTRAINT doadores_fk_1 FOREIGN KEY (cpf) REFERENCES individuo(cpf) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT doadores_fk_2 FOREIGN KEY (candidatura) REFERENCES candidatura(id_candidatura) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE empresa (
	cnpj CHAR(14),
	nome VARCHAR(255),
	localizacao VARCHAR(255),
	valor_doacao NUMERIC,
	candidatura SERIAL,
	CONSTRAINT empresa_pk PRIMARY KEY (cnpj),
	CONSTRAINT empresa_fk FOREIGN KEY (candidatura) REFERENCES candidatura(id_candidatura) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE participantes_equipe_de_apoio (
	cpf CHAR(11),
	equipe_de_apoio SERIAL,
	CONSTRAINT participantes_equipe_de_apoio_pk PRIMARY KEY (cpf),
	CONSTRAINT participantes_equipe_de_apoio_fk_1 FOREIGN KEY (cpf) REFERENCES individuo(cpf) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT participantes_equipe_de_apoio_fk_2 FOREIGN KEY (equipe_de_apoio) REFERENCES equipe_de_apoio(id_equipe) ON DELETE CASCADE ON UPDATE CASCADE
);
--
-- TRIGGERS
--
CREATE OR REPLACE FUNCTION aumentar_membros_equipe_de_apoio()
RETURNS TRIGGER AS $$ BEGIN -- Incrementa o número de membros na equipe correspondente
UPDATE equipe_de_apoio
SET nro_membros = nro_membros + 1
WHERE id_equipe = NEW.equipe_de_apoio;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_aumentar_membros_equipe_de_apoio
AFTER
INSERT ON participantes_equipe_de_apoio FOR EACH ROW EXECUTE FUNCTION aumentar_membros_equipe_de_apoio();
-- ////////////////////////////////////////////////////////////
CREATE OR REPLACE FUNCTION diminuir_membros_equipe_de_apoio() RETURNS TRIGGER AS $$ BEGIN -- Decrementa o número de membros na equipe correspondente
UPDATE equipe_de_apoio
SET nro_membros = nro_membros - 1
WHERE id_equipe = OLD.equipe_de_apoio;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_diminuir_membros_equipe_de_apoio
AFTER DELETE ON participantes_equipe_de_apoio FOR EACH ROW EXECUTE FUNCTION diminuir_membros_equipe_de_apoio();
-- ////////////////////////////////////////////////////////////
CREATE OR REPLACE FUNCTION atualizar_membros_equipe_de_apoio() RETURNS TRIGGER AS $$ BEGIN -- Decrementa o número de membros na equipe antiga
UPDATE equipe_de_apoio
SET nro_membros = nro_membros - 1
WHERE id_equipe = OLD.equipe_de_apoio;
-- Incrementa o número de membros na nova equipe
UPDATE equipe_de_apoio
SET nro_membros = nro_membros + 1
WHERE id_equipe = NEW.equipe_de_apoio;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_atualizar_membros_equipe_de_apoio
AFTER
UPDATE ON participantes_equipe_de_apoio FOR EACH ROW
	WHEN (OLD.equipe_de_apoio <> NEW.equipe_de_apoio) EXECUTE FUNCTION atualizar_membros_equipe_de_apoio();
-- ////////////////////////////////////////////////////////////
CREATE OR REPLACE FUNCTION verificar_ficha_limpa() RETURNS TRIGGER AS $$
DECLARE data_limite DATE;
BEGIN -- Definindo a data limite como 5 anos atrás a partir da data atual
data_limite := CURRENT_DATE - INTERVAL '5 years';
-- Verifica se o CPF do novo candidato tem um processo judicial recente
IF EXISTS (
	SELECT 1
	FROM processo_judicial
	WHERE acusado = NEW.cpf
		AND data > data_limite
) THEN RAISE EXCEPTION 'Não é permitido inserir candidato. Pois o individuo possui um processo judicial recente.';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_verificar_ficha_limpa BEFORE
INSERT ON candidato FOR EACH ROW EXECUTE FUNCTION verificar_ficha_limpa();
