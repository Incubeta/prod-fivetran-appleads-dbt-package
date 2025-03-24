{% macro bq_timezone(target_region) %}


/* Below if conditions sets the current region in order to get that particular region's
current date based on region input variable */

{%set target = var('target_region').split('_')[-1] %}
{%if target is not defined %}
{%set target = var('target_region')%}
{%endif%}

{

{% if target == "EU" %}
{{ return("UTC") }}

{% elif target == "US" %}
{{ return("UTC") }}

{% elif target == "australia-southeast1" %}
{{ return("UTC") }}

{% endif %}
}

{% endmacro %}