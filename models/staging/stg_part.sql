{{ config(materialized='table') }}
SELECT
    p_partkey AS part_id,
    p_name AS part_name,
    regexp_substr(p_mfgr, '#[0-9]+') as manufacturer,
    regexp_substr(p_brand, '#[0-9]+') as brand,
    p_type AS type,
    p_size AS size,
    p_retailprice AS retail_price
FROM {{ source('tpch_source', 'part') }}