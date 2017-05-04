-- Function: getbalancomobilecontato(text, text)

CREATE OR REPLACE FUNCTION getbalancomobilecontato(
    cnpj text,
    chaveacesso text)
  RETURNS json AS
$BODY$
  select array_to_json(array_agg(row_to_json(t))) from (select codproduto,qtdcontada,localizacao1, localizacao2, localizacao3 from balanco where cnpj = $1 and chaveacesso =  $2) t ;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION getbalancomobilecontato(text, text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION getbalancomobilecontato(text, text) TO public;
GRANT EXECUTE ON FUNCTION getbalancomobilecontato(text, text) TO postgres;
GRANT EXECUTE ON FUNCTION getbalancomobilecontato(text, text) TO bal5nco;
