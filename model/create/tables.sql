-- Table: dados.chaveacesso

CREATE TABLE dados.chaveacesso
(
  cnpj character varying(14) NOT NULL,
  chave character varying(20) NOT NULL,
  dataenvio timestamp without time zone DEFAULT now(),
  contadordownload bigint DEFAULT 0,
  eliminada integer DEFAULT 0,
  encerrada integer DEFAULT 0,
  alterarlocalizacao integer NOT NULL DEFAULT 1,
  CONSTRAINT chaveacesso_pkey PRIMARY KEY (cnpj, chave),
  CONSTRAINT fk_cnpj_chaveacesso FOREIGN KEY (cnpj)
      REFERENCES dados.cnpj (cnpj) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE dados.chaveacesso
  OWNER TO postgres;
GRANT ALL ON TABLE dados.chaveacesso TO postgres;
GRANT SELECT, UPDATE, INSERT ON TABLE dados.chaveacesso TO bal5nco;
GRANT UPDATE(contadordownload) ON dados.chaveacesso TO bal5nco;

-- Table: dados.cnpj

CREATE TABLE dados.cnpj
(
  cnpj character varying(14) NOT NULL,
  razao character varying(200),
  fantasia character varying(200),
  ativo integer,
  token text,
  senha text,
  CONSTRAINT cnpj_pkey PRIMARY KEY (cnpj)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE dados.cnpj
  OWNER TO postgres;
GRANT ALL ON TABLE dados.cnpj TO postgres;
GRANT SELECT, INSERT ON TABLE dados.cnpj TO bal5nco;

-- Table: dados.balanco

CREATE TABLE dados.balanco
(
  cnpj character varying(14) NOT NULL,
  chave character varying(20) NOT NULL,
  codproduto character varying(6) NOT NULL,
  desproduto character varying(120) NOT NULL,
  codbarra character(15) NOT NULL,
  codmarca character(5) NOT NULL,
  desmarca character varying(65) NOT NULL,
  empfil character(4) NOT NULL,
  localizacao1 character(3) NOT NULL,
  localizacao2 character(3) NOT NULL,
  localizacao3 character(3) NOT NULL,
  codfabricante character varying(16),
  posicao integer not null default 0,
  CONSTRAINT balanco_pkey PRIMARY KEY (cnpj, chave, codproduto),
  CONSTRAINT fk_balanco_chaveacesso FOREIGN KEY (cnpj, chave)
      REFERENCES dados.chaveacesso (cnpj, chave) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE dados.balanco
  OWNER TO postgres;
GRANT ALL ON TABLE dados.balanco TO postgres;
GRANT SELECT, INSERT ON TABLE dados.balanco TO bal5nco;

-- Table: balanco

CREATE TABLE balanco
(
  cnpj character varying(14) NOT NULL,
  chaveacesso character varying(20) NOT NULL,
  codproduto character varying(6) NOT NULL,
  qtdcontada numeric(10,3) NOT NULL,
  dtenvio timestamp without time zone NOT NULL DEFAULT now(),
  localizacao1 character(3) NOT NULL DEFAULT ''::bpchar,
  localizacao2 character(3) NOT NULL DEFAULT ''::bpchar,
  localizacao3 character(3) NOT NULL DEFAULT ''::bpchar,
  CONSTRAINT balanco_pkey PRIMARY KEY (cnpj, chaveacesso, codproduto),
  CONSTRAINT fk_balanco_balanco FOREIGN KEY (cnpj, chaveacesso, codproduto)
      REFERENCES dados.balanco (cnpj, chave, codproduto) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE balanco
  OWNER TO postgres;
GRANT ALL ON TABLE balanco TO postgres;
GRANT SELECT, INSERT, DELETE ON TABLE balanco TO bal5nco;
