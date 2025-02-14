select * from (

{{
    fivetran_utils.union_data(
        table_identifier='customer', 
        database_variable='stripe_database', 
        schema_variable='stripe_schema', 
        default_database=target.database,
        default_schema='stripe',
        default_variable='customer',
        union_schema_variable='stripe_union_schemas',
        union_database_variable='stripe_union_databases'
    )
}}

) as fields

{{ livemode_predicate() }}
and 
not coalesce(is_deleted, false)