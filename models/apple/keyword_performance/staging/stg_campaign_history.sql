with campaign_history as (
  select * from
    {{source('apple', 'campaign_history')}}
)

select
    SAFE_CAST(id AS INT64) campaign_id,
    SAFE_CAST(name AS STRING) campaign_name,
    SAFE_CAST(daily_budget_amount AS FLOAT64) daily_budget_amount,
    SAFE_CAST(daily_budget_currency AS STRING) daily_budget_currency,
    
    -- Metadata
    IF(LENGTH(_TABLE_SUFFIX) > 0,
       CONCAT("{{ var('table_id') }}-", _TABLE_SUFFIX), "{{ var('table_id') }}") AS raw_origin,
    {{add_fields("id")}}
from campaign_history