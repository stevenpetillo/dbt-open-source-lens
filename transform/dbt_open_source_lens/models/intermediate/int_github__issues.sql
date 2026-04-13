with stg_github__issues as (

    select * 
    from {{ ref('stg_github__issues') }}

),

int_github__issues as (

    select 
        "issue_url",
        "repository_url",
        "labels_url",
        "comments_url",
        "events_url",
        "html_url",
        "issue_id",
        "issue_node_id",
        "issue_number",
        "issue_title",
        cast("user"->>'id' as INT) as "user_id",
        "issue_state",
        "is_locked",
        cast("assignee"->>'id' as INT) as "assignee_id",
        cast("milestone"->>'id' as INT) as "milestone_id",
        "comments_count",
        "created_at",
        "updated_at",
        "closed_at",
        "author_association",
        cast("type"->>'id' as INT) as "type_id",
        "active_lock_reason",
        "is_draft",
        cast("pull_request"->>'url' as VARCHAR(58)) as "pull_request_url",
        "issue_body",
        cast("closed_by"->>'id' as INT) as "closed_by_id",
        "timeline_url",
        "performed_via_github_app",
        "issue_state_reason",
        "reaction_url"
    from stg_github__issues
    
)

select * from int_github__issues

