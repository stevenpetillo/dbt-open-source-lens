with int_github__users as (

    select * 
    from {{ ref('int_github__users') }}

),

dim_github__users as (

    select distinct
        "user_id",
        "user_login",
        "user_type",
        "user_is_site_admin",
        "user_view_type",
        "user_html_url"
    from int_github__users

)

select * from dim_github__users