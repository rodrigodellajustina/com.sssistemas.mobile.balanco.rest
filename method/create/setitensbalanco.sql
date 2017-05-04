-- Function: setitensbalanco(json)

CREATE OR REPLACE FUNCTION setitensbalanco(pjson json)
  RETURNS text AS
$BODY$
 DECLARE
    jsonproduto ALIAS FOR $1;    
BEGIN

insert into dados.balanco ( 
   select 
   cast(json_to_table.cnpj as varchar(14)), 
   cast(json_to_table.chave as varchar(20)), 
   cast(json_to_table.codproduto as varchar(6)), 
   cast(json_to_table.desproduto as varchar(120)), 
   cast(json_to_table.codbarra as varchar(15)), 
   cast(json_to_table.codmarca as varchar(5)), 
   cast(json_to_table.desmarca as varchar(65)),
   cast(json_to_table.empfil as char(4)),
   cast(json_to_table.localizacao1 as char(3)),
   cast(json_to_table.localizacao2 as char(3)),
   cast(json_to_table.localizacao3 as char(3)),
   cast(json_to_table.codfabricante as char(16))
from (
	select * from json_to_recordset(jsonproduto) as x(cnpj text, chave text, codproduto text, desproduto text, codbarra text, codmarca text, desmarca text, empfil text, localizacao1 text, localizacao2 text, localizacao3 text, codfabricante text)
     ) as json_to_table

);
RETURN 0;
 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION setitensbalanco(json)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION setitensbalanco(json) TO public;
GRANT EXECUTE ON FUNCTION setitensbalanco(json) TO postgres;
GRANT EXECUTE ON FUNCTION setitensbalanco(json) TO bal5nco;
