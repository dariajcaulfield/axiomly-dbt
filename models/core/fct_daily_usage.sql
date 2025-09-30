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

with u as (
  select
    pk_usage_id,
    prod_account_id,
    usage_metric,
    usage_qty,
    usage_ts,
    to_date(usage_ts) as usage_date
  from {{ ref('stg_product_usage_meter') }}
),
a as (
  select account_sk, prod_account_id
  from {{ ref('dim_account') }}
)
select
  u.pk_usage_id,
  a.account_sk,
  u.prod_account_id,
  u.usage_metric,
  u.usage_qty,
  u.usage_ts,
  u.usage_date
from u
left join a
  on u.prod_account_id = a.prod_account_id
