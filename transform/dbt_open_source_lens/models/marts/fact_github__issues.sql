with int_github__issues as (

    select * 
    from {{ ref('int_github__issues') }}

),

fact_github__issues as (

    select 
        "issue_id",
        "issue_number",
        "created_at",
        "updated_at",
        "closed_at",
        "user_id",
        "assignee_id",
        "closed_by_id"
        "type_id",
        "milestone_id",
        "comments_count",
        "pull_request_url" -- foreign key to pull_requests table
    from int_github__issues
    
)

select * from fact_github__issues

