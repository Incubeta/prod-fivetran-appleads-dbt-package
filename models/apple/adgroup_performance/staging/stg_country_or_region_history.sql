with country_or_region_history as (
  select * from
    {{source('apple', 'country_or_region_history')}}
)

select
    SAFE_CAST(ad_group_id AS INT64) adgroup_id,
    SAFE_CAST(country_or_region AS STRING) countries_or_regions,
    
    -- Metadata
    IF(LENGTH(_TABLE_SUFFIX) > 0,
       CONCAT("{{ var('table_id') }}", _TABLE_SUFFIX), "{{ var('table_id') }}") AS raw_origin,
    {{add_fields("adgroup_id")}}
from country_or_region_history