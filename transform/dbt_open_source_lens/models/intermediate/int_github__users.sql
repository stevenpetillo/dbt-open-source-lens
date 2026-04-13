with stg_github__issues as (

    select * 
    from {{ ref('stg_github__issues') }}
    where "user" is not null

),

int_github__users as (

    select distinct
        cast("user"->>'id' as INT) as "user_id",
        cast("user"->>'url' as VARCHAR(52)) as "user_url",
        cast("user"->>'type' as VARCHAR(4)) as "user_type",
        cast("user"->>'login' as VARCHAR(23)) as "user_login",
        cast("user"->>'node_id' as VARCHAR(20)) as "user_node_id",
        cast("user"->>'html_url' as VARCHAR(42)) as "user_html_url",
        cast("user"->>'gists_url' as VARCHAR(68)) as "user_gists_url",
        cast("user"->>'repos_url' as VARCHAR(58)) as "user_repos_url",
        cast("user"->>'avatar_url' as VARCHAR(53)) as "user_avatar_url",
        cast("user"->>'events_url' as VARCHAR(69)) as "user_events_url",
        cast("user"->>'site_admin' as BOOLEAN) as "user_is_site_admin",
        cast("user"->>'gravatar_id' as TEXT) as "user_gravatar_id",
        cast("user"->>'starred_url' as VARCHAR(75)) as "user_starred_url",
        cast("user"->>'followers_url' as VARCHAR(62)) as "user_followers_url",
        cast("user"->>'following_url' as VARCHAR(75)) as "user_following_url",
        cast("user"->>'user_view_type' as VARCHAR(6)) as "user_view_type",
        cast("user"->>'organizations_url' as VARCHAR(57)) as "user_organizations_url",
        cast("user"->>'subscriptions_url' as VARCHAR(66)) as "user_subscriptions_url",
        cast("user"->>'received_events_url' as VARCHAR(68)) as "user_received_events_url"
    from stg_github__issues

)

select * from int_github__users