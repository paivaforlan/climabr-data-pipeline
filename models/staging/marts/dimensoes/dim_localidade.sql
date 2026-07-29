{{ config(
    materialized='table',
    tags=['mart','dimensao']
) }}

with localidades as (

    select distinct
        cidade,
        latitude,
        longitude,
        timezone,
        endereco_resolvido

    from {{ ref('stg_clima') }}

)

select

    row_number() over(order by cidade) as id_localidade,

    cidade,
    latitude,
    longitude,
    timezone,
    endereco_resolvido

from localidades