{{ config(materialized="view") }}

with prod as (
  select
    prod_account_id,
    crm_account_id,
    plan_tier,
    plan_billing_interval,
    seats_purchased,
    status,
    created_at as prod_created_at,
    updated_at as prod_updated_at
  from {{ ref('stg_product_accounts') }}
),
crm as (
  select
    crm_account_id,
    account_name,
    domain,
    industry,
    country,
    lifecycle_stage,
    created_at as crm_created_at,
    updated_at as crm_updated_at
  from {{ ref('stg_crm_accounts') }}
)
select
  {{ dbt_utils.generate_surrogate_key(['coalesce(prod.prod_account_id, crm.crm_account_id)']) }} as account_sk,
  prod.prod_account_id,
  crm.crm_account_id,
  crm.account_name,
  crm.domain,
  crm.industry,
  crm.country,
  prod.plan_tier,
  prod.plan_billing_interval,
  prod.seats_purchased,
  prod.status,
  least(crm.crm_created_at, prod.prod_created_at) as first_seen_at,
  greatest(crm.crm_updated_at, prod.prod_updated_at) as latest_activity_at
from prod
full outer join crm
  on prod.crm_account_id = crm.crm_account_id
