with source as (

    select * from {{ source('github', 'issues') }}

),

transformed as (

    select
        cast("url" as VARCHAR(59)) as "issue_url",
        cast("repository_url" as VARCHAR(46)) as "repository_url",
        cast("labels_url" as VARCHAR(73)) as "labels_url",
        cast("comments_url" as VARCHAR(68)) as "comments_url",
        cast("events_url" as VARCHAR(66)) as "events_url",
        cast("html_url" as VARCHAR(49)) as "html_url",
        cast("id" as BIGINT) as "issue_id",
        cast("node_id" as VARCHAR(19)) as "issue_node_id",
        cast("number" as INT) as "issue_number",
        cast("title" as VARCHAR(184)) as "issue_title",
        cast("user" as JSONB) as "user",
        cast("labels" as JSONB) as "labels",
        cast("state" as VARCHAR(6)) as "issue_state",
        cast("locked" as BOOLEAN) as "is_locked",
        cast("assignees" as JSONB) as "assignees",
        cast("milestone" as JSONB) as "milestone",
        cast("comments" as SMALLINT) as "comments_count",
        cast("created_at" as TIMESTAMP) as "created_at",
        cast("updated_at" as TIMESTAMP) as "updated_at",
        cast("closed_at" as TIMESTAMP) as "closed_at",
        cast("assignee" as JSONB) as "assignee",
        cast("author_association" as VARCHAR(12)) as "author_association",
        cast("type" as JSONB) as "type",
        cast("active_lock_reason" as TEXT) as "active_lock_reason",
        cast("draft" as BOOLEAN) as "is_draft",
        cast("pull_request" as JSONB) as "pull_request",
        cast("body" as VARCHAR(59738)) as "issue_body",
        cast("closed_by" as JSONB) as "closed_by",
        cast("reactions" as JSONB) as "reactions",
        cast("timeline_url" as VARCHAR(68)) as "timeline_url",
        cast("performed_via_github_app" as TEXT) as "performed_via_github_app",
        cast("state_reason" as VARCHAR(11)) as "issue_state_reason",
        cast("url" || '/reactions' as VARCHAR(70)) as "reaction_url", --foreign key to reactions table
        ingested_at
    from source
    
)

select * from transformed
    