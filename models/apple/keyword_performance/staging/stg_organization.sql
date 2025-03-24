with organization as (
  select * from
    {{source('apple', 'organization')}}
)

select
    SAFE_CAST(id AS INT64) organization_id,
    SAFE_CAST(name AS STRING) organization_name,
    
    -- Metadata
    IF(LENGTH(_TABLE_SUFFIX) > 0,
       CONCAT("{{ var('table_id') }}-", _TABLE_SUFFIX), "{{ var('table_id') }}") AS raw_origin,
    {{add_fields("id")}}
from organization