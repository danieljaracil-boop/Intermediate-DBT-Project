{{ config(materialized='table') }}
SELECT
    {{ dbt_utils.generate_surrogate_key(['l_orderkey', 'l_linenumber']) }} AS lineitem_id,
    l_orderkey AS order_id,
    l_partkey AS part_id,
    l_suppkey AS supplier_id,
    l_linenumber AS line_number,
    l_quantity AS quantity,
    l_extendedprice AS extended_price,
    l_discount AS discount_percentage,
    l_tax AS tax_rate,
    l_shipdate AS ship_date
FROM {{ source('tpch_source', 'lineitem') }}

