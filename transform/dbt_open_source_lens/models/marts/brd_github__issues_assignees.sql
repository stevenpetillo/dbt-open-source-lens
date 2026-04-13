with stg_github__issues as (

    select * 
    from {{ ref('stg_github__issues') }}
    where assignees is not null

),

brd_github__issues_assignees as (

    select distinct
        "issue_id",
        cast(jsonb_array_elements(assignees)->>'id' as INT) as "assignee_id"
    from stg_github__issues
    
)

select * from brd_github__issues_assignees