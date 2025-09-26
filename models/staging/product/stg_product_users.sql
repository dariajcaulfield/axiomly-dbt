{{ config(materialized="view") }}

with base as (
  select
    pk_prod_user_id as prod_user_id,
    fk_prod_account_id as prod_account_id,
    lower(email) as email,
    lower(role) as role,
    lower(status) as status,
    first_seen_at,
    last_seen_at,
    created_at
  from {{ source('axiomly_raw','product_users') }}
)
select
  *,
  (role = 'owner') as is_owner,
  (role in ('owner','admin')) as is_admin
from base
