with fact_github__issues as (

    select * from {{ ref('fact_github__issues') }}

),

dim_github__issues as (

    select * from {{ ref('dim_github__issues') }}

),

dim_github__users as (

    select * from {{ ref('dim_github__users') }}

),

dim_github__pull_requests as (

    select * from {{ ref('dim_github__pull_requests') }}

),

dim_github__types as (

    select * from {{ ref('dim_github__types') }}

),

brd_github__issues_labels as (

    select * from {{ ref('brd_github__issues_labels') }}

),

dim_github__labels as (

    select * from {{ ref('dim_github__labels') }}

),

issue_labels AS (

	select 
		issue_id,
		string_agg(dl.label_name, ', ') AS label_list
	from brd_github__issues_labels bil
	left join dim_github__labels dl
		on bil.label_id = dl.label_id
	group by 1

),

rpt_github__issues AS (

    select
        fi.issue_id,
        di.issue_title,
        di.issue_state,
        du.user_login,
        di.is_draft, 
        fi.created_at,
        fi.updated_at,
        dpr.pull_request_merged_at,
        fi.closed_at,
        dpr.pull_request_is_merged,
        di.issue_body,
        di.issue_state_reason,
        di.author_association,
        fi.issue_number,
        di.issue_url,
        fi.comments_count,
        il.label_list
    from fact_github__issues fi
    left join dim_github__issues di
        on fi.issue_id = di.issue_id
    left join dim_github__users du
        on fi.user_id = du.user_id
    left join dim_github__pull_requests dpr
        on fi.pull_request_url = dpr.pull_request_url
    left join dim_github__types dt
        on fi.type_id = dt.type_id	
    left join issue_labels il
        on fi.issue_id = il.issue_id

)

select * from rpt_github__issues