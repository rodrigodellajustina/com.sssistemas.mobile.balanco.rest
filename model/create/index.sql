CREATE INDEX idx_balanco_01
  ON dados.balanco
  USING btree
  (cnpj COLLATE pg_catalog."default", chave COLLATE pg_catalog."default");

CREATE INDEX idx_cnpj
  ON dados.cnpj
  USING btree
  (cnpj COLLATE pg_catalog."default");
  
CREATE INDEX idx_balanco_01
  ON balanco
  USING btree
  (cnpj COLLATE pg_catalog."default", chaveacesso COLLATE pg_catalog."default");
  
CREATE INDEX idx_balanco_02
  ON balanco
  USING btree
  (cnpj COLLATE pg_catalog."default", chaveacesso COLLATE pg_catalog."default", qtdcontada);