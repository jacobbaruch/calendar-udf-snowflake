-- Example 1: Daily Calendar for the Full Year 2024
----------------------------------------------------
SELECT *
FROM TABLE(
    generate_calendar('2024-01-01'::timestamp, '2024-12-31'::timestamp, 'day')
)
ORDER BY date;

----------------------------------------------------

-- Example 2: Hourly Calendar for a Specific Morning Period
------------------------------------------------------------
SELECT *
FROM TABLE(
    generate_calendar('2024-01-01 07:00:00'::timestamp, '2024-01-01 11:00:00'::timestamp, 'hour')
)
ORDER BY timestamp;

----------------------------------------------------

-- Example 3: Weekly Calendar for Q1 2024
-----------------------------------------
SELECT *
FROM TABLE(
    generate_calendar('2024-01-01'::timestamp, '2024-03-31'::timestamp, 'week')
)
ORDER BY date;

----------------------------------------------------

-- Example 4: Minute-Level Calendar for a Single Day
-----------------------------------------------------
SELECT *
FROM TABLE(
    generate_calendar('2024-12-25'::timestamp, '2024-12-25'::timestamp, 'minute')
)
ORDER BY timestamp;

----------------------------------------------------

-- Example 5: Monthly Calendar for a Two-Year Period
-----------------------------------------------------
SELECT *
FROM TABLE(
    generate_calendar('2024-01-01'::timestamp, '2025-12-31'::timestamp, 'month')
)
ORDER BY date;

----------------------------------------------------

-- Example 6: Quarterly Calendar for the Year 2024
--------------------------------------------------
SELECT *
FROM TABLE(
    generate_calendar('2024-01-01'::timestamp, '2024-12-31'::timestamp, 'quarter')
)
ORDER BY date;

----------------------------------------------------

-- Example 7: Yearly Calendar for a Five-Year Period
-----------------------------------------------------
SELECT *
FROM TABLE(
    generate_calendar('2020-01-01'::timestamp, '2024-12-31'::timestamp, 'year')
)
ORDER BY date;


