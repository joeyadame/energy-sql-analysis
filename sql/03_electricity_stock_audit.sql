/*
Electricity Stock Audit
EIA electricity stock table
PostgreSQL

Goal:
Validate schema, completeness, and time-series null behavior before deeper
analysis.
*/

-- ==================================================
-- Data sanity check
-- ==================================================

SELECT 
    column_name,
    data_type,
    is_nullable,
    character_maximum_length
FROM
    information_schema.columns
WHERE
    table_schema = 'typed'
    AND table_name = 'electricity_stock';

SELECT 
    COUNT(*) AS loaded_rows,
    COUNT(DISTINCT location) AS number_of_states,
    MIN(period) AS data_start,
    MAX(period) AS data_end
FROM 
    typed.electricity_stock
;

-- ==================================================
-- Missing values by descriptive field
-- ==================================================

SELECT 
    COUNT(*) FILTER (WHERE state_description IS NULL) AS state_description_nulls,
    COUNT(*) FILTER (WHERE sector_description IS NULL) AS sector_description_nulls,
    COUNT(*) FILTER (WHERE fuel_type_description IS NULL) AS fuel_type_description_nulls,
    COUNT(*) FILTER (WHERE stocks IS NULL) AS stocks_nulls,
    COUNT(*) FILTER (WHERE stocks_units IS NULL) AS stocks_units_nulls
FROM typed.electricity_stock;

-- ==================================================
-- Partial missingness checks for value/unit pairs
-- ==================================================

SELECT 
    COUNT(*) AS missing_stocks
FROM typed.electricity_stock
WHERE stocks IS NULL AND stocks_units IS NOT NULL;

SELECT 
    COUNT(*) AS missing_units
FROM typed.electricity_stock
WHERE stocks IS NOT NULL AND stocks_units IS NULL;

SELECT 
    COUNT(*) AS missing_both
FROM typed.electricity_stock
WHERE stocks IS NULL AND stocks_units IS NULL;

-- ==================================================
-- Consecutive null stock streaks by state and fuel type
-- ==================================================

WITH all_rows AS (
    SELECT 
        location,
        period,
        fuel_type_description,
        fuel_type_id,
        stocks,
        ROW_NUMBER() OVER (PARTITION BY location, fuel_type_id 
            ORDER BY period) AS rn_all
    FROM 
        typed.electricity_stock
),

null_rows AS (
    SELECT 
        location,
        period,
        fuel_type_description,
        fuel_type_id,
        rn_all,
        ROW_NUMBER() OVER (PARTITION BY location, fuel_type_id 
            ORDER BY period) AS rn_nulls
    FROM 
        all_rows
    WHERE 
        stocks IS NULL
),

null_streaks AS (
    SELECT
        location,
        period,
        fuel_type_description,
        fuel_type_id,
        rn_all - rn_nulls AS streak_id
    FROM null_rows
)

SELECT 
    streak_id,
    location,
    fuel_type_description,
    MIN(period) AS streak_begin,
    MAX(period) AS streak_end,
    AGE(MAX(period), MIN(period)) + INTERVAL '1 month' AS streak_length
FROM 
    null_streaks
GROUP BY 1,2,3
ORDER BY streak_length;
