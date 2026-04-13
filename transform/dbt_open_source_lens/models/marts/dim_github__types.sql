with int_github__types as (

    select * 
    from {{ ref('int_github__types') }}

),

dim_github__types as (

    select
        "type_id",
        "type_name",
        "type_description",
        "type_color",
        "type_created_at",
        "type_updated_at",
        "type_is_enabled"
    from int_github__types

)

select * from dim_github__types


