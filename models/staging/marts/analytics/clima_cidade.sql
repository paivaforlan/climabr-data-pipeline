{{ config(
    materialized='table',
    tags=['analytics']
) }}


select

    l.cidade,

    t.data_previsao,
    t.ano,
    t.mes,
    t.nome_mes,
    t.trimestre,

    f.temperatura_maxima,
    f.temperatura_minima,
    f.temperatura_media,
    f.sensacao_termica,

    f.umidade,
    f.precipitacao,
    f.probabilidade_precipitacao,

    f.velocidade_vento,
    f.rajada_vento,

    f.indice_uv,

    f.condicao_climatica,
    f.descricao_clima,

    f.data_ingestao


from {{ ref('fato_previsao_clima') }} f

left join {{ ref('dim_localidade') }} l
    on f.id_localidade = l.id_localidade

left join {{ ref('dim_tempo') }} t
    on f.id_tempo = t.id_tempo