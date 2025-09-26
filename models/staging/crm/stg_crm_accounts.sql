{{ config(materialized="view") }}

with base as (
  select
    pk_account_id        as crm_account_id,
    account_name,
    lower(domain)        as domain,
    industry,
    employee_count,
    country,
    lower(lifecycle_stage) as lifecycle_stage,
    owner_user_id,
    created_at,
    updated_at
  from {{ source('axiomly_raw','crm_accounts') }}
),

ranked as (
  select
    *,
    row_number() over (
      partition by coalesce(domain, account_name)
      order by updated_at desc nulls last, created_at desc nulls last, crm_account_id desc
    ) as rn
  from base
)

select
  crm_account_id,
  account_name,
  domain,
  industry,
  employee_count,
  country,
  lifecycle_stage,
  owner_user_id,
  created_at,
  updated_at
from ranked
where rn = 1
