{{ config(materialized="view") }}

select
  product_sku,
  plan_tier,
  billing_interval,
  description,
  try_parse_json(feature_flags) as feature_flags,
  list_price_monthly_usd,
  list_price_annual_usd,
  overage_metric,
  overage_rate_usd_per_unit,
  included_units_per_month
from {{ source('axiomly_raw','admin_plan_catalog') }}
 