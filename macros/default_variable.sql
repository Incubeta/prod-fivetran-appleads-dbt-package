{% macro default_variable(val) %}

  {% set default_val = {
"first_run_value1": "0",
"first_run_value2": "1",
"first_run_date" :"'2000-01-01'"  } %}

{{return(default_val[val])}}


{% endmacro %}