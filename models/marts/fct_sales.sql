{{ config(materialized='table') }}

SELECT
    item.lineitem_id,
    item.order_id,
    item.customer_id,
    item.part_id,
    item.supplier_id,
    item.nation_id,
    item.order_date AS date_id, -- Clave de unión con dim_date
    item.quantity,
    item.net_item_sales_amount, 
    SUM(item.net_item_sales_amount) OVER (PARTITION BY item.order_id) AS total_order_amount
FROM {{ ref('int_order_items') }} AS item
WHERE item.order_date IS NOT NULL