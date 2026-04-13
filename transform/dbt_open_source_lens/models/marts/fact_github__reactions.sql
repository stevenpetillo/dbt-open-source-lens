with int_github__reactions as (

    select * 
    from {{ ref('int_github__reactions') }}

),

fact_github__reactions as (

    select
        "reaction_url",
        "reaction_eyes_count",
        "reaction_heart_count",
        "reaction_laugh_count",
        "reaction_hooray_count",
        "reaction_rocket_count",
        "reaction_confused_count",
        "reaction_total_count",
        "reaction_+1",
        "reaction_-1"
    from int_github__reactions

)

select * from fact_github__reactions


