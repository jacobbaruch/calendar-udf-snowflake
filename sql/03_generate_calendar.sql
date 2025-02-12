CREATE OR REPLACE FUNCTION <database>.<schema>.generate_calendar(from_ts timestamp, to_ts timestamp, time_type STRING)
RETURNS TABLE (
    timestamp TIMESTAMP,
    date DATE,
    year INT,
    quarter INT,
    month INT,
    day INT,
    week INT,
    day_of_week INT,
    day_name STRING,
    is_weekend BOOLEAN,
    is_business_day BOOLEAN,
    fiscal_year INT,
    fiscal_quarter INT,
    is_holiday BOOLEAN,
    holiday_name STRING,
    holiday_day_type STRING
)
LANGUAGE SQL
AS
$$
with date_series AS (
  SELECT
    CASE
      WHEN lower(time_type) = 'minute'  THEN DATEADD(MINUTE, seq4(), from_ts)
      WHEN lower(time_type) = 'hour'    THEN DATEADD(HOUR,   seq4(), from_ts)
      WHEN lower(time_type) = 'day'     THEN DATEADD(DAY,    seq4(), from_ts)
      WHEN lower(time_type) = 'week'    THEN DATEADD(WEEK,   seq4(), from_ts)
      WHEN lower(time_type) = 'month'   THEN DATEADD(MONTH,  seq4(), from_ts)
      WHEN lower(time_type) = 'quarter' THEN DATEADD(QUARTER,seq4(), from_ts)
      WHEN lower(time_type) = 'year'    THEN DATEADD(YEAR,   seq4(), from_ts)
    END AS timestamp
  FROM TABLE(GENERATOR(ROWCOUNT => 1000000))
      WHERE timestamp <= to_ts
)
SELECT
    ds.timestamp,
    ds.timestamp::date as date,
    year(date) AS year,
    quarter(date) AS quarter,
    month(date) AS month,
    day(date) AS day,
    week(date) AS week,
    dayofweek(date) day_of_week,
    dayname(date) AS day_name,
    iff(day_of_week IN (1,7) and lower(time_type) IN ('minute', 'hour', 'day') ,true,false ) as is_weekend,
    iff(day_of_week BETWEEN 2 AND 6 and lower(time_type) IN ('minute', 'hour', 'day') ,true,false ) as is_business_day,
    -- Fiscal Year (Assumes Fiscal Year starts in October)
    iff(month >= 10,year + 1,year) as fiscal_year,
    -- Fiscal Quarter Calculation (Based on October start)
    CASE
         WHEN month BETWEEN 10 AND 12 THEN 1
         WHEN month BETWEEN 1  AND 3  THEN 2
         WHEN month BETWEEN 4  AND 6  THEN 3
         ELSE 4
    END AS fiscal_quarter,
    -- Holiday lookup (only applies when time_type is 'minute', 'hour', or 'day')
    iff(lower(time_type) IN ('minute', 'hour', 'day'),h.holiday_name IS NOT NULL,null) as is_holiday,
    iff(lower(time_type) IN ('minute', 'hour', 'day') ,h.holiday_name,null ) as holiday_name,
    iff(lower(time_type) IN ('minute', 'hour', 'day'),h.day_type,null) as holiday_day_type
FROM date_series ds
LEFT JOIN holidays_table h
    ON ds.timestamp::date = h.holiday_date
    AND h.region = 'US'

$$;