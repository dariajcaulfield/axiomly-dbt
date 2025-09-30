{{ config(materialized="view") }}

select
  pk_email_event_id as email_event_id,
  fk_contact_id as crm_contact_id,
  campaign_id,
  lower(event_type) as event_type,
  event_ts
from {{ source('axiomly_raw','marketing_email_events') }}