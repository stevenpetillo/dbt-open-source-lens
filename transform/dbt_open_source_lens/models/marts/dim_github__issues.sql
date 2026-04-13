with int_github__issues as (

    select * 
    from {{ ref('int_github__issues') }}

),

dim_github__issues as (

    select 
        "issue_id",
        "issue_title",
        "issue_body",
        "issue_state",
        "issue_state_reason",
        "is_draft",
        "is_locked",
        "active_lock_reason",
        "author_association",
        "issue_url"
    from int_github__issues
    
)

select * from dim_github__issues