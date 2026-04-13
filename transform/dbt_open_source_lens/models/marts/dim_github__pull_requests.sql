with int_github__pull_requests as (

    select * 
    from {{ ref('int_github__pull_requests') }}
    
),

dim_github__pull_requests as (

    select
        "pull_request_url",
        "pull_request_merged_at",
        "pull_request_is_merged"
    from int_github__pull_requests

)

select * from dim_github__pull_requests