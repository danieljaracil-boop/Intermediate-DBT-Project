{{ config(materialized='view') }}

WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),
line_item AS (
    SELECT * FROM {{ ref('stg_lineitem') }}
)

SELECT
    li.lineitem_id,
    li.order_id,
    o.customer_id,
    o.order_date,
    li.part_id,
    li.supplier_id,
    li.quantity,
    li.extended_price,
    li.discount_percentage,
    -- Cálculo del ingreso neto
    (li.extended_price * (1 - li.discount_percentage)) AS net_item_sales_amount
FROM line_item li
JOIN orders o ON li.order_id = o.order_id

