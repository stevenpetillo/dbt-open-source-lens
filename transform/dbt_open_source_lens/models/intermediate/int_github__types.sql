with stg_github__issues as (

    select * 
    from {{ ref('stg_github__issues') }}
    where "type" is not null

),

int_github__types as (

    select distinct
        cast("type"->>'id' as INT) as "type_id",
        cast("type"->>'name' as VARCHAR(7)) as "type_name",
        cast("type"->>'color' as VARCHAR(6)) as "type_color",
        cast("type"->>'node_id' as VARCHAR(19)) as "type_node_id",
        cast("type"->>'created_at' as TIMESTAMP) as "type_created_at",
        cast("type"->>'is_enabled' as BOOLEAN) as "type_is_enabled",
        cast("type"->>'updated_at' as TIMESTAMP) as "type_updated_at",
        cast("type"->>'description' as VARCHAR(37)) as "type_description"
    from stg_github__issues

)

select * from int_github__types


