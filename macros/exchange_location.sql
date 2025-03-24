{% macro exchange_location(target_region) %}


/* Below if conditions sets the exchange region project based on the target region from CLI */

/* source raw main table is referred as source_a and
openexchange table is being referred as source_b */

{%if var('target_region') == "US" %}

  `us-data-in-incubeta-int.PUB_base.openexchange_report-v1` source_b

{% elif var('target_region') == "EU" %}

   `uk-data-in-incubeta.PUB_base.openexchange_report-v1` source_b

{% elif var('target_region') == "australia-southeast1" %}

   `au-data-in-incubeta-int.PUB_base.openexchange_report-v1` source_b

{% endif %}


{% endmacro %}