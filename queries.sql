/*
Project: Energy SQL Analysis (EIA Data)
Database: PostgreSQL
Table: typed_eia_prices

Goal:
Analyze historical U.S. retail energy prices
using aggregation and numeric precision handling.
*/

-- ==================================================
-- Average Retail Price by State
-- ==================================================
-- Purpose:
-- 1. Count number of years of available data per state
-- 2. Calculate historical average retail price
-- 3. Ensure proper numeric rounding in PostgreSQL

SELECT 
    statedescription, 
    COUNT(period) AS number_of_years,
    ROUND(AVG(average_retail_price)::NUMERIC, 2) AS avg_retail_price
FROM typed_eia_prices
GROUP BY statedescription
ORDER BY number_of_years, avg_retail_price;
