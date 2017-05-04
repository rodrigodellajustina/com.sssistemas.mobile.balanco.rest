-- Function: getchaveacessoeliminada(text, text)

CREATE OR REPLACE FUNCTION getchaveacessoeliminada(
    cnpj text,
    chaveacesso text)
  RETURNS text AS
$BODY$
 DECLARE 
    RCHAVEACESSO RECORD;
    pCNPJ ALIAS FOR $1;
    pCHAVEACESSO ALIAS FOR $2;
BEGIN
 SELECT INTO RCHAVEACESSO CHAVEACESSO.CNPJ, CHAVEACESSO.CHAVE FROM DADOS.CHAVEACESSO WHERE CHAVEACESSO.CNPJ = CAST(pCNPJ AS VARCHAR(14)) AND CHAVEACESSO.CHAVE = CAST(pCHAVEACESSO AS VARCHAR(20)) AND eliminada = 1;
 IF NOT FOUND THEN
    -- INEXISTENTE
    RETURN '0';
 ELSE
    -- ATIVO
    RETURN '1';
 END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION getchaveacessoeliminada(text, text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION getchaveacessoeliminada(text, text) TO public;
GRANT EXECUTE ON FUNCTION getchaveacessoeliminada(text, text) TO postgres;
GRANT EXECUTE ON FUNCTION getchaveacessoeliminada(text, text) TO bal5nco;
