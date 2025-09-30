{{ config(materialized="view") }}

with u as (
  select
    prod_user_id,
    prod_account_id,
    email,
    role,
    status,
    first_seen_at,
    last_seen_at,
    is_admin,
    is_owner
  from {{ ref('stg_product_users') }}
),
a as (
  select account_sk, prod_account_id
  from {{ ref('dim_account') }}
),
c as (
  select
    crm_contact_id,
    email as crm_email,
    email_domain as crm_email_domain,
    crm_account_id
  from {{ ref('stg_crm_contacts') }}
),
joined as (
  select
    u.*,
    a.account_sk,
    c.crm_contact_id
  from u
  left join a
    on u.prod_account_id = a.prod_account_id
  left join c
    on lower(u.email) = lower(c.crm_email)
       or (split_part(u.email,'@',2) = c.crm_email_domain and a.account_sk is not null)
)
select
  {{ dbt_utils.generate_surrogate_key(['coalesce(cast(account_sk as string), prod_user_id)']) }} as user_sk,
  prod_user_id,
  account_sk,
  email,
  role,
  status,
  first_seen_at,
  last_seen_at,
  is_admin,
  is_owner,
  crm_contact_id
from joined