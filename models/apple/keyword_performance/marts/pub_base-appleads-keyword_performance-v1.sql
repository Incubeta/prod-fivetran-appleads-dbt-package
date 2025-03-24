{{ custom_config('project_id',"PUB_base") }}

{{
  config(
    alias= 'appleads-keyword_performance-v1'
  )
}}

{% set region = bq_timezone('target_region') %}
{% set dates = var('days_back').split(',') %}

with report as (
  select *
  from {{ref('int_keyword_performance-v1')}}
)

select
  {{dbt_utils.generate_surrogate_key(["day", "keyword_id", "adgroup_id", "campaign_id"])}} as unique_id,
  report.*
from report
where
{% if var('first_run') == default_variable("first_run_value1") %}
  day IN {{ days_back(dates,region) }}
{% elif var('first_run') == default_variable("first_run_value2") %}
  day > SAFE_cast({{ default_variable("first_run_date") }} as date)
{% endif %}