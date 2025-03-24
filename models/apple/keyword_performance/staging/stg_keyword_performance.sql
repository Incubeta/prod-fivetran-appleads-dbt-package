with keyword_report as (
  select * from
    {{ref('stg_keyword_report')}}
),
search_term_report as (
  select * from
    {{ref('stg_search_term_report')}}
),
keyword_history as (
  select * from
    {{ref('stg_keyword_history')}}
),
ad_group_history as (
  select * from
    {{ref('stg_ad_group_history')}}
),
campaign_history as (
  select * from
    {{ref('stg_campaign_history')}}
),
organization as (
  select * from
    {{ref('stg_organization')}}
),
exchange_rates as (
  select *
  from {{ref('stg_openexchange_rates__openexchange_report_v1')}}
)

select
    -- Keyword Report columns
    keyword_report.day,
    keyword_report.avg_cpa_amount,
    keyword_report.avg_cpa_currency,
    keyword_report.avg_cpt_amount,
    keyword_report.avg_cpt_currency,
    keyword_report.conversion_rate,
    keyword_report.impressions,
    keyword_report.installs,
    keyword_report.lat_off_installs,
    keyword_report.lat_on_installs,
    keyword_report.local_spend_amount,
    keyword_report.local_spend_currency,
    keyword_report.new_downloads,
    keyword_report.redownloads,
    keyword_report.tap_through_rate,
    keyword_report.taps,
    
    -- Search Term Report columns
    search_term_report.adgroup_deleted,
    search_term_report.keyword,
    search_term_report.keyword_display_status,
    search_term_report.bid_amount_amount,
    search_term_report.bid_amount_currency,
    search_term_report.search_term_source,
    search_term_report.search_term_text,
    
    -- Keyword History columns
    keyword_history.keyword_id,
    keyword_history.adgroup_id,
    keyword_history.keyword_status,
    keyword_history.deleted,
    keyword_history.match_type,
    keyword_history.modification_time,
    
    -- Ad Group History columns
    ad_group_history.adgroup_name,
    
    -- Campaign History columns
    campaign_history.campaign_id,
    campaign_history.campaign_name,
    campaign_history.daily_budget_amount,
    campaign_history.daily_budget_currency,
    
    -- Organization columns
    organization.organization_id,
    organization.organization_name,
    
    -- Calculated fields
    keyword_report.localspend_amount / exchange_rates.ex_rate as _gbp_cost,
    
    -- Metadata
    keyword_report.raw_origin,
    keyword_report.campaign_id_source,
    keyword_report.campaign_id_source_name,
    keyword_report.campaign_id_source_id,
    keyword_report.campaign_id_source_account,
    keyword_report.campaign_id_source_account_id,
    keyword_report.campaign_id_source_account_name,
    keyword_report.campaign_id_source_client,
    keyword_report.campaign_id_source_client_id,
    keyword_report.campaign_id_source_client_name
from keyword_report
left join search_term_report on keyword_report.campaign_id = search_term_report.adgroup_id
left join keyword_history on search_term_report.adgroup_id = keyword_history.adgroup_id
left join ad_group_history on keyword_history.adgroup_id = ad_group_history.adgroup_id
left join campaign_history on ad_group_history.campaign_id = campaign_history.campaign_id
left join organization on campaign_history.campaign_id = organization.organization_id
left join exchange_rates
  on keyword_report.day = exchange_rates.day
  and lower(ifnull(trim(keyword_report.local_spend_currency), '{{var('account_currency')}}')) = exchange_rates.currency_code