CREATE OR REPLACE FUNCTION aumentar_membros_equipe_de_apoio()
RETURNS TRIGGER AS $$
BEGIN
    -- Incrementa o número de membros na equipe correspondente
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

CREATE OR REPLACE FUNCTION diminuir_membros_equipe_de_apoio()
RETURNS TRIGGER AS $$
BEGIN
    -- Decrementa o número de membros na equipe correspondente
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

CREATE OR REPLACE FUNCTION atualizar_membros_equipe_de_apoio()
RETURNS TRIGGER AS $$
BEGIN
    -- Decrementa o número de membros na equipe antiga
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
AFTER UPDATE ON participantes_equipe_de_apoio
FOR EACH ROW
WHEN (OLD.equipe_de_apoio <> NEW.equipe_de_apoio)
EXECUTE FUNCTION atualizar_membros_equipe_de_apoio();

-- ////////////////////////////////////////////////////////////

CREATE OR REPLACE FUNCTION verificar_ficha_limpa()
RETURNS TRIGGER AS $$
DECLARE
    data_limite DATE;
BEGIN
    -- Definindo a data limite como 5 anos atrás a partir da data atual
    data_limite := CURRENT_DATE - INTERVAL '5 years';

    -- Verifica se o CPF do novo candidato tem um processo judicial recente
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