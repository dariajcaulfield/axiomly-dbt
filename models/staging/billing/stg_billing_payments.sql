{{ config(materialized="view") }}

select
  pk_payment_id as payment_id,
  fk_invoice_id as invoice_id,
  fk_prod_account_id as prod_account_id,
  upper(currency) as currency,
  amount,
  lower(status) as status,
  lower(payment_method) as payment_method,
  created_at
from {{ source('axiomly_raw','billing_payments') }}