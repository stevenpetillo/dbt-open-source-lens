with stg_github__issues as (

    select * 
    from {{ ref('stg_github__issues') }}
    where "pull_request" is not null
    
),

int_github__pull_requests as (

    select distinct
        cast(pull_request->>'url' as VARCHAR(58)) as "pull_request_url",
        cast(pull_request->>'diff_url' as VARCHAR(52)) as "pull_request_diff_url",
        cast(pull_request->>'html_url' as VARCHAR(47)) as "pull_request_html_url",
        cast(pull_request->>'merged_at' as TIMESTAMP) as "pull_request_merged_at",
        cast(pull_request->>'patch_url' as VARCHAR(53)) as "pull_request_patch_url",
        pull_request->>'merged_at' is not null as "pull_request_is_merged"
    from stg_github__issues

)

select * from int_github__pull_requests


