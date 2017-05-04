-- Function: getchaveacessoencerrada(text, text)

CREATE OR REPLACE FUNCTION getchaveacessoencerrada(
    cnpj text,
    chaveacesso text)
  RETURNS text AS
$BODY$
 DECLARE 
    RCHAVEACESSO RECORD;
    pCNPJ ALIAS FOR $1;
    pCHAVEACESSO ALIAS FOR $2;
BEGIN
 SELECT INTO RCHAVEACESSO CHAVEACESSO.CNPJ, CHAVEACESSO.CHAVE FROM DADOS.CHAVEACESSO WHERE CHAVEACESSO.CNPJ = CAST(pCNPJ AS VARCHAR(14)) AND CHAVEACESSO.CHAVE = CAST(pCHAVEACESSO AS VARCHAR(20)) AND encerrada = 1;
 IF NOT FOUND THEN
    -- NÃO ENCERRAADA
    RETURN '0';
 ELSE
    -- ENCERRADA
    RETURN '1';
 END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION getchaveacessoencerrada(text, text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION getchaveacessoencerrada(text, text) TO public;
GRANT EXECUTE ON FUNCTION getchaveacessoencerrada(text, text) TO postgres;
GRANT EXECUTE ON FUNCTION getchaveacessoencerrada(text, text) TO bal5nco;
