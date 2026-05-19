/*
Data Audit: EIA State Electricity Profiles

Purpose:
Verify dataset integrity before performing analysis.
*/

-- ==================================================
-- Total number of rows
-- ==================================================

SELECT
    COUNT(*) AS row_count
FROM eia_state_electricity_profile_summary;


-- ==================================================
-- Number of unique states
-- ==================================================

SELECT
    COUNT(DISTINCT state_id) AS state_count
FROM eia_state_electricity_profile_summary;


-- ==================================================
-- Dataset year coverage
-- ==================================================

SELECT
    MIN(period) AS first_year,
    MAX(period) AS last_year
FROM eia_state_electricity_profile_summary;


-- ==================================================
-- Check for missing price values
-- ==================================================

SELECT
    COUNT(*) AS null_price_count
FROM eia_state_electricity_profile_summary
WHERE average_retail_price IS NULL;


-- ==================================================
-- Detect duplicate state/year records
-- ==================================================

SELECT
    state_id,
    period,
    COUNT(*) AS duplicate_rows
FROM eia_state_electricity_profile_summary
GROUP BY state_id, period
HAVING COUNT(*) > 1;


-- ==================================================
-- Verify number of years of data per state
-- ==================================================

SELECT
    state_id,
    COUNT(period) AS years_of_data
FROM eia_state_electricity_profile_summary
GROUP BY state_id
ORDER BY years_of_data;
