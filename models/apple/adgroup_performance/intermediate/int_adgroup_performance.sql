with adgroup as (
  select *
  from {{ref('stg_ad_group_history')}}
),
report as (
  select *
  from {{ref('stg_ad_group_report')}}
),
country as (
  select *
  from {{ref('stg_country_or_region_history')}}
),
targeting as (
  select *
  from {{ref('stg_targeting_dimensions_history')}}
),
campaign as (
  select *
  from {{ref('stg_campaign_history')}}
),
organization as (
  select *
  from {{ref('stg_organization')}}
),
exchange_rates as (
  select *
  from {{ref('stg_openexchange_rates__openexchange_report_v1')}}
)

select 
  adgroup.*,
  report.day,
  report.avg_cpa_amount,
  report.avg_cpa_currency,
  report.avg_cpt_amount,
  report.avg_cpt_currency,
  report.conversion_rate,
  country.countries_or_regions,
  report.impressions,
  report.installs,
  report.lat_off_installs,
  report.lat_on_installs,
  report.local_spend_amount,
  report.local_spend_currency,
  report.new_downloads,
  report.redownloads,
  report.tap_through_rate,
  report.taps,
  targeting.targeting_dimensions,
  campaign.campaign_name,
  campaign.campaign_daily_budget_amount,
  campaign.campaign_daily_budget_currency,
  organization.organization_name,
  report.local_spend_amount / exchange_rates.ex_rate as _gbp_cost
from adgroup
left join report on adgroup.adgroup_id = report.adgroup_id
left join country on adgroup.adgroup_id = country.adgroup_id
left join targeting on adgroup.adgroup_id = targeting.adgroup_id
left join campaign on adgroup.campaign_id = campaign.campaign_id
left join organization on adgroup.organization_id = organization.organization_id
left join exchange_rates
  on report.day = exchange_rates.day
  and lower(ifnull(trim(report.local_spend_currency), '{{var('account_currency')}}')) = exchange_rates.currency_code