{{ config(materialized='table') }}
SELECT
    s_suppkey AS supplier_id,
    s_name AS supplier_name,
    s_address AS address,
    s_nationkey AS nation_id,
    s_phone AS phone_number,
    s_acctbal AS account_balance
FROM {{ source('tpch_source', 'supplier') }}





