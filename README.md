# Apple Ads Transformation dbt Package

## What does this dbt package do?
* Materializes the Apple Ads RAW_main tables using the data coming from the Apple Search Ads API.
* Provides a structured approach with staging, intermediate, and marts layers.

## How do I use the dbt package?
### Step 1: Prerequisites
To use this dbt package, you must have the following:
- At least one Fivetran Apple connector syncing data for at least one of the predefined reports:
    - appleads_adgroup_performance_v_1
    - appleads_keyword_performance_v_1
- A BigQuery data destination.

### Step 2: Install the package
Include the following apple package version in your `packages.yml` file
```yaml
packages:
  - git: "https://github.com/Incubeta/prod-fivetran-appleads-dbt-package.git"
    revision: main
```

### Step 3: Define input tables variables
This package reads the Apple Ads data from the different tables created by the Apple Ads connector.
The names of the tables can be changed by setting the correct name in the root `dbt_project.yml` file.

The following table shows the configuration keys and the default table names:

|key|default|
|---|-------|
|appleads_adgroup_performance_v_1_identifier|appleads_adgroup_performance_v_1|
|appleads_keyword_performance_v_1_identifier|appleads_keyword_performance_v_1|

If the connector uses different table names (for example appleads_adgroup_performance_v_1_test) this can be set in the `dbt_project.yml` as follows.

```yaml
vars:
    appleads_adgroup_performance_v_1_identifier: appleads_adgroup_performance_v_1_test
```

### (Optional) Step 4: Additional configurations

#### Change output tables:
The following vars can be used to change the output table names:

|key| default                  |
|---|--------------------------|
|appleads_adgroup_performance_v1_alias| appleads-adgroup_performance-v1 |
|appleads_keyword_performance_v1_alias| appleads-keyword_performance-v1 |

#### Add custom fields:
Ensure that the variable `apple_custom_fields` is defined in the root project's `dbt_project.yml` file (this is your main repository).
```yaml
# dbt_project.yml (root project)
vars:
  apple_custom_fields: "field1,field2,field3"
```

#### Add non-existing fields:
Ensure that the variable `apple_non_existing_fields` is defined in the root project's `dbt_project.yml` file (this is your main repository).
This will add `NULL` value to the field.
```yaml
# dbt_project.yml (root project)
vars:
  apple_non_existing_fields: "field1,field2"
```

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
