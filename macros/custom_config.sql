{% macro custom_config(project_id, dataset, table_expiration, data_type="date", field="day" ) %}

    {% set partition_config = {
        "field": field,
        "data_type": data_type,
        "granularity": "day"
        }
    %}
      {% set expiratin_days = {
        "two_years": "800",
        "three_years": "1200",
        "five_years": "2000",
        "ten_years": "4000"
        }
    %}
          {% set excluded_projects = ['us-data-cli-deathwishcoffee']
    %}

    {%if table_expiration is not none %}

    {{config(
        partition_expiration_days = expiratin_days.get(table_expiration)
    )}}

    {%endif%}

    {%if var('first_run') == default_variable("first_run_value2") and
     var('dataset_id') == "RAW_main" and var('project_id') not in excluded_projects %}

    {{
    config(
      pre_hook="{{delete_table()}}",
      database= var('project_id'),
      schema=dataset,
      unique_key='day',
      partition_by=partition_config,
      materialized='table'
    )
    }}

    {% else %}

    {{
        config(
            database= var('project_id'),
            schema=dataset,
            materialized='incremental',
            unique_key='day',
            partition_by=partition_config,
            incremental_strategy='insert_overwrite'
        )
    }}

    {%endif%}
{% endmacro %}