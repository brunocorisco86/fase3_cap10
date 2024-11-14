
--- Produção total de uma determinada cultura por estado em uma safra

select
    u.ds_uf as ds_uf,
    a.nr_ano as nr_ano_safra,
    m.ds_unidade_medida as ds_unidade_medida,
    sum(p.qt_produzido) as qt_total_produzido
from
    t_mda_produtividade as p
inner join
    t_mda_cultura as c on p.cd_cultura = c.cd_cultura
inner join
    t_mda_unidade_medida as m on p.cd_unidade_medida_quantidade = m.cd_unidade_medida
inner join
    t_mda_unidade_federacao as u on p.cd_uf = u.cd_uf
inner join
    t_mda_calendario as a on p.cd_ano = a.cd_ano
where
    upper(c.ds_cultura) = upper('Arroz')
and
    upper(u.sg_uf) = upper('SP') -- São Paulo
and
    upper(m.ds_unidade_medida) = upper('Toneladas')
and
    a.nr_ano = 2023
group by
    u.ds_uf,
    m.ds_unidade_medida,
    a.nr_ano
;

--- Evolução da área plantada de uma cultura ao longo dos anos

--- Cultura: Cana-de-açúcar

select
    a.nr_ano as nr_ano_safra,
    m.ds_unidade_medida as ds_unidade_medida,
    sum(p.vl_producao) as qt_total_area_producao
from
    tb_mda_producao as p
inner join
    t_mda_etapa_producao as e on p.cd_etapa_producao = e.cd_etapa_producao
inner join
    t_mda_cultura as c on p.cd_cultura = c.cd_cultura
inner join
    t_mda_unidade_medida as m on p.cd_unidade_medida = m.cd_unidade_medida
inner join
    t_mda_calendario as a on p.cd_ano = a.cd_ano
where
    upper(c.ds_cultura) = upper('Cana-de-açúcar')
and
    upper(m.ds_unidade_medida) = upper('Hectares')
and
    upper(e.ds_fase_producao) = upper('Plantio')
group by
    m.ds_unidade_medida,
    a.nr_ano
;

--- Ranking dos estados com maior produtividade em uma cultura específica

select
    t.ds_uf,
    t.ds_unidade_medida,
    t.qt_total_produzido,
    row_number() over(partition by t.ds_uf order by t.qt_total_produzido desc) nu_ranking
from
(
    select
        u.ds_uf as ds_uf,
        m.ds_unidade_medida as ds_unidade_medida,
        sum(p.qt_produzido) as qt_total_produzido
    from
        t_mda_produtividade as p
    inner join
        t_mda_cultura as c on p.cd_cultura = c.cd_cultura
    inner join
        t_mda_unidade_medida as m on p.cd_unidade_medida_quantidade = m.cd_unidade_medida
    inner join
        t_mda_unidade_federacao as u on p.cd_uf = u.cd_uf
    where
        upper(c.ds_cultura) = upper('Milho')
    and
        upper(m.ds_unidade_medida) = upper('Toneladas')
    group by
        u.ds_uf,
        m.ds_unidade_medida
)
    as t
order by
    t.qt_total_produzido desc
;