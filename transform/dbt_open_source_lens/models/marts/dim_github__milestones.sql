with int_github__milestones as (

    select * 
    from {{ ref('int_github__milestones') }}

),

dim_github__milestones as (

    select
        "milestone_id",
        "milestone_title",
        "milestone_description",
        "milestone_due_on",
        "milestone_number",
        "milestone_state",
        "milestone_creator",
        "milestone_created_at",
        "milestone_updated_at",
        "milestone_closed_at",
        "milestone_open_issues_count",
        "milestone_closed_issues_count"
    from int_github__milestones

)

select * from dim_github__milestones


