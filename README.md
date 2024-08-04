# data-analysis-bellabeat-sql
-- My SQL queries for my data analysis project using Fitbit Fitness Tracker Data
-- Setting variables for regular expression based analyses
DECLARE
 TIMESTAMP_REGEX STRING DEFAULT r'^\d{4}-\d{1,2}-\d{1,2}[T ]\d{1,2}:\d{1,2}:\d{1,2}(\.\d{1,6})? *(([+-]\d{1,2}(:\d{1,2})?)|Z|UTC)?$';
DECLARE
 DATE_REGEX STRING DEFAULT r'^\d{4}-(?:[1-9]|0[1-9]|1[012])-(?:[1-9]|0[1-9]|[12][0-9]|3[01])$';
DECLARE
 TIME_REGEX STRING DEFAULT r'^\d{1,2}:\d{1,2}:\d{1,2}(\.\d{1,6})?$';
 -- Setting variables for time of day/ day of week analyses
DECLARE
 MORNING_START,
 MORNING_END,
 AFTERNOON_END,
 EVENING_END INT64;
 -- Set the times for the times of the day
SET
 MORNING_START = 6;
SET
 MORNING_END = 12;
SET
 AFTERNOON_END = 18;
SET
 EVENING_END = 21;

-- Check to see which column names are shared across tables
SELECT
 column_name,
 COUNT(table_name)
FROM
 data-analysis-portfolio-407018.FitBit_Dataset.INFORMATION_SCHEMA.COLUMNS
GROUP BY
 1;
-- -> The result shows that Id and ActivityDay columns are shared accross most tables

-- Check if the Id column is available in every table
SELECT
 table_name,
 SUM(CASE
     WHEN column_name = "Id" THEN 1
   ELSE
   0
 END
   ) AS has_id_column
FROM
 data-analysis-portfolio-407018.FitBit_Dataset.INFORMATION_SCHEMA.COLUMNS
GROUP BY
 1
ORDER BY
 1 ASC;
 -- -> Id column is available in every table

-- Check for the column names of the type DATETIME, TIMESTAMP, or DATE
SELECT
 CONCAT(table_catalog,".",table_schema,".",table_name) AS table_path,
 table_name,
 column_name
FROM
 data-analysis-portfolio-407018.FitBit_Dataset.INFORMATION_SCHEMA.COLUMNS
WHERE
 data_type IN ("TIMESTAMP",
   "DATETIME",
   "DATE");
   
 -- In the dailyActivity_merged table we saw that there is a column called ActivityDay
 -- Use a regular expression for a timestamp format to check if the column ActivityDay follows that pattern
 -- The is_timestamp column demonstrates that this column is a valid timestamp column
 SELECT
 ActivityDate,
 REGEXP_CONTAINS(STRING(ActivityDate), TIMESTAMP_REGEX) AS is_timestamp
 FROM
 data-analysis-portfolio-407018.FitBit_Dataset.DailyActivity
 LIMIT
 20;
 -- -> The result shows the ActivityDay column has Date format
 
-- To quickly check if all columns follow the timestamp pattern, take the minimum value of the boolean expression across the entire table
SELECT
 CASE
   WHEN MIN(REGEXP_CONTAINS(STRING(ActivityDate), TIMESTAMP_REGEX)) = TRUE THEN "Valid"
 ELSE
 "Not Valid"
END
 AS valid_test
FROM
 data-analysis-portfolio-407018.FitBit_Dataset.DailyActivity;
 -- -> All columns don't show the timestamp pattern

 -- Find tables which are at the day level to do analysis based on daily data
 SELECT
 DISTINCT table_name
 FROM
 `data-analysis-portfolio-407018.FitBit_Dataset.INFORMATION_SCHEMA.COLUMNS`
 WHERE
 REGEXP_CONTAINS(LOWER(table_name),"day|daily");
 -- -> The tables which have day level are: DailyIntensities, DailySteps, DailyActivity, DailyCalories, SleepDay

 -- Look at the columns that are shared among these tables which have day level
 SELECT
 column_name,
 data_type,
 COUNT(table_name) AS table_count
 FROM
 `data-analysis-portfolio-407018.FitBit_Dataset.INFORMATION_SCHEMA.COLUMNS`
 WHERE
 REGEXP_CONTAINS(LOWER(table_name),"day|daily")
 GROUP BY
 1,
 2;
 -- -> Id and ActivityDay columns are shared accross most tables

-- Check if the data types align between tables
SELECT
 column_name,
 table_name,
 data_type
FROM
 `data-analysis-portfolio-407018.FitBit_Dataset.INFORMATION_SCHEMA.COLUMNS`
WHERE
 REGEXP_CONTAINS(LOWER(table_name),"day|daily")
 AND column_name IN (
 SELECT
   column_name
 FROM
   `data-analysis-portfolio-407018.FitBit_Dataset.INFORMATION_SCHEMA.COLUMNS`
 WHERE
   REGEXP_CONTAINS(LOWER(table_name),"day|daily")
 GROUP BY
   1
 HAVING
   COUNT(table_name) >=2)
ORDER BY
 1;
 -- -> The data types are align between these tables






 



 
