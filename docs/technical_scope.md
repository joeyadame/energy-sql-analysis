# Technical Scope

This document defines what the repository currently demonstrates and what is
still future-state work.

## What The Repository Demonstrates Today

### SQL analysis

- multi-table SQL exploration using EIA electricity data
- table auditing for grain, nulls, duplicates, and time coverage
- analysis patterns using aggregation, subqueries, CTEs, and window functions
- repository organization for easier review and discussion

### Lightweight extraction / ETL practice

- Python-based API extraction with `requests`
- conversion of API response data into `pandas` DataFrames
- explicit query parameters for state, sector, frequency, and output length
- basic response validation before downstream use
- optional CSV export as a handoff step before database loading

## What The Repository Does Not Claim Yet

- a production ETL orchestration framework
- automated database loading or scheduling
- data tests with a dedicated framework such as `dbt` or `pytest`
- infrastructure, deployment, or production monitoring

## Interview-Safe Framing

If you discuss this project in interviews, the safest and most accurate framing
is:

- You built a public SQL analysis project around EIA data.
- You practiced lightweight extraction and repeatable API pulls in Python.
- You organized the repo so the extraction and analysis workflow is easy to
  follow.
- You are still building toward a fuller ETL workflow and joined analysis.
