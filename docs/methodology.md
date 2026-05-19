# Methodology

## Workflow

1. Audit each loaded table before analysis.
2. Normalize types when the raw load is not analysis-ready.
3. Validate grain, null behavior, and time coverage.
4. Run focused analytical SQL against cleaned tables.
5. Expand toward cross-table analysis once both sources are documented and stable.

## SQL Patterns Demonstrated

- `COUNT`, `AVG`, `MAX`, and filtered counts
- grouped aggregation
- scalar subqueries
- common table expressions (CTEs)
- window functions with `ROW_NUMBER()` and `DENSE_RANK()`
- join-back and ranking patterns for row-level context

## Portfolio Framing

This project is meant to show practical SQL workflow, not just isolated query
answers. The repository separates auditing, preparation, and analysis so a
hiring manager can quickly see how the work is organized.
