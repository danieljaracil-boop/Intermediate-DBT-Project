with nations as (
    select * from {{ ref('stg_nation') }}
),

regions as (
    select * from {{ ref('stg_region') }}
),

joined as (
    select
        n.nation_id,
        n.nation_name,
        r.region_name
    from nations n
    left join regions r 
        on n.region_id = r.region_id
)

select * from joined