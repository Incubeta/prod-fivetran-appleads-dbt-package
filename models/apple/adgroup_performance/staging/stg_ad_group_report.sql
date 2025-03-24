with ad_group_report as (
  select * from
    {{source('apple', 'appleads_adgroup_performance_v_1')}}
)

select
    SAFE_CAST(date AS DATE) day,
    SAFE_CAST(ad_group_id AS INT64) adgroup_id,
    SAFE_CAST(campaign_id AS INT64) campaign_id,
    
    -- Performance metrics
    SAFE_CAST(avgcpa_amount AS FLOAT64) avg_cpa_amount,
    SAFE_CAST(avgcpa_currency AS STRING) avg_cpa_currency,
    SAFE_CAST(avg_cpt_amount AS FLOAT64) avg_cpt_amount,
    SAFE_CAST(avg_cpt_currency AS STRING) avg_cpt_currency,
    SAFE_CAST(conversionrate AS FLOAT64) conversion_rate,
    SAFE_CAST(impressions AS INT64) impressions,
    SAFE_CAST(total_install AS INT64) installs,
    SAFE_CAST(latoffinstalls AS INT64) lat_off_installs,
    SAFE_CAST(latoninstalls AS INT64) lat_on_installs,
    SAFE_CAST(local_spend_amount AS FLOAT64) local_spend_amount,
    SAFE_CAST(local_spend_currency AS STRING) local_spend_currency,
    SAFE_CAST(newdownloads AS INT64) new_downloads,
    SAFE_CAST(total_redownloads AS INT64) redownloads,
    SAFE_CAST(tap_through_rate AS FLOAT64) tap_through_rate,
    SAFE_CAST(taps AS INT64) taps,
    
    -- Metadata
    IF(LENGTH(_TABLE_SUFFIX) > 0,
       CONCAT("{{ var('table_id') }}", _TABLE_SUFFIX), "{{ var('table_id') }}") AS raw_origin,
    {{add_fields("campaign_id")}}
from ad_group_report