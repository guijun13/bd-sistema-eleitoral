CREATE OR REPLACE FUNCTION trigger_verifica_ficha_limpa() RETURNS TRIGGER AS $$
DECLARE processo_count INT;
BEGIN -- Verifica se o candidato principal é ficha-limpa
SELECT COUNT(*) INTO processo_count
FROM processo_judicial
WHERE acusado = NEW.candidato_principal
  AND data <= (NEW.ano::TEXT || '-12-31')::DATE
  AND data >= (NEW.ano::TEXT || '-12-31')::DATE - INTERVAL '5 years';
IF processo_count > 0 THEN RAISE EXCEPTION 'Indivíduo % não é ficha-limpa para a data %',
NEW.candidato_principal,
NEW.ano;
END IF;
-- Verifica se o candidato vice é ficha-limpa (se houver)
IF NEW.candidato_vice IS NOT NULL THEN
SELECT COUNT(*) INTO processo_count
FROM processo_judicial
WHERE acusado = NEW.candidato_vice
  AND data <= (NEW.ano::TEXT || '-12-31')::DATE
  AND data >= (NEW.ano::TEXT || '-12-31')::DATE - INTERVAL '5 years';
IF processo_count > 0 THEN RAISE EXCEPTION 'Indivíduo % não é ficha-limpa para a data %',
NEW.candidato_vice,
NEW.ano;
END IF;
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_candidatura_ficha_limpa BEFORE
INSERT
  OR
UPDATE ON candidatura FOR EACH ROW EXECUTE FUNCTION trigger_verifica_ficha_limpa();