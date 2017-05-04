-- Function: seteliminarchaveacesso(text, text)

CREATE OR REPLACE FUNCTION seteliminarchaveacesso(
    cnpj text,
    chaveacesso text)
  RETURNS text AS
$BODY$
 DECLARE 
    RCHAVEACESSO RECORD;
    pCNPJ ALIAS FOR $1;
    pCHAVEACESSO ALIAS FOR $2;
BEGIN
 SELECT INTO RCHAVEACESSO CHAVEACESSO.CNPJ, CHAVEACESSO.CHAVE, CHAVEACESSO.ELIMINADA FROM DADOS.CHAVEACESSO WHERE CHAVEACESSO.CNPJ = CAST(pCNPJ AS VARCHAR(14)) AND CHAVEACESSO.CHAVE = CAST(pCHAVEACESSO AS VARCHAR(20));
 IF FOUND THEN
    IF RCHAVEACESSO.ELIMINADA = 0 THEN
	UPDATE DADOS.CHAVEACESSO SET ELIMINADA = 1 WHERE CHAVEACESSO.CNPJ = CAST(pCNPJ AS VARCHAR(14)) AND CHAVEACESSO.CHAVE = CAST(pCHAVEACESSO AS VARCHAR(20));
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
ALTER FUNCTION seteliminarchaveacesso(text, text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION seteliminarchaveacesso(text, text) TO public;
GRANT EXECUTE ON FUNCTION seteliminarchaveacesso(text, text) TO postgres;
GRANT EXECUTE ON FUNCTION seteliminarchaveacesso(text, text) TO bal5nco;
