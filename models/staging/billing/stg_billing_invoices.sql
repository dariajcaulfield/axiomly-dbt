{{ config(materialized="view") }}

select
  pk_invoice_id      as invoice_id,
  fk_subscription_id as subscription_id,
  fk_prod_account_id as prod_account_id,
  invoice_number,
  upper(currency)    as currency,
  subtotal,
  tax,
  total,
  amount_due,
  amount_paid,
  lower(invoice_status) as invoice_status,
  invoice_date,
  due_date,
  finalized_at,
  paid_at,
  voided_at
from {{ source('axiomly_raw','billing_invoices') }}