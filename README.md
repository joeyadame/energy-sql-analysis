# Energy SQL Analysis

SQL analysis of U.S. electricity retail price data using PostgreSQL.

## Overview

This project explores historical U.S. electricity retail price data at the
state level using SQL.

The dataset comes from the U.S. Energy Information Administration (EIA)
State Electricity Profiles API and is stored in a PostgreSQL database.

The goal of this repository is to practice real-world SQL analysis using
public energy data.

## Dataset

Source: U.S. Energy Information Administration (EIA)

Primary table used in analysis:

eia_state_electricity_profile_summary

Key fields:

- `state_id` — state abbreviation
- `state` — state name
- `period` — year
- `average_retail_price` — average retail electricity price

Each row represents a single state's average electricity price for a
given year.

## Analysis Questions

Current analysis explores questions such as:

- What states have the highest historical electricity prices?
- What is the average electricity price per state across all years?
- What is the highest electricity price ever recorded in the dataset?
- In which year did each state reach its peak electricity price?

The queries demonstrate common SQL analysis techniques:

- aggregation (`AVG`, `MAX`)
- grouping
- subqueries
- common table expressions (CTEs)
- join-back patterns to recover row-level context

## Project Structure

```
sql/
    AUDIT.sql
    energy_price_analysis.sql

README.md
```

## Workflow

The project follows a simple analytical workflow:

1. **Data audit**
   - verify dataset structure
   - detect missing values
   - confirm grain and uniqueness

2. **SQL analysis**
   - compute summary statistics
   - identify price extremes
   - analyze state-level trends

## Status

Current focus:
SQL exploration and analysis of the dataset.

Future work may include:

- automated ETL pipeline for loading EIA data
- additional time-series analysis
- visualization of electricity price trends
