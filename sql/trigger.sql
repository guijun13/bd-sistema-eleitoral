-- Incrementa o número de membros na equipe correspondente
CREATE OR REPLACE FUNCTION aumentar_membros_equipe_de_apoio()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE equipe_de_apoio
    SET nro_membros = nro_membros + 1
    WHERE id_equipe = NEW.equipe_de_apoio;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_aumentar_membros_equipe_de_apoio
AFTER INSERT ON participantes_equipe_de_apoio
FOR EACH ROW
EXECUTE FUNCTION aumentar_membros_equipe_de_apoio();

-- ////////////////////////////////////////////////////////////

-- Decrementa o número de membros na equipe correspondente
CREATE OR REPLACE FUNCTION diminuir_membros_equipe_de_apoio()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE equipe_de_apoio
    SET nro_membros = nro_membros - 1
    WHERE id_equipe = OLD.equipe_de_apoio;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_diminuir_membros_equipe_de_apoio
AFTER DELETE ON participantes_equipe_de_apoio
FOR EACH ROW
EXECUTE FUNCTION diminuir_membros_equipe_de_apoio();

-- ////////////////////////////////////////////////////////////

-- Decrementa o número de membros na equipe antiga e incrementa na nova equipe
CREATE OR REPLACE FUNCTION atualizar_membros_equipe_de_apoio()
RETURNS TRIGGER AS $$
BEGIN
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
AFTER UPDATE ON participantes_equipe_de_apoio
FOR EACH ROW
WHEN (OLD.equipe_de_apoio <> NEW.equipe_de_apoio)
EXECUTE FUNCTION atualizar_membros_equipe_de_apoio();

-- ////////////////////////////////////////////////////////////

-- Verifica se o CPF do novo candidato tem um processo judicial no periodo de 5 anos para realizar a cadastro da candidatura
CREATE OR REPLACE FUNCTION verificar_ficha_limpa()
RETURNS TRIGGER AS $$
DECLARE
    data_limite DATE;
BEGIN
    data_limite := CURRENT_DATE - INTERVAL '5 years';

    IF EXISTS (
        SELECT 1
        FROM processo_judicial
        WHERE acusado = NEW.cpf
        AND data > data_limite
    ) THEN
        RAISE EXCEPTION 'Não é permitido inserir candidato. Pois o individuo possui um processo judicial recente.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_ficha_limpa
BEFORE INSERT ON candidato
FOR EACH ROW
EXECUTE FUNCTION verificar_ficha_limpa();

-- ////////////////////////////////////////////////////////////

-- Incrementa o número de integrantes do novo partido no insert da candidatura
CREATE OR REPLACE FUNCTION insert_nro_integrantes()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE partido
    SET nro_integrantes = nro_integrantes + 1
    WHERE id_partido = NEW.partido;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_insert_nro_integrantes
AFTER INSERT ON candidato
FOR EACH ROW
EXECUTE FUNCTION insert_nro_integrantes();

-- ////////////////////////////////////////////////////////////

-- Incrementa o número de integrantes do novo partido e decrementa o do antigo
CREATE OR REPLACE FUNCTION update_nro_integrantes()
RETURNS TRIGGER AS $$
BEGIN
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
AFTER UPDATE ON candidato
FOR EACH ROW
WHEN (OLD.partido IS DISTINCT FROM NEW.partido)
EXECUTE FUNCTION update_nro_integrantes();

-- ////////////////////////////////////////////////////////////

-- Decrementa o número de integrantes do partido correspondente ao delete na candidatura
CREATE OR REPLACE FUNCTION delete_nro_integrantes()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE partido
    SET nro_integrantes = nro_integrantes - 1
    WHERE id_partido = OLD.partido;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_delete_nro_integrantes
AFTER DELETE ON candidato
FOR EACH ROW
EXECUTE FUNCTION delete_nro_integrantes();