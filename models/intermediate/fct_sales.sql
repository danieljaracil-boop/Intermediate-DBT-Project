{{ config(materialized='table') }}

SELECT
    lineitem_id,
    order_id,
    customer_id,
    part_id,
    supplier_id,
    order_date,
    quantity,
    extended_price,
    net_item_sales_amount
FROM {{ ref('int_order_items') }}