-- Bellabeat Case Study Analysis - Complete SQL Code

-- 1. Summary statistic

-- Daily steps
SELECT 
 MIN(TotalSteps) AS min_daily_steps, 
 MAX(TotalSteps) AS max_daily_steps,
 ROUND(AVG(TotalSteps),1) AS avg_daily_steps,
FROM 
 data-analysis-portfolio-407018.FitBit_Dataset.DailyActivity
 
-- Distance
SELECT 
 MIN(TotalDistance) AS min_distance, 
 MAX(TotalDistance) AS max_distance,
 ROUND(AVG(TotalDistance),1) AS avg_distance,
FROM 
 data-analysis-portfolio-407018.FitBit_Dataset.DailyActivity

-- Minutes sleep
SELECT 
 MIN(TotalMinutesAsleep) AS min_minutes_asleep, 
 MAX(TotalMinutesAsleep) AS max_minutes_asleep,
 ROUND(AVG(TotalMinutesAsleep),1) AS avg_minutes_asleep
FROM 
 data-analysis-portfolio-407018.FitBit_Dataset.SleepDay_1

-- Active minutes
SELECT 
 MIN(VeryActiveMinutes) AS veryactivemin_min, 
 MIN(FairlyActiveMinutes) AS fairlyactivemin_min,
 MIN(LightlyActiveMinutes) AS lightlyactivemin_min,
 MIN(SedentaryMinutes) AS sedentarymin_min,
 MAX(VeryActiveMinutes) AS veryactivemin_max,
 MAX(FairlyActiveMinutes) AS fairlyactivemin_max,
 MAX(LightlyActiveMinutes) AS lightlyactivemin_max,
 MAX(SedentaryMinutes) AS sedentarymin_max,
 ROUND(AVG(VeryActiveMinutes),1) AS veryactivemin_avg,
 ROUND(AVG(FairlyActiveMinutes),1) AS fairlyactivemin_avg,
 ROUND(AVG(LightlyActiveMinutes),1) AS lightactivemin_avg,
 ROUND(AVG(SedentaryMinutes),1) AS sedentarymin_avg
FROM 
 data-analysis-portfolio-407018.FitBit_Dataset.DailyActivity

-- 2. Analysis on daily activity

-- Merge all daily tables to perform deeper analysis
-- Create custom daily_sleep table with new columns using CTE (Common Table Expression)
WITH daily_sleep_custom AS (
 SELECT 
   *,
   cast(sleepday as date) AS default_date
 FROM
   data-analysis-portfolio-407018.FitBit_Dataset.SleepDay_1
),

-- Create custom daily_activity table with new columns that extract day of week and week number from the 'activitydate' column
daily_activity_custom AS (
 SELECT
  *,
  FORMAT_DATE("%w", ActivityDate) AS dow_number,
  FORMAT_DATE("%A", ActivityDate) AS day_of_week
 FROM
  data-analysis-portfolio-407018.FitBit_Dataset.DailyActivity
),

-- Join the above two custom tables with daily_calories, daily_intensities, daily_steps and daily_sleep tables
daily_analysis AS (
SELECT 
 a.Id,
 a.activitydate,
 a.day_of_week,
 a.dow_number,
 a.calories,
 a.totalsteps,
 a.totaldistance,
 i.sedentaryminutes,
 i.lightlyactiveminutes,
  i.fairlyactiveminutes,
  i.veryactiveminutes,
  i.sedentaryactivedistance,
  i.lightactivedistance,
  i.moderatelyactivedistance,
  i.veryactivedistance,
 sl.totaltimeinbed,
 sl.totalminutesasleep
FROM
 daily_activity_custom AS a
 LEFT JOIN
 data-analysis-portfolio-407018.FitBit_Dataset.DailyCalories AS c
 ON a.Id = c.Id AND a.activitydate = c.activityday AND a.calories = c.calories
 LEFT JOIN
 data-analysis-portfolio-407018.FitBit_Dataset.DailyIntensities AS i
 ON a.Id = i.Id
 AND a.activitydate = i.activityday
 AND a.fairlyactiveminutes = i.fairlyactiveminutes
 AND a.lightactivedistance = i.lightactivedistance
 AND a.lightlyactiveminutes = i.LightlyActiveMinutes
 AND a.moderatelyactivedistance = i.moderatelyactivedistance
 AND a.sedentaryactivedistance = i.sedentaryactivedistance
 AND a.sedentaryminutes = i.sedentaryminutes
 AND a.veryactivedistance = i.veryactivedistance
 AND a.veryactiveminutes = i.veryactiveminutes
 LEFT JOIN 
 data-analysis-portfolio-407018.FitBit_Dataset.DailySteps AS s
 ON a.Id = s.Id AND a.activitydate = s.activityday
 LEFT JOIN
 daily_sleep_custom AS sl
 ON a.Id = sl.Id AND a.activitydate = sl.default_date
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
ORDER BY activitydate
)

-- Extract different types of minutes and time asleep
SELECT 
 DISTINCT Id, 
 ROUND(AVG(sedentaryminutes),2) AS sendentary_mins,
 ROUND(AVG(lightlyactiveminutes),2) AS lightly_active_mins,
 ROUND(AVG(fairlyactiveminutes),2) AS fairly_active_mins, 
 ROUND(AVG(veryactiveminutes),2) AS very_active_mins,
 ROUND(AVG(totaltimeinbed),2) AS sleep_mins
FROM daily_analysis
WHERE totaltimeinbed IS NOT NULL
GROUP BY Id
ORDER BY Id;

-- 3. Analysis on how people sleep

-- Sleep related product could be a possibility -> check to see if/how people sleep during the day
-- Assuming a nap is any time someone goes to sleep and wakes up in the same day
SELECT
 Id,
 sleep_start AS sleep_date,
 COUNT(logId) AS number_naps,
 SUM(EXTRACT(HOUR FROM time_sleeping)) AS total_time_sleeping
FROM (
 SELECT
  Id,
  logId,
  MIN(DATE(date)) AS sleep_start,
  MAX(DATE(date)) AS sleep_end,
  TIME( TIMESTAMP_DIFF(MAX(date),MIN(date),HOUR),
  MOD(TIMESTAMP_DIFF(MAX(date),MIN(date),MINUTE),60),
  MOD(MOD(TIMESTAMP_DIFF(MAX(date),MIN(date),SECOND),3600),60) ) AS time_sleeping
 FROM(
  SELECT 
   *,
   PARSE_TIMESTAMP('%m/%d/%Y %I:%M:%S %p', CAST(date AS STRING)) AS parsed_timestamp
  FROM 
   `data-analysis-portfolio-407018.FitBit_Dataset.minutesleep_1`
 )
 WHERE value=1
 GROUP BY 1, 2
)
WHERE
 sleep_start = sleep_end
GROUP BY 1, 2
ORDER BY 3 DESC;

-- 4. Analysis on intensity level

-- Analyze based on time of the day and day of the week
-- Smooth over anomalous days
WITH user_dow_summary AS (
 SELECT
  Id,
  FORMAT_TIMESTAMP("%w", ActivityDay) AS dow_number,
  FORMAT_TIMESTAMP("%A", ActivityDay) AS day_of_week,
  CASE
   WHEN FORMAT_TIMESTAMP("%A", ActivityDay) IN ("Sunday", "Saturday") THEN "Weekend"
   WHEN FORMAT_TIMESTAMP("%A", ActivityDay) NOT IN ("Sunday", "Saturday") THEN "Weekday"
   ELSE "ERROR"
  END AS part_of_week,
  CASE
   WHEN TIME(PARSE_TIMESTAMP('%I:%M:%S %p', ActivityHour)) BETWEEN TIME(MORNING_START, 0, 0) AND TIME(MORNING_END, 0, 0) THEN "Morning"
   WHEN TIME(PARSE_TIMESTAMP('%I:%M:%S %p', ActivityHour)) BETWEEN TIME(MORNING_END, 0, 0)
    AND TIME(AFTERNOON_END, 0, 0) THEN "Afternoon"
   WHEN TIME(PARSE_TIMESTAMP('%I:%M:%S %p', ActivityHour)) BETWEEN TIME(AFTERNOON_END, 0, 0) AND TIME(EVENING_END, 0, 0) THEN "Evening"
   WHEN TIME(PARSE_TIMESTAMP('%I:%M:%S %p', ActivityHour)) >= TIME(EVENING_END, 0, 0)
    OR TIME(TIMESTAMP_TRUNC(PARSE_TIMESTAMP('%I:%M:%S %p', ActivityHour), MINUTE)) <= TIME(MORNING_START, 0, 0) THEN "Night"
   ELSE "ERROR"
  END AS time_of_day,
  SUM(TotalIntensity) AS total_intensity,
  SUM(AverageIntensity) AS total_average_intensity,
  AVG(AverageIntensity) AS average_intensity,
  MAX(AverageIntensity) AS max_intensity,
  MIN(AverageIntensity) AS min_intensity
 FROM
   `data-analysis-portfolio-407018.FitBit_Dataset.HourlyIntensities`
 GROUP BY 1, 2, 3, 4, 5),
 intensity_deciles AS (
 SELECT
  DISTINCT dow_number,
  part_of_week,
  day_of_week,
  time_of_day,
  ROUND(PERCENTILE_CONT(total_intensity, 0.1) OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day),4) AS total_intensity_first_decile,
  ROUND(PERCENTILE_CONT(total_intensity, 0.2) OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day),4) AS total_intensity_second_decile,
  ROUND(PERCENTILE_CONT(total_intensity, 0.3) OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day),4) AS total_intensity_third_decile,
  ROUND(PERCENTILE_CONT(total_intensity, 0.4) OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day),4) AS total_intensity_fourth_decile,
  ROUND(PERCENTILE_CONT(total_intensity, 0.6) OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day),4) AS total_intensity_sixth_decile,
  ROUND(PERCENTILE_CONT(total_intensity, 0.7) OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day),4) AS total_intensity_seventh_decile,
  ROUND(PERCENTILE_CONT(total_intensity, 0.8) OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day),4) AS total_intensity_eigth_decile,
  ROUND(PERCENTILE_CONT(total_intensity, 0.9) OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day),4) AS total_intensity_ninth_decile
 FROM
  user_dow_summary),
 basic_summary AS (
 SELECT
  part_of_week,
  day_of_week,
  time_of_day,
  SUM(total_intensity) AS total_total_intensity,
  AVG(total_intensity) AS average_total_intensity,
  SUM(total_average_intensity) AS total_total_average_intensity,
  AVG(total_average_intensity) AS average_total_average_intensity,
  SUM(average_intensity) AS total_average_intensity,
  AVG(average_intensity) AS average_average_intensity,
  AVG(max_intensity) AS average_max_intensity,
  AVG(min_intensity) AS average_min_intensity
 FROM
  user_dow_summary
 GROUP BY 1, dow_number, 2, 3)

SELECT
 *
FROM
 basic_summary
LEFT JOIN
 intensity_deciles
USING (
 part_of_week,
 day_of_week,
 time_of_day
 )
ORDER BY 1, dow_number, 2,
 CASE
  WHEN time_of_day = "Morning" THEN 0
  WHEN time_of_day = "Afternoon" THEN 1
  WHEN time_of_day = "Evening" THEN 2
  WHEN time_of_day = "Night" THEN 3
END;

-- Analyze sleep duration over weekend and weekday
WITH user_dow_summary AS (
 SELECT
  *,
  FORMAT_DATE("%w", SleepDay) AS dow_number,
  FORMAT_DATE("%A", SleepDay) AS day_of_week,
  CASE
   WHEN FORMAT_DATE("%A", SleepDay) IN ("Sunday", "Saturday") THEN "Weekend"
   WHEN FORMAT_DATE("%A", SleepDay) NOT IN ("Sunday", "Saturday") THEN "Weekday"
   ELSE "ERROR"
  END AS part_of_week,
  TotalTimeInBed - TotalMinutesAsleep AS minutes_awake
 FROM
  data-analysis-portfolio-407018.FitBit_Dataset.SleepDay_1
 )
SELECT * 
FROM user_dow_summary

-- Combine intensity and summary of all users
WITH user_dow_summary AS (
 SELECT
  Id,
  FORMAT_TIMESTAMP("%w", ActivityDay) AS dow_number,
  FORMAT_TIMESTAMP("%A", ActivityDay) AS day_of_week,
  CASE
   WHEN FORMAT_TIMESTAMP("%A", ActivityDay) IN ("Sunday", "Saturday") THEN "Weekend"
   WHEN FORMAT_TIMESTAMP("%A", ActivityDay) NOT IN ("Sunday", "Saturday") THEN "Weekday"
   ELSE "ERROR"
  END AS part_of_week,
  CASE
   WHEN TIME(PARSE_TIMESTAMP('%I:%M:%S %p', ActivityHour)) BETWEEN TIME(MORNING_START, 0, 0) AND TIME(MORNING_END, 0, 0) THEN "Morning"
   WHEN TIME(PARSE_TIMESTAMP('%I:%M:%S %p', ActivityHour)) BETWEEN TIME(MORNING_END, 0, 0) AND TIME(AFTERNOON_END, 0, 0) THEN "Afternoon"
   WHEN TIME(PARSE_TIMESTAMP('%I:%M:%S %p', ActivityHour)) BETWEEN TIME(AFTERNOON_END, 0, 0) AND TIME(EVENING_END, 0, 0) THEN "Evening"
   WHEN TIME(PARSE_TIMESTAMP('%I:%M:%S %p', ActivityHour)) >= TIME(EVENING_END, 0, 0)
    OR TIME(TIMESTAMP_TRUNC(PARSE_TIMESTAMP('%I:%M:%S %p', ActivityHour), MINUTE)) <= TIME(MORNING_START, 0, 0) THEN "Night"
  ELSE "ERROR"
  END AS time_of_day,
  AverageIntensity,
  SUM(TotalIntensity) AS total_intensity,
  SUM(AverageIntensity) AS total_avg_intensity
 FROM
  `data-analysis-portfolio-407018.FitBit_Dataset.HourlyIntensities`
 GROUP BY 1, 2, 3, 4, 5, 6
 )

SELECT
 HI.Id,
 day_of_week,
 part_of_week,
 time_of_day,
 total_intensity,
 total_avg_intensity,
 AverageIntensity,
 SUM(Calories) AS total_calories,
 ROUND(AVG(Calories), 2) AS avg_calories
FROM 
 user_dow_summary AS HI
 LEFT JOIN data-analysis-portfolio-407018.FitBit_Dataset.HourlyCalories AS HC
 ON HI.Id = HC.Id
GROUP BY 1, 2, 3, 4, 5, 6, 7

-- 5. Analysis based on achievement groups
 
WITH daily_activity_custom AS (
 SELECT
  EXTRACT (WEEK FROM activitydate) AS week_number,
  *
 FROM
  data-analysis-portfolio-407018.FitBit_Dataset.DailyActivity
),

-- Total weekly summary for each user
weekly_analysis_perId AS(
SELECT 
 week_number,
 Id,
 SUM(totalsteps) AS weekly_total_steps,
 SUM(veryactiveminutes) AS weekly_veryactive_m,
 SUM(fairlyactiveminutes) AS weekly_fairlyactive_m,
 SUM(lightlyactiveminutes) AS weekly_lightactive_m,
 SUM(sedentaryminutes) AS weekly_sedentary_m,
 SUM(calories) AS weekly_calories,
 SUM(veryactiveminutes) + SUM(fairlyactiveminutes) AS total_weekly_active_m,
 SUM(lightlyactiveminutes) + SUM(sedentaryminutes) AS total_weekly_notactive_m
FROM 
 daily_activity_custom
GROUP BY 1, 2
ORDER BY 1, 2
),

-- Extract all weeks that have active mins >= 150
highly_active_week AS (
SELECT 
 week_number, 
 Id, 
 SUM(total_weekly_active_m) as active_min_total,
 CASE 
 WHEN SUM(total_weekly_active_m) >= 150 THEN 1
 ELSE 0
 END AS is_highly_active
FROM 
 weekly_analysis_perId
GROUP BY 
 week_number,
 Id
ORDER BY 
 Id
),

-- Create achievement groups
achievement_grp AS (
SELECT 
 Id,
 (SUM(is_highly_active)/COUNT(Id))*100 AS percentage,
 CASE 
  -- low rate ➜ successful 0-59% of weeks
  WHEN (SUM(is_highly_active)/COUNT(Id))*100 <= 59 THEN 'LOW'
  -- regular rate ➜ successful 60-79% of weeks
  WHEN (SUM(is_highly_active)/COUNT(Id))*100 > 59 AND (SUM(is_highly_active)/COUNT(Id))*100 <= 79 THEN 'REGULAR'
  -- high rate ➜ successful 80-100% of weeks
  WHEN (SUM(is_highly_active)/COUNT(Id))*100 >= 80 THEN 'HIGH'
 END AS achievement_group
FROM 
 highly_active_week
GROUP BY Id
ORDER BY Id
)

-- Percentage of weeks a participant is successful in achieving ≥ 150 active minutes
SELECT 
 achievement_group, 
 COUNT(*) AS user_count,
 ROUND((COUNT(*)/33.0),3)*100 AS percent_of_whole
FROM 
 achievement_grp
GROUP BY 
 achievement_group

