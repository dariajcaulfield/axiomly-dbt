{{
  config(
    materialized='incremental',
    incremental_strategy='microbatch',
    unique_key='pk_event_id',
    on_schema_change='sync_all_columns',
    event_time='event_ts',
    begin='2024-01-01',
    batch_size='day'
  )
}}

with e as (
  select
    pk_event_id,
    prod_user_id,
    prod_account_id,
    event_type,
    event_properties,
    event_ts,
    to_date(event_ts) as event_date
  from {{ ref('stg_product_events') }}
),
du as (
  select user_sk, prod_user_id, account_sk
  from {{ ref('dim_user') }}
)
select
  e.pk_event_id,
  du.user_sk,
  du.account_sk,
  e.prod_user_id,
  e.prod_account_id,
  e.event_type,
  e.event_properties,
  e.event_ts,
  e.event_date
from e
left join du
  on e.prod_user_id = du.prod_user_id
