{{
    config(
        materialized='incremental',
        unique_key='order_id'
    )
}}

SELECT
    o_orderkey AS order_id,
    o_custkey AS customer_id,
    o_orderstatus AS status_code,
    case 
            when o_orderpriority like '1%' then 'Urgent'
            when o_orderpriority like '2%' then 'High'
            when o_orderpriority like '3%' then 'Medium'
            when o_orderpriority like '4%' then 'Not Specified'
            when o_orderpriority like '5%' then 'Low'
            else 'NS'
    end as order_priority,
    o_totalprice AS total_price,
    o_orderdate AS order_date
FROM {{ source('tpch_source', 'orders') }}

{% if is_incremental() %}
  WHERE o_orderdate >= (select max(order_date) from {{ this }})
{% endif %}