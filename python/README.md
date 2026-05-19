# Python Extraction Guide

This directory contains lightweight extraction scripts used to pull public EIA
data for downstream SQL analysis.

Current scope:

- API-based extraction with `requests`
- response validation and basic error handling
- tabular conversion with `pandas`
- adjustable state, sector, and row-limit parameters
- optional CSV export for review or loading into PostgreSQL

Current scripts:

- `extract_retail_sales.py`

This is intentionally a small ETL practice layer rather than a production
pipeline. The goal is to show repeatable extraction logic and clear separation
between extraction and SQL analysis.
