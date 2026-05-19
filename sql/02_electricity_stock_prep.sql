/*
Electricity Stock Preparation
EIA electricity stock table
PostgreSQL

Goal:
Normalize loaded column types before exploration and analysis.
*/

ALTER TABLE 
    typed.electricity_stock
ALTER COLUMN 
    period TYPE TIMESTAMP
USING 
    CONCAT(period, '-01')::DATE::TIMESTAMP;
ALTER TABLE 
    typed.electricity_stock
ALTER COLUMN 
    sector_id TYPE INTEGER
USING 
    sector_id::INTEGER;
