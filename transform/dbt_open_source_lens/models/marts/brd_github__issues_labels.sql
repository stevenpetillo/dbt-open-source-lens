with stg_github__issues as (

    select * 
    from {{ ref('stg_github__issues') }}
    where labels is not null

),

brd_github__issues_labels as (

    select distinct
        "issue_id",
        cast(jsonb_array_elements(labels)->>'id' as BIGINT) as "label_id"
    from stg_github__issues
    
)

select * from brd_github__issues_labels

