{{ custom_config('project_id',"PUB_base") }}

{{
  config(
    alias= 'appleads-adgroup_performance'
  )
}}

with report as (
  select *
  from {{ref('int_adgroup_performance')}}
)

select
  {{dbt_utils.generate_surrogate_key(["day", "adgroup_id", "campaign_id"])}} as unique_id,
  report.*
from report
