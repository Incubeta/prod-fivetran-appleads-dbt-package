with search_term_report as (
  select * from
    {{source('apple', 'search_term_report')}}
)

select
    SAFE_CAST(ad_group_id AS INT64) adgroup_id,
    SAFE_CAST(ad_group_deleted AS STRING) adgroup_deleted,
    SAFE_CAST(keyword AS STRING) keyword,
    SAFE_CAST(keyword_display_status AS STRING) keyword_display_status,
    SAFE_CAST(bid_amount_amount AS FLOAT64) bid_amount_amount,
    SAFE_CAST(bid_amount_currency AS STRING) bid_amount_currency,
    SAFE_CAST(search_term_source AS STRING) search_term_source,
    SAFE_CAST(search_term_text AS STRING) search_term_text,
    
    -- Metadata
    IF(LENGTH(_TABLE_SUFFIX) > 0,
       CONCAT("{{ var('table_id') }}-", _TABLE_SUFFIX), "{{ var('table_id') }}") AS raw_origin,
    {{add_fields("adgroup_id")}}
from search_term_report