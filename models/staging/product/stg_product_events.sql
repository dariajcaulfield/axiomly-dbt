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

with base as (
  select
    pk_event_id,
    fk_prod_user_id  as prod_user_id,
    fk_prod_account_id as prod_account_id,
    lower(event_type) as event_type,
    nullif(event_properties,'') as event_properties_str,
    event_ts  
  from {{ source('axiomly_raw','product_events') }}
),
parsed as (
  select
    pk_event_id,
    prod_user_id,
    prod_account_id,
    event_type,
    try_parse_json(event_properties_str) as event_properties,
    event_ts,
    to_date(event_ts) as event_date
  from base
)
select * from parsed
