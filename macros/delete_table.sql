{% macro delete_table(destination) %}

{%- set target_relation = adapter.get_relation(
      database=var('project_id') ,
      schema="PUB_base",
      identifier=var('table_id')) -%}
{%- set table_exists=target_relation is not none -%}
{%- if table_exists -%}
{% set sql %}
DROP TABLE IF EXISTS `{{ var('project_id') }}.PUB_base.{{var('table_id')}}`
{% endset %}
{% do run_query(sql) %}
{%endif%}

{% endmacro %}