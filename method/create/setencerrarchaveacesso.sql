-- Function: setencerrarchaveacesso(text, text)

CREATE OR REPLACE FUNCTION setencerrarchaveacesso(
    cnpj text,
    chaveacesso text)
  RETURNS text AS
$BODY$
 DECLARE 
    RCHAVEACESSO RECORD;
    pCNPJ ALIAS FOR $1;
    pCHAVEACESSO ALIAS FOR $2;
BEGIN
 SELECT INTO RCHAVEACESSO CHAVEACESSO.CNPJ, CHAVEACESSO.CHAVE, CHAVEACESSO.ENCERRADA FROM DADOS.CHAVEACESSO WHERE CHAVEACESSO.CNPJ = CAST(pCNPJ AS VARCHAR(14)) AND CHAVEACESSO.CHAVE = CAST(pCHAVEACESSO AS VARCHAR(20));
 IF FOUND THEN
    IF RCHAVEACESSO.ENCERRADA = 0 THEN
	UPDATE DADOS.CHAVEACESSO SET ENCERRADA = 1 WHERE CHAVEACESSO.CNPJ = CAST(pCNPJ AS VARCHAR(14)) AND CHAVEACESSO.CHAVE = CAST(pCHAVEACESSO AS VARCHAR(20));
	RETURN '1';
    ELSE
	RETURN '0'; 
    END IF;    
 ELSE 
    RETURN '0';
 END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION setencerrarchaveacesso(text, text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION setencerrarchaveacesso(text, text) TO public;
GRANT EXECUTE ON FUNCTION setencerrarchaveacesso(text, text) TO postgres;
GRANT EXECUTE ON FUNCTION setencerrarchaveacesso(text, text) TO bal5nco;
