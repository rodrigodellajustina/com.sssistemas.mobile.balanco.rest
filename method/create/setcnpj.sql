-- Function: setcnpj(text, text, text)

CREATE OR REPLACE FUNCTION setcnpj(
    cnpj text,
    razao text,
    fantasia text)
  RETURNS text AS
$BODY$
 DECLARE 
    RCNPJ RECORD;
    pCNPJ ALIAS  FOR $1;    
    pRAZAO ALIAS FOR $2;
    pFANTASIA ALIAS FOR $3;    
BEGIN
 SELECT INTO RCNPJ CNPJ.CNPJ FROM DADOS.CNPJ WHERE CNPJ.CNPJ = CAST(pCNPJ AS VARCHAR(14));
 IF FOUND THEN
    RETURN '1';
 ELSE 
    INSERT INTO DADOS.CNPJ (CNPJ, RAZAO, FANTASIA, ATIVO,TOKEN,SENHA) VALUES (pCNPJ, pRAZAO, pFANTASIA, 1, '', MD5('ni'));
    RETURN '1';
 END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION setcnpj(text, text, text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION setcnpj(text, text, text) TO public;
GRANT EXECUTE ON FUNCTION setcnpj(text, text, text) TO postgres;
GRANT EXECUTE ON FUNCTION setcnpj(text, text, text) TO bal5nco;
