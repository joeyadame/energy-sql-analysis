# Data Sources

## Current Source

- Source: U.S. Energy Information Administration (EIA)
- Delivery method: API responses loaded into PostgreSQL
- Extraction tooling in repo: Python scripts using `requests` and `pandas`

## Current Analytical Tables

### `eia_state_electricity_profile_summary`

- Focus: state-level historical retail electricity prices
- Current grain: one row per state and year in the loaded dataset
- Key fields used:
  - `state_id`
  - `state`
  - `period`
  - `average_retail_price`

### `typed.electricity_stock`

- Focus: electricity stock data from a separate EIA API call
- Current work in repo:
  - type normalization
  - schema validation
  - null checks
  - continuity checks for missing stock values over time
- Key fields used:
  - `location`
  - `period`
  - `sector_id`
  - `sector_description`
  - `fuel_type_id`
  - `fuel_type_description`
  - `stocks`
  - `stocks_units`

## Extraction Workflow Notes

- Retail sales data can be pulled through `python/extract_retail_sales.py`
- The script uses explicit API parameters for monthly frequency, all-sector
  records, and a multi-state pull
- Extracted responses can be previewed in the terminal or written to CSV before
  database loading

## Scope Note

This repository is intentionally focused on analytical SQL and documentation.
It does not yet include a full ETL pipeline. The goal is to make the analysis
easy to review, reproduce, and discuss in a portfolio setting.
