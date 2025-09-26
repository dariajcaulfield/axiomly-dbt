{{ config(materialized="view") }}

select
  pk_prod_account_id as prod_account_id,
  nullif(fk_crm_account_id, '') as crm_account_id,
  plan_tier,
  plan_billing_interval,
  seats_purchased,
  lower(status) as status,
  created_at,
  updated_at
from {{ source('axiomly_raw','product_accounts') }}
