with keyword_history as (
  select * from
    {{source('apple', 'keyword_history')}}
)

select
    SAFE_CAST(id AS INT64) keyword_id,
    SAFE_CAST(ad_group_id AS INT64) adgroup_id,
    SAFE_CAST(status AS STRING) keyword_status,
    SAFE_CAST(deleted AS STRING) deleted,
    SAFE_CAST(matchtype AS STRING) match_type,
    SAFE_CAST(modificationtime AS STRING) modification_time,
    
    -- Metadata
    IF(LENGTH(_TABLE_SUFFIX) > 0,
       CONCAT("{{ var('table_id') }}-", _TABLE_SUFFIX), "{{ var('table_id') }}") AS raw_origin,
    {{add_fields("id")}}
from keyword_history