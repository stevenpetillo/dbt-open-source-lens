with stg_github__issues as (

    select * 
    from {{ ref('stg_github__issues') }}
    where "milestone" is not null

),

int_github__milestones as (

    select distinct
        cast(milestone->>'id' as INT) as "milestone_id",
        cast(milestone->>'url' as VARCHAR(60)) as "milestone_url",
        cast(milestone->>'state' as VARCHAR(4)) as "milestone_state",
        cast(milestone->>'title' as VARCHAR(5)) as "milestone_title",
        cast(milestone->>'due_on' as TEXT) as "milestone_due_on",
        cast(milestone->>'number' as SMALLINT) as "milestone_number",
        cast(milestone->>'creator' as JSONB) as "milestone_creator",
        cast(milestone->>'node_id' as VARCHAR(19)) as "milestone_node_id",
        cast(milestone->>'html_url' as VARCHAR(49)) as "milestone_html_url",
        cast(milestone->>'closed_at' as TEXT) as "milestone_closed_at",
        cast(milestone->>'created_at' as TIMESTAMP) as "milestone_created_at",
        cast(milestone->>'labels_url' as VARCHAR(67)) as "milestone_labels_url",
        cast(milestone->>'updated_at' as TIMESTAMP) as "milestone_updated_at",
        cast(milestone->>'description' as TEXT) as "milestone_description",
        cast(milestone->>'open_issues' as SMALLINT) as "milestone_open_issues_count",
        cast(milestone->>'closed_issues' as SMALLINT) as "milestone_closed_issues_count"
    from stg_github__issues

)

select * from int_github__milestones


