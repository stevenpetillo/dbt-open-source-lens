with int_github__labels as (

    select * 
    from {{ ref('int_github__labels') }}

),

dim_github__labels as (

    select
        "label_id",
        "label_name",
        "label_description",
        "label_color",
        "label_default"
    from int_github__labels

)

select * from dim_github__labels


