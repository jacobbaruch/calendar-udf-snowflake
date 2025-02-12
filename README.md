
# 📅 Calendar UDF for Snowflake with Custom Holiday Management

This repository provides a robust solution for generating a calendar table in **Snowflake**, including the ability to manage a custom holiday table. Whether you're working on data modeling, reporting, or building advanced pipelines, this tool will simplify date management and reduce repetitive date logic.

---

## 🌟 Key Advantages

- **Simplifies Date Management**: Automatically generates a comprehensive calendar table with detailed columns.  
- **Custom Holiday Support**: Easily define and manage holidays relevant to your business.  
- **Snowflake and DBT Integration**: Seamlessly integrates with Snowflake and DBT for more powerful and automated workflows.  
- **Highly Customizable**: Adjust calendar logic and holiday definitions to suit specific requirements.  

---

## 🎯 Use Cases

- **Business Reporting**: Build time-based reports and dashboards with ease.  
- **Data Pipelines**: Simplify joins and calculations in your data models.  
- **Holidays Analysis**: Analyze the impact of holidays on business performance.  

---

## 🛠 How to Use

### Prerequisites
- **Snowflake account**  
- Optional: **DBT setup** if you plan to integrate the calendar into your DBT project.  

### Steps:
1. **Create the Holidays Table**  
   Run the script `sql/01_create_holidays_table.sql` to create a table for managing holidays.  

2. **Insert Holiday Data**  
   Use `sql/02_insert_holidays.sql` to populate your holidays table with relevant data.  

3. **Generate the Calendar**  
   Execute `sql/03_generate_calendar.sql` to generate a calendar table with detailed date-related columns.  

4. **DBT Source Configuration**  
   Use the `dbt/dbt_set_source.yml` file as a guide to set the calendar as a source in your DBT project.

5. **Check the Examples**  
   - For Snowflake usage, refer to `examples/snowflake_examples.sql`.  
   - For DBT usage, see `examples/dbt_examples.sql`.  

---

## 💡 How to Use the Calendar UDF

### Function Inputs
The function expects the following **inputs**:

| Input Name        | Data Type | Description                                   |
|-------------------|-----------|-----------------------------------------------|
| `from_ts`      | TIMESTAMP      | The starting timestamp for generating the calendar. |
| `to_ts`        | TIMESTAMP      | The ending timestamp for generating the calendar.   |
| `time_type`| STRING   | The granularity of the calendar. Supported values: 'minute', 'hour', 'day', 'week', 'month', 'quarter', 'year'. |

--- 

## 💡 Example Usage (Snowflake)

```sql
SELECT *
FROM TABLE(
    OUR_DATABASE.YOUR_SCHEMA.generate_calendar('2024-01-01 07:00:00'::timestamp, '2024-01-01 11:00:00'::timestamp, 'hour')
)
```

---

## 📊 Output: Calendar Table Structure

The generated calendar table includes the following columns:

| Column Name       | Data Type   | Description                                   |
|-------------------|-------------|-----------------------------------------------|
| `timestamp`       | TIMESTAMP   | The exact timestamp for the date.              |
| `date`            | DATE        | The full date (YYYY-MM-DD).                   |
| `year`            | INT         | The calendar year.                            |
| `quarter`         | INT         | The calendar quarter (1–4).                   |
| `month`           | INT         | The calendar month (1–12).                    |
| `day`             | INT         | The day of the month (1–31).                  |
| `week`            | INT         | The ISO week number of the year (1–52).       |
| `day_of_week`     | INT         | The day of the week (1 = Sunday, 7 = Saturday). |
| `day_name`        | STRING      | The name of the day (e.g., Mon, Tue).  |
| `is_weekend`      | BOOLEAN     | Indicates if the date is a weekend (TRUE/FALSE). |
| `is_business_day` | BOOLEAN     | Indicates if the date is a business day (TRUE/FALSE). |
| `fiscal_year`     | INT         | The fiscal year associated with the date.     |
| `fiscal_quarter`  | INT         | The fiscal quarter (1–4).                     |
| `is_holiday`      | BOOLEAN     | Indicates if the date is a holiday (TRUE/FALSE). |
| `holiday_name`    | STRING      | The name of the holiday (if applicable).      |
| `holiday_day_type`| STRING      | The type of holiday (e.g., half,full).|

---

## 📦 DBT Integration

Easily integrate this calendar table in your DBT project. Use the provided `dbt/dbt_set_source.yml` file as an example of how to configure it as a source. Check out `examples/dbt_examples.sql` for additional guidance.

---

## 🤝 Contributing

Contributions are welcome! If you have ideas for improvements or new features, feel free to open an issue or submit a pull request.

---

## 📜 License

This project is open-source and available under the MIT License.
