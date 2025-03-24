with report as (
  select *
  from {{ref('stg_keyword_performance-v1')}}
),
exchange_rates as (
  select *
  from {{ref('stg_openexchange_rates__openexchange_report_v1')}}
)

select 
  report.*,
  report.local_spend_amount / exchange_rates.ex_rate as _gbp_cost
from report
left join exchange_rates
on report.day = exchange_rates.day
and lower(ifnull(trim(report.local_spend_currency), '{{var('account_currency')}}')) = exchange_rates.currency_code