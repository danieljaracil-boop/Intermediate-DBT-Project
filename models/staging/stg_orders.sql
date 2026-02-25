{{
    config(
        materialized='incremental',
        unique_key='O_ORDERKEY'
    )
}}

SELECT
    o_orderkey AS order_id,
    o_custkey AS customer_id,
    o_orderstatus AS status_code,
    o_totalprice AS total_price,
    o_orderdate AS order_date
FROM {{ source('tpch_source', 'orders') }}

{% if is_incremental() %}
  WHERE o_orderdate >= (select max(order_date) from {{ this }})
{% endif %}