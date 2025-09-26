{{
  config(
    materialized='incremental',
    incremental_strategy='microbatch',
    unique_key='pk_usage_id',
    on_schema_change='sync_all_columns',
    event_time='usage_ts',
    begin='2024-01-01',
    batch_size='day'
  )
}}

with base as (
  select
    pk_usage_id,
    fk_prod_account_id as prod_account_id,
    lower(usage_metric) as usage_metric,
    try_to_number(usage_qty) as usage_qty,
    usage_ts                
  from {{ source('axiomly_raw','product_usage_meter') }}
)
select
  pk_usage_id,
  prod_account_id,
  usage_metric,
  usage_qty,
  usage_ts,
  to_date(usage_ts) as usage_date
from base