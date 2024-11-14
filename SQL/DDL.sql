
-- Origem

CREATE TABLE t_ibge_1612_lavouras_temporarias (
    cod_unidade_federacao VARCHAR2(100),
    ano VARCHAR2(100),
    cultura VARCHAR2(100),
    valor VARCHAR2(100),
    unidade VARCHAR2(100),
    Indicador VARCHAR2(100),
);

CREATE TABLE t_ibge_1613_lavouras_permanentes (
    cod_unidade_federacao VARCHAR2(100),
    ano VARCHAR2(100),
    cultura VARCHAR2(100),
    valor VARCHAR2(100),
    unidade VARCHAR2(100),
    Indicador VARCHAR2(100),
);

CREATE TABLE t_ibge_areas_territoriais_uf (
    cd_uf VARCHAR2(100),
    cd_rg VARCHAR2(100),
    nm_uf VARCHAR2(100),
    nm_uf_sigla VARCHAR2(100)
);

CREATE TABLE t_ibge_areas_territoriais_regiao (
    cd_rg VARCHAR2(100),
    nm_rg VARCHAR2(100)
);

-- Modelo

CREATE TABLE t_mda_calendario (
    cd_ano INTEGER NOT NULL,
    nr_ano INTEGER
);

ALTER TABLE t_mda_calendario ADD CONSTRAINT t_mda_calendario_pk PRIMARY KEY ( cd_ano );

CREATE TABLE t_mda_cultura (
    cd_cultura             INTEGER NOT NULL,
    cd_refinamento_cultura INTEGER NOT NULL,
    ds_cultura             VARCHAR2(100)
);

ALTER TABLE t_mda_cultura ADD CONSTRAINT t_mda_cultura_pk PRIMARY KEY ( cd_cultura );

CREATE TABLE t_mda_etapa_producao (
    cd_etapa_producao INTEGER NOT NULL,
    ds_fase_producao  VARCHAR2(100)
);

ALTER TABLE t_mda_etapa_producao ADD CONSTRAINT t_mda_etapa_producao_pk PRIMARY KEY ( cd_etapa_producao );

CREATE TABLE t_mda_produtividade (
    cd_produtividade             INTEGER NOT NULL,
    cd_cultura                   INTEGER NOT NULL,
    cd_uf                        INTEGER NOT NULL,
    cd_ano                       INTEGER NOT NULL,
    cd_unidade_medida_quantidade INTEGER NOT NULL,
    cd_unidade_medida_valor      INTEGER NOT NULL,
    qt_produzido                 INTEGER,
    vl_milhao_produzido          NUMBER(18, 2)
);

ALTER TABLE t_mda_produtividade ADD CONSTRAINT t_mda_produtividade_pk PRIMARY KEY ( cd_produtividade );

CREATE TABLE t_mda_refinamento_cultura (
    cd_refinamento_cultura INTEGER NOT NULL,
    ds_refinamento_cultura VARCHAR2(100)
);

ALTER TABLE t_mda_refinamento_cultura ADD CONSTRAINT t_mda_refinamento_cultura_pk PRIMARY KEY ( cd_refinamento_cultura );

CREATE TABLE t_mda_regiao (
    cd_regiao INTEGER NOT NULL,
    ds_regiao VARCHAR2(100)
);

ALTER TABLE t_mda_regiao ADD CONSTRAINT t_mda_regiao_pk PRIMARY KEY ( cd_regiao );

CREATE TABLE t_mda_unidade_federacao (
    cd_uf     INTEGER NOT NULL,
    cd_regiao INTEGER NOT NULL,
    sg_uf     VARCHAR2(2),
    ds_uf     VARCHAR2(50)
);

ALTER TABLE t_mda_unidade_federacao ADD CONSTRAINT t_mda_unidade_federacao_pk PRIMARY KEY ( cd_uf );

CREATE TABLE t_mda_unidade_medida (
    cd_unidade_medida INTEGER NOT NULL,
    ds_unidade_medida VARCHAR2(100)
);

ALTER TABLE t_mda_unidade_medida ADD CONSTRAINT t_mda_unidade_medida_pk PRIMARY KEY ( cd_unidade_medida );

CREATE TABLE tb_mda_producao (
    cd_producao       INTEGER NOT NULL,
    cd_etapa_producao INTEGER NOT NULL,
    cd_cultura        INTEGER NOT NULL,
    cd_uf             INTEGER NOT NULL,
    cd_ano            INTEGER NOT NULL,
    cd_unidade_medida INTEGER NOT NULL,
    vl_producao       NUMBER(18, 2)
);

ALTER TABLE tb_mda_producao ADD CONSTRAINT tb_mda_producao_pk PRIMARY KEY ( cd_producao );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_mda_cultura
    ADD CONSTRAINT t_mda_cultura_t_mda_refinamento_cultura_fk FOREIGN KEY ( cd_refinamento_cultura )
        REFERENCES t_mda_refinamento_cultura ( cd_refinamento_cultura );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_mda_produtividade
    ADD CONSTRAINT t_mda_produtividade_t_mda_calendario_fk FOREIGN KEY ( cd_ano )
        REFERENCES t_mda_calendario ( cd_ano );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_mda_produtividade
    ADD CONSTRAINT t_mda_produtividade_t_mda_cultura_fk FOREIGN KEY ( cd_cultura )
        REFERENCES t_mda_cultura ( cd_cultura );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_mda_produtividade
    ADD CONSTRAINT t_mda_produtividade_t_mda_unidade_federacao_fk FOREIGN KEY ( cd_uf )
        REFERENCES t_mda_unidade_federacao ( cd_uf );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_mda_produtividade
    ADD CONSTRAINT t_mda_produtividade_t_mda_unidade_medida_fk FOREIGN KEY ( cd_unidade_medida_valor )
        REFERENCES t_mda_unidade_medida ( cd_unidade_medida );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_mda_produtividade
    ADD CONSTRAINT t_mda_produtividade_t_mda_unidade_medida_fkv2 FOREIGN KEY ( cd_unidade_medida_quantidade )
        REFERENCES t_mda_unidade_medida ( cd_unidade_medida );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_mda_unidade_federacao
    ADD CONSTRAINT t_mda_unidade_federacao_t_mda_regiao_fk FOREIGN KEY ( cd_regiao )
        REFERENCES t_mda_regiao ( cd_regiao );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE tb_mda_producao
    ADD CONSTRAINT tb_mda_producao_t_mda_calendario_fk FOREIGN KEY ( cd_ano )
        REFERENCES t_mda_calendario ( cd_ano );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE tb_mda_producao
    ADD CONSTRAINT tb_mda_producao_t_mda_cultura_fk FOREIGN KEY ( cd_cultura )
        REFERENCES t_mda_cultura ( cd_cultura );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE tb_mda_producao
    ADD CONSTRAINT tb_mda_producao_t_mda_etapa_producao_fk FOREIGN KEY ( cd_etapa_producao )
        REFERENCES t_mda_etapa_producao ( cd_etapa_producao );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE tb_mda_producao
    ADD CONSTRAINT tb_mda_producao_t_mda_unidade_federacao_fk FOREIGN KEY ( cd_uf )
        REFERENCES t_mda_unidade_federacao ( cd_uf );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE tb_mda_producao
    ADD CONSTRAINT tb_mda_producao_t_mda_unidade_medida_fk FOREIGN KEY ( cd_unidade_medida )
        REFERENCES t_mda_unidade_medida ( cd_unidade_medida );
