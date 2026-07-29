{{ config(
    materialized='view',
    tags=['staging']
) }}

WITH source_data AS (

    SELECT
        latitude,
        longitude,
        resolvedaddress,
        address,
        timezone,
        days,
        date AS data_ingestao

    FROM {{ source('clima_raw', 'projeto_clima_dbtpos') }}

),

clima_diario AS (

    SELECT

        latitude,
        longitude,

        resolvedaddress AS endereco_resolvido,
        address AS cidade,
        timezone,

        day.datetime AS data_previsao,

        day.tempmax AS temperatura_maxima,
        day.tempmin AS temperatura_minima,
        day.temp AS temperatura_media,

        day.feelslike AS sensacao_termica,

        day.humidity AS umidade,

        day.precip AS precipitacao,
        day.precipprob AS probabilidade_precipitacao,

        day.windspeed AS velocidade_vento,
        day.windgust AS rajada_vento,
        day.winddir AS direcao_vento,

        day.pressure AS pressao_atmosferica,

        day.cloudcover AS cobertura_nuvens,

        day.visibility AS visibilidade,

        day.solarradiation AS radiacao_solar,
        day.uvindex AS indice_uv,

        day.conditions AS condicao_climatica,
        day.description AS descricao_clima,

        day.icon AS icone_clima,

        data_ingestao

    FROM source_data

    CROSS JOIN UNNEST(days) AS t(day)

)

SELECT *

FROM clima_diario