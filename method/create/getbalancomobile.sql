-- Function: getbalancomobile(text, text)

CREATE OR REPLACE FUNCTION getbalancomobile(
    IN cnpj text,
    IN chaveacesso text)
  RETURNS TABLE(codproduto character varying, desproduto character varying, codbarra character, codmarca character, desmarca character varying, localizacao1 character, localizacao2 character, localizacao3 character, quantidade numeric, dtsincronismo character varying, codfabricante character varying) AS
$BODY$
DECLARE
    pCNPJ ALIAS FOR $1;
    pCHAVEACESSO ALIAS FOR $2;
begin

 update dados.chaveacesso set contadordownload = contadordownload + 1 
 where chaveacesso.CNPJ = CAST(pCNPJ AS VARCHAR(14)) AND chaveacesso.CHAVE = CAST(pCHAVEACESSO AS VARCHAR(20));

 return query select balanco.codproduto,
		     balanco.desproduto,
		     balanco.codbarra,
		     balanco.codmarca,
		     balanco.desmarca,
		     balanco.localizacao1,
		     balanco.localizacao2,
		     balanco.localizacao3,
			 cast(0 as numeric(10,3)) as quantidade,
			 cast('' as varchar(20)) as dtsincronismo,
		     balanco.codfabricante
	      from 
		     dados.balanco 
	      where balanco.CNPJ = CAST(pCNPJ AS VARCHAR(14)) AND balanco.CHAVE = CAST(pCHAVEACESSO AS VARCHAR(20))
	      order by posicao;

end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION getbalancomobile(text, text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION getbalancomobile(text, text) TO public;
GRANT EXECUTE ON FUNCTION getbalancomobile(text, text) TO postgres;
GRANT EXECUTE ON FUNCTION getbalancomobile(text, text) TO bal5nco;
