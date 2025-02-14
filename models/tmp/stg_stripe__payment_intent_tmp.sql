select * from (
    
{{
    fivetran_utils.union_data(
        table_identifier='payment_intent', 
        database_variable='stripe_database', 
        schema_variable='stripe_schema', 
        default_database=target.database,
        default_schema='stripe',
        default_variable='payment_intent',
        union_schema_variable='stripe_union_schemas',
        union_database_variable='stripe_union_databases'
    )
}}

) as fields

{{ livemode_predicate() }}
