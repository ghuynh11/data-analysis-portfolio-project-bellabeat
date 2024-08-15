# Data Analysis Portfolio Project - Bellabeat Case Study
## Using SQL, Google Sheet and Tableau

## About
Founded in 2014, [Bellabeat](https://bellabeat.com/) is the company that developed one of the first wearables specifically designed for women and has since gone on to create a portfolio of digital products for tracking and improving the health of women.

## Scenario
I am a junior data analyst working on the marketing analyst team at Bellabeat. Bellabeat is a successful small company, but they have the potential to become a larger player in the global smart device market. Urška Sršen, cofounder and Chief Creative Officer of Bellabeat, believes that analyzing smart device fitness data could help unlock new growth opportunities for the company. 

I have been asked to focus on one of Bellabeat’s products and analyze smart device data to gain insight into how consumers are using their smart devices. The insights I discover will then help guide marketing strategy for the company. I will present my analysis to the Bellabeat executive team along with your high-level recommendations for Bellabeat’s marketing strategy.

I follow the steps below for this project:
- Ask
- Prepare
- Process
- Analyse
- Share
- Act

## STEP 1: Ask
**Topic:** Smart device health data

**Business task:**
- Analyse smart device fitness data to unlock new growth opportunities for the company
- Gain insights into how consumers are using non-Bellabeat smart devices → Then select one Bellabeat product to apply these insights
- Find out how these insights can contribute to building marketing strategy for the company

→ Analyse smart device fitness data to gain insights into how consumers are using their smart devices to keep track and improve their health. Use the insights found to build marketing strategy for the company.

I will focus on one of Bellabeat’s products: **Bellabeat app**.
The Bellabeat app provides users with health data related to their activity, sleep, stress, menstrual cycle, and mindfulness habits. This data can help users better understand their current habits and make healthy decisions. The Bellabeat app connects to their line of smart wellness products.

As there’re no information about the goals of marketing strategy for the Bellabeat app, here are my recommendations:
- Increase user engagement with Bellabeat app
- Promotion for other Bellabeat products based on user needs:
  - Leaf: Bellabeat’s classic wellness tracker can be worn as a bracelet, necklace, or clip. The Leaf tracker connects to the Bellabeat app to track activity, sleep, and stress.
  - Time: This wellness watch combines the timeless look of a classic timepiece with smart technology to track user activity, sleep, and stress. The Time watch connects to the Bellabeat app to provide you with insights into your daily wellness.
  - Bellabeat membership: Bellabeat also offers a subscription-based membership program for users. Membership gives users 24/7 access to fully personalized guidance on nutrition, activity, sleep, health and beauty, and mindfulness based on their lifestyle and goals.

**Stakeholders:**
- Urška Sršen: Bellabeat’s cofounder and Chief Creative Officer
- Sando Mur: Mathematician and Bellabeat’s cofounder; key member of the Bellabeat executive team
- Bellabeat marketing analytics team


## STEP 2: Prepare
**Dataset:** the data is stored in Kaggle public dataset and provided by Möbius.
[Link to dataset](https://www.kaggle.com/datasets/arashnic/fitbit)

**Is the data ROCCC?**
- Reliable: yes
- Original: yes
- Comprehensive: yes
- Current: The data is updated 4 months ago (02.2024). But the original data dated back to 2016 which is not actual considering the current year.
- Cited: This dataset is created based on the respondents to a distributed survey via Amazon Mechanical Turk between 03.12.2016-05.12.2016. Thirty eligible Fitbit users consented to the submission of personal tracker data to this dataset.

**License:** CC0 public domain → No copyright: copy, modify, distribute and perform the work, even for commercial purposes, all without asking permission.

**Description:** After first examination of the data, the following points are noted
- The data is organized in a long format.
- The data is classified based on: daily data, hourly data and minute data.
- Each ID represents one user with their data distributed in multiple rows.
- With the business task in mind, the sample size is considered to be not big enough to gain representative insights about the consumers behaviours with smart devices.
- The lack of demographic data like age, location and gender also affects the ability to generate representative insights about the population. As the Bellabeat smart devices primarily target women, the recommendation based on these insights could be biased.
- In terms of integrity and credibility, the dataset is not 100% correct as stated in the data description. There’re 33 unique IDs representing 33 Fitbit users instead of 30 eligible users like mentioned.
- The sample size is not large enough to represent the population and increase the confidence level.

## STEP 3: Process
**Tool:** Google Sheet, SQL

**Datasets used for the analysis in the timeframe from 12th Apr to 12th May 2016:**
- dailyActivity_merged
- dailyIntensities_merged
- dailySteps_merged
- sleepDay_merged
- weightLogInfo_merged
- hourlyCalories_merged
- hourlyIntensities_merged
- hourlySteps_merged
- minuteSleep_merged
- sleepDay_merged
- weightLogInfo_merged

**Documentation of data cleaning and manipulation in Google Sheets:**
- Sorted and filtered the data
- Checked for blank values
- Set values to the correct format and rounded numbers
- Formated the date and time column in “hourlyCalories_merged”, “hourlySteps_merged”, “minuteSleep_merged”, “sleepDay_merged” and “weightLogInfo_merged” datasets using SPLIT() function. The data in the column which is not in the correct format is deleted.
- In the “minuteSleep_merged” and “sleepDay_mearged’ datasets, there are only 24 unique IDs instead of 33 like in the other datasets.
- In the “weightLogInfo_merged” dataset, there are only 8 unique IDs instead of 33.

**The datasets are uploaded into SQL BigQuery for further data cleaning and manipulation:**

SQL query: [Link](https://github.com/ghuynh11/data-analysis-portfolio-project-bellabeat/blob/main/Data-processing.sql)

## STEP 4: Analyze
**1. Summary statistics**

SQL query: [Link](https://github.com/ghuynh11/data-analysis-portfolio-project-bellabeat/blob/main/Data-analysis.sql)

Daily steps:

![Daily steps](https://github.com/user-attachments/assets/c520433c-3ad3-4990-9757-227ecfa6dc5b)

Distance:

![Distance](https://github.com/user-attachments/assets/e431c86f-a069-448d-a89b-5ea139401ccf)

Minutes asleep:

![Minutes asleep](https://github.com/user-attachments/assets/eecae7a7-3770-40e4-8dd4-138655327074)

Very active, fairly active, lightly active and sedentary active minutes:

![MIN_active minutes](https://github.com/user-attachments/assets/5265cb6d-795a-4249-a597-2daa5c0fdffc)

![MAX_active minutes](https://github.com/user-attachments/assets/e6a43327-a5b1-45f0-8c12-d1802026aab1)

![AVG_active minutes](https://github.com/user-attachments/assets/578135ba-6974-425f-9f3c-8e9616691ceb)

**Findings:**
- 7638 average total steps are below the recommended daily total steps of 10,000 (source: [National Institute of Health](https://www.nih.gov/news-events/nih-research-matters/number-steps-day-more-important-step-intensity#:~:text=A%20goal%20of%2010%2C000%20steps,been%20done%20in%20older%20adults.).
- The average sedentary active minutes (time spent while sitting or lying down) is highest among the other categories.
- The median value of 4 very active minutes indicates that half of the users spend less than or equal to 4 minutes in “Very Active” physical activity per day, and the other half spend more than 4 minutes. This suggests that while the average is 21 very active minutes, the majority of users are not engaging in very high levels of intense physical activity; many users might be doing much less than the average suggests.

**Actionable recommendations for marketing strategy:**
- Targeting Less Active Users: Marketing strategies could be developed to target the majority of users who are less active, encouraging them to increase their daily “Very Active Minutes.”
- Engagement Programs: Creating challenges or programs aimed at increasing users’ very active minutes might help shift the median upwards, improving overall user fitness.
- Personalized Recommendations: For users on the lower end of the activity scale, personalized recommendations could help them gradually increase their very active minutes, potentially improving their health outcomes.

**2. Analysis on daily activity**

![Daily avg  total steps](https://github.com/user-attachments/assets/07f549db-e68c-44db-b877-0f45843ebdc1)

→ The users tend to walk more on Tuesday and Saturday compared to the other days of the week.

![Daily avg  very active minutes](https://github.com/user-attachments/assets/c5184ee5-e90f-4639-b917-cc5955c41aad)

→ The users tend to be more active on Monday and Tuesday compared to the other days of the week.

![Distribution of very active minutes](https://github.com/user-attachments/assets/e7d4e2fa-8563-4eb1-96aa-e86fa9499afe)

→ The majority of users have very few “Very Active Minutes” per day, with a large number clustered around the lower end of the spectrum (0-10 minutes).
→ This suggests that a significant portion of users are not engaging in high levels of high-intensity activity regularly.

![Daily avg  minutes](https://github.com/user-attachments/assets/7fdd9f71-a9f1-49ce-abb9-f8e7dbc2e453)

→ This graph indicates again that the majority of the users are often not active. The average sedentary minutes are the highest among the other categories. This might suggest that some users have higher amount of sedentary behaviours, which are defined as time spent sitting or lying with low energy expenditure, while awake, in the context of occupational, educational, home,... (Source: [WHO](https://iris.who.int/bitstream/handle/10665/336656/9789240015128-eng.pdf?sequence=1)

Analyze how the users spend their time based on different types of minutes

![Sheet 9](https://github.com/user-attachments/assets/c3afc2e2-1392-45b0-90d4-abbabacdf9eb)

→ Most of the time of the day is spent on sedentary activities and sleep. Only a small part of the time is spent on activities which are recorded as active, fairly active or lightly active minutes.

![Intensity](https://github.com/user-attachments/assets/5f66ae0a-30aa-4a69-be8f-d768da000121)

→ On Monday, Tuesday and Wednesday, the users tend to have higher intensity level in the morning and in the afternoon. The calories burned at these times are also respectively higher compared to the other days of the week.

**Actionable recommendations for marketing strategy:**
- Targeting Sedentary Users: Since most users have low very active minutes, a marketing strategy could focus on encouraging moderate increases in activity levels, such as setting achievable fitness goals.
- Highlight Benefits: Educational content on the health benefits of even small increases in very active minutes could be emphasized to motivate users to be more active.

![Corr_total steps_calories burned](https://github.com/user-attachments/assets/027ff965-395d-4743-97c4-6f28771c7706)

The correlation value is 0.59.

→ There’s moderate positive correlation between total steps and calories burned.

→ However, some data points are at 0 or near 0 on the x-axis (total steps), yet they are higher on the y-axis (calories). This could happen for some reasons:
- Basal Metabolic Rate (BMR): Caloric Burn Without Activity, even if someone does not take any steps during the day, they still burn calories due to their basal metabolic rate (BMR).
- Other Forms of Exercise: Calories could be burned through activities that do not involve step count, such as cycling, swimming, or weightlifting. These activities burn calories without necessarily being reflected in the step count.
- Tracking Errors: There might be discrepancies in how the device recorded steps versus calories. This can happen due to issues like syncing problems, the device being worn improperly, or other technical errors.
- Missing Data: If steps weren’t recorded accurately (e.g., the device wasn’t worn during walking but was during sedentary periods), it could result in zero steps being recorded but still show calories burned.

![Corr_active minutes_calories burned](https://github.com/user-attachments/assets/3b378496-28c6-4522-85ae-fb8abf665cec)

The correlation value is 0.62.

→ There’s moderate positive correlation between very active minutes and calories burned.

→ In this graph, there’re even more data points at 0 or near 0 on the x-axis (very active minutes), yet these data points are higher on the y-axis (calories burned). Some of the reasons could be:
- Some users have higher Basal Metabolic Rate
- Some users had additional activities not captured as “Very active minutes”. For example, yoga, stretching, strength training might not be recorded for very active minutes category.
- Tracking errors or missing data.

![Corr_minutes asleep_calories burned](https://github.com/user-attachments/assets/cef357e2-f4e5-491f-a2a9-a25e2d701712)

The correlation value is -0.03.

→ There’s essentially no linear relationship between total minutes asleep and calories burned.

![Corr_minutes asleep_total steps](https://github.com/user-attachments/assets/1d5f94ce-4f44-481e-9504-b100c80368d5)

The correlation value is -0.19

**3. Analysis on how people sleep**

![Avg  total asleep](https://github.com/user-attachments/assets/587e1e85-5c83-4338-8641-e6b4387ac86c)

![Avg  total awake](https://github.com/user-attachments/assets/788f2092-9b47-45b0-bbaa-9e09b5ba818f)

→ The average time asleep of the users is higher on Sunday and Wednesday compared to the other days.

→ The users seem to sleep more on weekend, but they also spend more time awake on bed. This could indicate that the quality of sleep is not very good.

**4. Analysis on intensity level upon time of day and day of week**

Time of day: Morning, Afternoon, Evening, Night
Day of the week: Weekday, Weekend
Dataset: hourlyIntensities_merged
- Investigate how activity intensity varies by time of day, day of the week, and part of the week (weekday vs. weekend).
- Identify Patterns: Look for patterns that might suggest user behaviors, such as peak activity times or consistent days of low activity.
- Behavioral Segmentation: Group users based on their activity patterns

![Intensity_level](https://github.com/user-attachments/assets/1ed6bce4-8fd5-48e8-9265-8b8eaf8012d9)

→ The total intensity level among the users is highest on Tuesday, follows by Wednesday.

![Intensity_day](https://github.com/user-attachments/assets/0ae4b04e-1512-42bd-981b-e6113a117457)

→ Users are more active either in the morning or in the afternoon.

→ Users are mostly active on Tuesday and Wednesday afternoon.

![Intensity_decile](https://github.com/user-attachments/assets/fc6ef068-5c32-406b-bff3-b85c88777f9f)

→ The first decile represents the lower bound of intensity, showing where 10% of the data points fall. The total intensity at the first decile tends to be lower on Monday compared to the others.

→ The ninth decile represents the upper bound of intensity, showing where 90% of the data points fall. The total intensity at the ninth decile is generally higher from Tuesday to Thursday compared to others, indicating more active or intense activity on these days.

→ This pattern might suggest that users are less active on weekends, or their activity intensity is more moderate.

**Actionable recommendations for marketing strategy:**
- Promote Bellabeat membership feature: provide fully personalized guidance on suitable nutrition on active days and rest days.
- Push notifications of Bellabeat app should align with peak activity time and resting time. → For example, diet suggestions in the morning before and after workout. Mindfulness reminder on rest day.

**5. Analysis based on achievement groups**

Create total active and fairly active minutes weekly summary for each user and extract all weeks that have active minutes from 150 and above.

The result from SQL query shows 154 records of weekly active minutes of each user through the entire analysis period, of which:
- 46% of the observations have below 150 active minutes per week. This is below the recommendation of WHO: 150 – 300 minutes of moderate intensity activity per week for good health and wellbeing.
- 29% of the observations have between 150 to 300 active minutes per week.
- 25% of the observations have more than 300 active minutes per week.

![Group](https://github.com/user-attachments/assets/e815da1e-720a-44c9-9183-d744af2fda7d)

**Results:**
- Group A: high weekly achievement rate
  42.4% of all users are in this group (14 of 33) got 80 – 100% of weeks of active minutes ≥ 150.
- Group B: weekly regular achievement rate
  9.1% of all users are in this group (3 of 33) got 60 – 79% of weeks of active minutes ≥ 150.
- Group C: weekly low achievement rate
  48.5% of all participants are in this group (16 of 33) got 0 – 59% of weeks of active minutes ≥ 150.

## STEP 5: Share

Tool: Tableau

The insights and findings of the analysis are shared in this step through data visualization in form of graphs and plots. This makes it easier for the non-technical audience to understand the important findings.

For this project, it would be better to share the visualizations together with their respective queries and tables.

I also created a Tableau dashboard of all the visualizations of this project in this link. **(Dashboard to be finalized)**

## STEP 6: Act

The important findings from the analysis of smart device fitness data:
- 7638 average total steps of all users are below the recommended daily total steps of 10,000 (source: National Institute of Health)
- The average sedentary active minutes (time spent while sitting or lying down) is highest among the other categories (991 minutes).
- One of the most important metrics of the analysis are the active minutes, including very active minutes and fairly activeminutes. → Nearly 50% of the users have less than 60% of the weeks where they achieved more than 150 minutes active minutes.
→ Together with the findings about average total steps and average sedentary minutes, I would conclude that most of the users are not active.
- Generally, the users tend to be more active on Monday, Tuesday and Wednesday compared to the other days of the week. The most active time of the day are in the morning and in the afternoon.
- The users seem to sleep more on weekend, but they also spend more time awake on bed. This could indicate that the quality of sleep is not very good.

**Recommendations for marketing strategy to be summarized**










 



 
