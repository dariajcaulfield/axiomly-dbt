{{ config(materialized="view") }}

select
  pk_ticket_id as ticket_id,
  fk_prod_account_id as prod_account_id,
  fk_prod_user_id as prod_user_id,
  lower(priority) as priority,
  lower(status) as status,
  subject,
  lower(channel) as channel,
  created_at,
  first_response_at,
  resolved_at,
  closed_at
from {{ source('axiomly_raw','support_tickets') }}
