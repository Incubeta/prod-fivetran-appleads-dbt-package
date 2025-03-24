with ad_group_history as (
  select * from
    {{source('apple', 'ad_group_history')}}
)

select
    SAFE_CAST(id AS INT64) adgroup_id,
    SAFE_CAST(name AS STRING) adgroup_name,
    SAFE_CAST(campaign_id AS INT64) campaign_id,
    
    -- Metadata
    IF(LENGTH(_TABLE_SUFFIX) > 0,
       CONCAT("{{ var('table_id') }}-", _TABLE_SUFFIX), "{{ var('table_id') }}") AS raw_origin,
    {{add_fields("id")}}
from ad_group_history