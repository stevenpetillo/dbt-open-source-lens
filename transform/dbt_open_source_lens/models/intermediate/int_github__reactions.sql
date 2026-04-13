with stg_github__issues as (

    select * 
    from {{ ref('stg_github__issues') }}
    where "reactions" is not null

),

int_github__reactions as (

    select distinct
        cast(reactions->>'+1' as SMALLINT) as "reaction_+1",
        cast(reactions->>'-1' as SMALLINT) as "reaction_-1",
        cast(reactions->>'url' as VARCHAR(69)) as "reaction_url",
        cast(reactions->>'eyes' as SMALLINT) as "reaction_eyes_count",
        cast(reactions->>'heart' as SMALLINT) as "reaction_heart_count",
        cast(reactions->>'laugh' as SMALLINT) as "reaction_laugh_count",
        cast(reactions->>'hooray' as SMALLINT) as "reaction_hooray_count",
        cast(reactions->>'rocket' as SMALLINT) as "reaction_rocket_count",
        cast(reactions->>'confused' as SMALLINT) as "reaction_confused_count",
        cast(reactions->>'total_count' as SMALLINT) as "reaction_total_count"
    from stg_github__issues

)

select * from int_github__reactions


