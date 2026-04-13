with stg_github__issues as (

    select * 
    from {{ ref('stg_github__issues') }}
    where "labels" is not null

),

int_github__labels as (

    select distinct
        cast(jsonb_array_elements(labels)->>'id' as BIGINT) as "label_id",
        cast(jsonb_array_elements(labels)->>'name' as VARCHAR(27)) as "label_name",
        cast(jsonb_array_elements(labels)->>'description' as VARCHAR(94)) as "label_description",
        cast(jsonb_array_elements(labels)->>'color' as VARCHAR(6)) as "label_color",
        cast(jsonb_array_elements(labels)->>'default' as BOOLEAN) as "label_default",
        cast(jsonb_array_elements(labels)->>'node_id' as VARCHAR(25)) as "label_node_id",
        cast(jsonb_array_elements(labels)->>'url' as VARCHAR(81)) as "label_url"
    from stg_github__issues

)

select * from int_github__labels


