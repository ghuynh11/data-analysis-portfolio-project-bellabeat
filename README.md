# data-analysis-bellabeat-sql
# My SQL queries for my data analysis project using Fitbit Fitness Tracker Data
-- Check to see which column names are shared across tables
SELECT
 column_name,
 COUNT(table_name)
FROM
 data-analysis-portfolio-407018.FitBit_Dataset.INFORMATION_SCHEMA.COLUMNS
GROUP BY
 1;
