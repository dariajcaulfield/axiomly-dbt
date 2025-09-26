{{ config(materialized="view") }}

select
  pk_invoice_line_id as invoice_line_id,
  fk_invoice_id      as invoice_id,
  lower(line_type)   as line_type,
  product_sku,
  quantity,
  unit_amount,
  amount,
  description
from {{ source('axiomly_raw','billing_invoice_lines') }}
