{{ config(materialized="view") }}

with base as (
  select
    pk_contact_id as crm_contact_id,
    fk_account_id as crm_account_id,
    lower(email) as email,
    first_name,
    last_name,
    job_title,
    phone,
    marketing_opt_in,
    created_at,
    updated_at
  from {{ source('axiomly_raw','crm_contacts') }}
)

select
  *,
  split_part(email, '@', 2) as email_domain
from base