{{ config(enabled=var('stripe__using_credit_notes', False)) }}

with base as (

    select * 
    from {{ ref('stg_stripe__credit_note_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__credit_note_tmp')),
                staging_columns=get_credit_note_columns()
            )
        }}

        {{ fivetran_utils.source_relation(
            union_schema_variable='stripe_union_schemas', 
            union_database_variable='stripe_union_databases') 
        }}

    from base
),

final as (
    
    select 
        id as credit_note_id,
        amount as credit_note_amount,
        cast(created as {{ dbt.type_timestamp() }}) as created_at,
        currency as credit_note_currency,
        discount_amount as credit_note_discount_amount,
        subtotal as credit_note_subtotal,
        total as credit_note_total,
        memo,
        metadata,
        number as credit_note_number,
        pdf,
        reason as credit_note_reason,
        status as credit_note_status,
        type as credit_note_type,
        cast(voided_at as {{ dbt.type_timestamp() }}) as voided_at,
        customer_balance_transaction,
        invoice_id,
        refund_id,
        source_relation
    from fields
)

select * 
from final
