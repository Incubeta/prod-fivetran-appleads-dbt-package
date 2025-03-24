with targeting_dimensions_history as (
  select * from
    {{source('apple', 'targeting_dimensions_history')}}
)

select
    SAFE_CAST(ad_group_id AS INT64) adgroup_id,
    SAFE_CAST(targetingdimensions AS STRING) targeting_dimensions,
    
    -- Metadata
    IF(LENGTH(_TABLE_SUFFIX) > 0,
       CONCAT("{{ var('table_id') }}", _TABLE_SUFFIX), "{{ var('table_id') }}") AS raw_origin,
    {{add_fields("adgroup_id")}}
from targeting_dimensions_history