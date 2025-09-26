{{ config(materialized="view") }}

select
  pk_subscription_id as subscription_id,
  fk_prod_account_id as prod_account_id,
  product_sku,
  plan_tier,
  billing_interval,
  current_period_start,
  current_period_end,
  lower(status) as status,
  cancel_at,
  canceled_at,
  created_at,
  updated_at
from {{ source('axiomly_raw','billing_subscriptions') }}