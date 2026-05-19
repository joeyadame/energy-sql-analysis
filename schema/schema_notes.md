# Schema Notes

## `eia_state_electricity_profile_summary`

- Analytical purpose: retail price trend and state-level summary analysis
- Expected grain: one row per state and year
- Fields referenced in current SQL:
  - `state_id`
  - `state`
  - `period`
  - `average_retail_price`

## `typed.electricity_stock`

- Analytical purpose: exploratory audit of electricity stock data from a
  separate EIA source
- Fields referenced in current SQL:
  - `location`
  - `state_description`
  - `period`
  - `sector_id`
  - `sector_description`
  - `fuel_type_id`
  - `fuel_type_description`
  - `stocks`
  - `stocks_units`

## Assumptions

- `period` in the stock table is normalized to a timestamp-compatible value
  before time-based analysis.
- `sector_id` in the stock table is normalized to an integer for cleaner
  downstream grouping and joins.
- Additional schema DDL and ETL logic can be added later if this repository is
  expanded into a fuller data engineering project.
