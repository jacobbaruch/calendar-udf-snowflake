CREATE OR REPLACE TABLE <database>.<schema>.holidays_table (
    holiday_date DATE,
    holiday_name STRING,
    region STRING,       -- e.g., 'US'
    day_type STRING      -- 'full' or 'half'
);