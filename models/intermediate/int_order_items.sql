{{ config(materialized='view') }}

-- models/intermediate/int_order_items.sql
with orders as (
    select * from {{ ref('stg_orders') }}
),
line_items as (
    select * from {{ ref('stg_lineitem') }}
),
suppliers as (
    select * from {{ ref('stg_supplier') }}
)

select
    l.lineitem_id,
    l.order_id,
    o.customer_id,
    l.part_id,
    l.supplier_id,
    s.nation_id, -- Ahora ITEM tendrá esta columna disponible
    o.order_date,
    l.quantity,
    -- Aquí va tu macro de cálculo neto
    {{ calculate_discounted_amount('l.extended_price', 'l.discount_percentage') }} as net_item_sales_amount
from line_items l
join orders o on l.order_id = o.order_id
join suppliers s on l.supplier_id = s.supplier_id

