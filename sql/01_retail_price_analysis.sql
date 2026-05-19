/*
Retail Price Analysis
EIA State Electricity Profiles
PostgreSQL

Goal:
Explore historical electricity retail prices by state.
*/


-- ==================================================
-- Average electricity price by state
-- ==================================================

SELECT
    state_id,
    state,
    COUNT(*) AS number_of_years,
    ROUND(AVG(average_retail_price), 2) AS avg_price
FROM eia_state_electricity_profile_summary
GROUP BY state_id, state
ORDER BY avg_price DESC;


-- ==================================================
-- Highest electricity price ever recorded
-- ==================================================

SELECT
    state_id,
    state,
    period,
    average_retail_price
FROM eia_state_electricity_profile_summary
WHERE average_retail_price = (
    SELECT MAX(average_retail_price)
    FROM eia_state_electricity_profile_summary
);


-- ==================================================
-- Highest price per state and year of occurrence
-- Returns multiple rows when a state ties its peak price across years.
-- ==================================================

WITH ranked_state_prices AS (
    SELECT
        state_id,
        state,
        period,
        average_retail_price,
        DENSE_RANK() OVER (
            PARTITION BY state_id
            ORDER BY average_retail_price DESC
        ) AS price_rank
    FROM eia_state_electricity_profile_summary
)

SELECT
    state_id,
    state,
    average_retail_price AS highest_recorded_price,
    period
FROM ranked_state_prices
WHERE price_rank = 1
ORDER BY highest_recorded_price DESC, state_id, period;
