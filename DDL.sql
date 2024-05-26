CREATE TABLE individuo (
	cpf CHAR(11),
	nome VARCHAR(255) NOT NULL,
	tipo VARCHAR(50),
	rg CHAR(16),
	data_de_nascimento DATE NOT NULL,
	nacionalidade VARCHAR(100) NOT NULL,
	titulo_eleitor CHAR(12) NOT NULL,
	CONSTRAINT individuo_pk PRIMARY KEY (cpf),
	CONSTRAINT individuo_sk unique (titulo_eleitor)
);
CREATE TABLE processo_judicial (
	nro_processo CHAR(25),
	data DATE,
	acusado CHAR(11) NOT NULL,
	CONSTRAINT processo_judicial_pk PRIMARY KEY (nro_processo),
	CONSTRAINT processo_judicial_fk FOREIGN KEY (acusado) REFERENCES individuo(cpf) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE partido (
	id_partido SERIAL,
	nome VARCHAR(255) NOT NULL,
	abreviacao VARCHAR(16) NOT NULL,
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
	titulo VARCHAR(255) NOT NULL,
	tipo VARCHAR(9) NOT NULL,
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
	candidato_principal CHAR(11) NOT NULL,
	candidato_vice CHAR(11),
	cargo SERIAL NOT NULL,
	equipe_de_apoio SERIAL,
	pleito VARCHAR(255),
	ano NUMERIC NOT NULL,
	CONSTRAINT candidatura_pk PRIMARY KEY (id_candidatura),
	CONSTRAINT candidatuta_fk_1 FOREIGN KEY (candidato_principal) REFERENCES candidato(cpf) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT candidatuta_fk_2 FOREIGN KEY (candidato_vice) REFERENCES candidato(cpf) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT candidatuta_fk_3 FOREIGN KEY (cargo) REFERENCES cargo(id_cargo) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT candidatuta_fk_4 FOREIGN KEY (equipe_de_apoio) REFERENCES equipe_de_apoio(id_equipe) ON DELETE
	SET NULL ON UPDATE CASCADE,
		CONSTRAINT candidatuta_fk_5 FOREIGN KEY (pleito) REFERENCES pleito(nome) ON DELETE
	SET NULL ON UPDATE CASCADE
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

-- Incrementa o número de membros na equipe correspondente
CREATE OR REPLACE FUNCTION aumentar_membros_equipe_de_apoio() RETURNS TRIGGER AS $$ BEGIN
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
-- Decrementa o número de membros na equipe correspondente
CREATE OR REPLACE FUNCTION diminuir_membros_equipe_de_apoio() RETURNS TRIGGER AS $$ BEGIN
UPDATE equipe_de_apoio
SET nro_membros = nro_membros - 1
WHERE id_equipe = OLD.equipe_de_apoio;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_diminuir_membros_equipe_de_apoio
AFTER DELETE ON participantes_equipe_de_apoio FOR EACH ROW EXECUTE FUNCTION diminuir_membros_equipe_de_apoio();
-- ////////////////////////////////////////////////////////////
-- Decrementa o número de membros na equipe antiga e incrementa na nova equipe
CREATE OR REPLACE FUNCTION atualizar_membros_equipe_de_apoio() RETURNS TRIGGER AS $$ BEGIN
UPDATE equipe_de_apoio
SET nro_membros = nro_membros - 1
WHERE id_equipe = OLD.equipe_de_apoio;
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
-- Verifica se o CPF do novo candidato tem um processo judicial no periodo de 5 anos para realizar a cadastro da candidatura
CREATE OR REPLACE FUNCTION verificar_ficha_limpa() RETURNS TRIGGER AS $$
DECLARE data_limite DATE;
BEGIN data_limite := CURRENT_DATE - INTERVAL '5 years';
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
-- ////////////////////////////////////////////////////////////
-- Incrementa o número de integrantes do novo partido no insert da candidatura
CREATE OR REPLACE FUNCTION insert_nro_integrantes() RETURNS TRIGGER AS $$ BEGIN
UPDATE partido
SET nro_integrantes = nro_integrantes + 1
WHERE id_partido = NEW.partido;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_insert_nro_integrantes
AFTER
INSERT ON candidato FOR EACH ROW EXECUTE FUNCTION insert_nro_integrantes();
-- ////////////////////////////////////////////////////////////
-- Incrementa o número de integrantes do novo partido e decrementa o do antigo
CREATE OR REPLACE FUNCTION update_nro_integrantes() RETURNS TRIGGER AS $$ BEGIN
UPDATE partido
SET nro_integrantes = nro_integrantes + 1
WHERE id_partido = NEW.partido;
UPDATE partido
SET nro_integrantes = nro_integrantes - 1
WHERE id_partido = OLD.partido;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_update_nro_integrantes
AFTER
UPDATE ON candidato FOR EACH ROW
	WHEN (
		OLD.partido IS DISTINCT
		FROM NEW.partido
	) EXECUTE FUNCTION update_nro_integrantes();
-- ////////////////////////////////////////////////////////////
-- Decrementa o número de integrantes do partido correspondente ao delete na candidatura
CREATE OR REPLACE FUNCTION delete_nro_integrantes() RETURNS TRIGGER AS $$ BEGIN
UPDATE partido
SET nro_integrantes = nro_integrantes - 1
WHERE id_partido = OLD.partido;
RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_delete_nro_integrantes
AFTER DELETE ON candidato FOR EACH ROW EXECUTE FUNCTION delete_nro_integrantes();