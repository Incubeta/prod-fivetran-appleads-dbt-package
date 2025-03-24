with ad_group_history as (
  select * from
    {{source('apple', 'ad_group_history')}}
)

select
    -- Ad Group History columns
    SAFE_CAST(ad_group_history.display_status AS STRING) adgroup_display_status,
    SAFE_CAST(ad_group_history.id AS INT64) adgroup_id,
    SAFE_CAST(ad_group_history.name AS STRING) adgroup_name,
    SAFE_CAST(ad_group_history.serving_state_reason AS STRING) adgroup_serving_state_reasons,
    SAFE_CAST(ad_group_history.serving_status AS STRING) adgroup_serving_status,
    SAFE_CAST(ad_group_history.status AS STRING) adgroup_status,
    SAFE_CAST(ad_group_history.automated_keyword_opt_in AS STRING) automated_keywords_opt_in,
    SAFE_CAST(ad_group_history.cpa_goal_amount AS FLOAT64) cpa_goal_amount,
    SAFE_CAST(ad_group_history.cpa_goal_currency AS STRING) cpa_goal_currency,
    SAFE_CAST(ad_group_history.default_cpc_bid_amount AS FLOAT64) default_cpc_bid_amount,
    SAFE_CAST(ad_group_history.default_cpc_bid_currency AS STRING) default_cpc_bid_currency,
    SAFE_CAST(ad_group_history.deleted AS STRING) deleted,
    SAFE_CAST(ad_group_history.end_time AS STRING) end_time,
    SAFE_CAST(ad_group_history.modification_time AS STRING) modification_time,
    SAFE_CAST(ad_group_history.organization_id AS INT64) org_id,
    SAFE_CAST(ad_group_history.start_time AS STRING) start_time,
    SAFE_CAST(ad_group_history.campaign_id AS INT64) campaign_id,
    SAFE_CAST(ad_group_history.organization_id AS INT64) organization_id,
  
    -- Metadata
    IF(LENGTH(_TABLE_SUFFIX) > 0,
       CONCAT("{{ var('table_id') }}", _TABLE_SUFFIX), "{{ var('table_id') }}") AS raw_origin,
    {{add_fields("campaign_id")}}
from ad_group_history