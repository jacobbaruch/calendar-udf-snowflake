  
-- Example 1: Daily Calendar for the Full Year 2024
SELECT *
FROM TABLE(
    {{ source('calendar_udf', 'generate_calendar') }} ('2024-01-01'::timestamp, '2024-12-31'::timestamp, 'day')
)

----------------------------------------------------

-- Example 2: Hourly Calendar for a Specific Morning Period
------------------------------------------------------------
SELECT *
FROM TABLE(
    {{ source('calendar_udf', 'generate_calendar') }} ('2024-01-01 07:00:00'::timestamp, '2024-01-01 11:00:00'::timestamp, 'hour')
)
ORDER BY timestamp

----------------------------------------------------

-- Example 3: Weekly Calendar for Q1 2024
-----------------------------------------
SELECT *
FROM TABLE(
    {{ source('calendar_udf', 'generate_calendar') }} ('2024-01-01'::timestamp, '2024-03-31'::timestamp, 'week')
)