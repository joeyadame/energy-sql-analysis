# U.S. Electricity SQL Analysis

SQL-based analysis of public U.S. electricity data using PostgreSQL.

## Overview

This project explores U.S. electricity data from the U.S. Energy Information
Administration (EIA) with a focus on analytical SQL, data auditing, and
portfolio-ready project structure.

The current work includes one retail price table and a second electricity stock
table from a separate API call, both loaded into PostgreSQL and analyzed from
scratch.

## Dataset

Source: U.S. Energy Information Administration (EIA)

Current tables used in analysis:

- `eia_state_electricity_profile_summary`
- `typed.electricity_stock`

Retail price fields:

- `state_id` - state abbreviation
- `state` - state name
- `period` - year
- `average_retail_price` - average retail electricity price

Electricity stock fields used in exploration:

- `location`
- `period`
- `sector_id`
- `sector_description`
- `fuel_type_id`
- `fuel_type_description`
- `stocks`
- `stocks_units`

## Analysis Questions

Current analysis explores questions such as:

- What states have the highest historical electricity prices?
- What is the average electricity price per state across all years?
- What is the highest electricity price ever recorded in the dataset?
- In which year did each state reach its peak electricity price?
- Are there missing values or duplicate records in either dataset?
- Are there time-based streaks of missing stock values by state and fuel type?

The queries demonstrate common SQL analysis techniques:

- aggregation (`AVG`, `MAX`)
- grouping
- subqueries
- common table expressions (CTEs)
- window functions
- join-back and ranking patterns to recover row-level context

## Project Structure

```
sql/
    00_retail_price_audit.sql
    01_retail_price_analysis.sql
    02_electricity_stock_prep.sql
    03_electricity_stock_audit.sql
    README.md

docs/
    data_sources.md
    methodology.md

schema/
    schema_notes.md

results/
    README.md

README.md
```

## Workflow

The project follows a simple analytical workflow:

1. **Data audit**
   - verify dataset structure
   - detect missing values
   - confirm grain and uniqueness

2. **Data preparation**
   - normalize analysis-critical data types
   - prepare time and key fields for querying

3. **SQL analysis**
   - compute summary statistics
   - identify price extremes
   - analyze state-level trends
   - inspect missingness patterns in the second table

## Status

Current focus:
multi-table SQL exploration and analysis of EIA electricity data.

Future work may include:

- joined analysis across both EIA tables
- stronger results summaries for portfolio review
- visualization of electricity trends and stock patterns
- a fuller ETL workflow if the project expands
