{{ config(
    materialized='table',
    tags=['mart','dimensao']
) }}

with datas as (

    select distinct
        cast(data_previsao as date) as data_previsao_date
    from {{ ref('stg_clima') }}

)

select

    row_number() over(order by data_previsao_date) as id_tempo,

    data_previsao_date as data_previsao,

    year(data_previsao_date) as ano,
    month(data_previsao_date) as mes,
    day(data_previsao_date) as dia,
    week(data_previsao_date) as semana,

    date_format(data_previsao_date, '%M') as nome_mes,

    quarter(data_previsao_date) as trimestre,

    date_format(data_previsao_date, '%W') as dia_semana,

    day_of_week(data_previsao_date) as numero_dia_semana,

    case
        when day_of_week(data_previsao_date) in (6,7)
            then true
        else false
    end as fim_de_semana

from datas