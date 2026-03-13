/*
Energy Price Analysis
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
    COUNT(period) AS number_of_years,
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
-- ==================================================

WITH state_highest_price AS (
    SELECT
        state_id,
        state,
        MAX(average_retail_price) AS highest_recorded_price
    FROM eia_state_electricity_profile_summary
    GROUP BY state_id, state
)

SELECT
    shp.state_id,
    shp.state,
    shp.highest_recorded_price,
    eia.period
FROM state_highest_price shp
JOIN eia_state_electricity_profile_summary eia
  ON shp.state_id = eia.state_id
 AND shp.state = eia.state
 AND shp.highest_recorded_price = eia.average_retail_price
ORDER BY shp.highest_recorded_price DESC;
