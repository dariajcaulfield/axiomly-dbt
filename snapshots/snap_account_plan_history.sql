{% snapshot snap_account_plan_history %}

{{
  config(
    target_schema = 'analytics_snap',         
    unique_key   = 'subscription_id',
    strategy     = 'timestamp',
    updated_at   = 'updated_at'
  )
}}

select
  subscription_id,
  prod_account_id,
  product_sku,
  plan_tier,
  billing_interval,
  status,
  current_period_start,
  current_period_end,
  cancel_at,
  canceled_at,
  created_at,
  updated_at
from {{ ref('stg_billing_subscriptions') }}

{% endsnapshot %}
