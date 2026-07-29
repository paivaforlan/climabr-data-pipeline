{{ config(
    materialized='table',
    tags=['mart','fato']
) }}

select

    loc.id_localidade,
    tmp.id_tempo,

    stg.temperatura_maxima,
    stg.temperatura_minima,
    stg.temperatura_media,
    stg.sensacao_termica,
    stg.umidade,
    stg.precipitacao,
    stg.probabilidade_precipitacao,
    stg.velocidade_vento,
    stg.rajada_vento,
    stg.direcao_vento,
    stg.pressao_atmosferica,
    stg.cobertura_nuvens,
    stg.visibilidade,
    stg.radiacao_solar,
    stg.indice_uv,
    stg.condicao_climatica,
    stg.descricao_clima,
    stg.icone_clima,
    stg.data_ingestao


from {{ ref('stg_clima') }} stg


left join {{ ref('dim_localidade') }} loc

    on stg.cidade = loc.cidade


left join {{ ref('dim_tempo') }} tmp

    on cast(stg.data_previsao as date) = tmp.data_previsao