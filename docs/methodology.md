# Methodology

## Workflow

1. Audit each loaded table before analysis.
2. Extract public source data through lightweight Python API scripts when needed.
3. Normalize types when the raw load is not analysis-ready.
4. Validate grain, null behavior, and time coverage.
5. Run focused analytical SQL against cleaned tables.
6. Expand toward cross-table analysis once both sources are documented and stable.

## SQL Patterns Demonstrated

- `COUNT`, `AVG`, `MAX`, and filtered counts
- grouped aggregation
- scalar subqueries
- common table expressions (CTEs)
- window functions with `ROW_NUMBER()` and `DENSE_RANK()`
- join-back and ranking patterns for row-level context
- API extraction using `requests`
- DataFrame conversion with `pandas`

## Portfolio Framing

This project is meant to show practical SQL workflow, not just isolated query
answers. The repository separates auditing, preparation, and analysis so a
hiring manager can quickly see how the work is organized.
