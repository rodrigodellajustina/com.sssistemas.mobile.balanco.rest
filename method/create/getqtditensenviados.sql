-- Function: getqtditensenviados(text, text)

CREATE OR REPLACE FUNCTION getqtditensenviados(
    IN cnpj text,
    IN chaveacesso text)
  RETURNS TABLE(qtdtotalcontado bigint, qtdtotalcontado2 bigint) AS
$BODY$
DECLARE
    pCNPJ ALIAS FOR $1;
    pCHAVEACESSO ALIAS FOR $2;
begin

 return query select 
		count(*) as qtdtotalcontado,
		count(*) as qtdtotalcontado2
	      from 
		     public.balanco
	      where balanco.CNPJ = CAST(pCNPJ AS VARCHAR(14)) AND balanco.CHAVEACESSO = CAST(pCHAVEACESSO AS VARCHAR(20));

end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION getqtditensenviados(text, text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION getqtditensenviados(text, text) TO public;
GRANT EXECUTE ON FUNCTION getqtditensenviados(text, text) TO postgres;
GRANT EXECUTE ON FUNCTION getqtditensenviados(text, text) TO bal5nco;
