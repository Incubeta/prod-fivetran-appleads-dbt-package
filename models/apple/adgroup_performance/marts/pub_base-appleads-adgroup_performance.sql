{{ custom_config('project_id',"PUB_base") }}

{{
  config(
    alias= 'appleads-adgroup_performance'
  )
}}

{% set region = bq_timezone('target_region') %}
{% set dates = var('days_back').split(',') %}

with report as (
  select *
  from {{ref('int_adgroup_performance')}}
)

select
  {{dbt_utils.generate_surrogate_key(["day", "adgroup_id", "campaign_id"])}} as unique_id,
  report.*
from report
where
{% if var('first_run') == default_variable("first_run_value1") %}
  day IN {{ days_back(dates,region) }}
{% elif var('first_run') == default_variable("first_run_value2") %}
  day > SAFE_cast({{ default_variable("first_run_date") }} as date)
{% endif %}