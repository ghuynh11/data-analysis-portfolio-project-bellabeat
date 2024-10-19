# Data Analysis Portfolio Project - Bellabeat Case Study
## Using SQL, Google Sheet and Tableau

## About
Founded in 2014, [Bellabeat](https://bellabeat.com/) is the company that developed one of the first wearables specifically designed for women and has since gone on to create a portfolio of digital products for tracking and improving the health of women.

## Scenario
I am a junior data analyst working on the marketing analyst team at Bellabeat. Bellabeat is a successful small company, but they have the potential to become a larger player in the global smart device market. Urška Sršen, cofounder and Chief Creative Officer of Bellabeat, believes that analyzing smart device fitness data could help unlock new growth opportunities for the company. 

I have been asked to focus on one of Bellabeat’s products and analyze smart device data to gain insight into how consumers are using their smart devices. The insights I discover will then help guide marketing strategy for the company. I will present my analysis to the Bellabeat executive team along with your high-level recommendations for Bellabeat’s marketing strategy.

I follow the methodology with the steps below for this project:
1. Ask: Define the business problem or objective by understanding the key questions that need to be answered and identifying stakeholders’ needs.
2. Prepare: Gather and evaluate the relevant data, ensuring it’s accessible, complete, and appropriate for the analysis by cleaning and organizing the datasets.
3. Process: Clean and transform the raw data, checking for errors, inconsistencies, or missing values to ensure that it is reliable and ready for analysis.
4. Analyse: Apply analytical techniques to explore the data, identify patterns, trends, and relationships, and extract actionable insights relevant to the business problem.
5. Share: Present findings through reports, visualizations, or dashboards in a clear, understandable and engaging way to communicate key insights to stakeholders.
6. Act: Use the insights gained to inform decision-making, implement solutions, or recommend strategies that address the original business question or problem.

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
- Reliable: not really (more details in the description below)
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

Daily steps, distance, minutes asleep:

<img width="481" alt="image" src="https://github.com/user-attachments/assets/2d4e4805-8fca-498d-8eb0-59256c1d702b">

Very active, fairly active, lightly active and sedentary active minutes:

<img width="633" alt="image" src="https://github.com/user-attachments/assets/94a9962a-4d54-48c0-9d47-547d260878f8">


**Findings:**
- 7638 average total steps are below the recommended daily total steps of 10,000 (source: [National Institute of Health](https://www.nih.gov/news-events/nih-research-matters/number-steps-day-more-important-step-intensity#:~:text=A%20goal%20of%2010%2C000%20steps,been%20done%20in%20older%20adults.)).
- The average sedentary active minutes (time spent while sitting or lying down) is highest among the other categories.
- The median value of 4 very active minutes indicates that half of the users spend less than or equal to 4 minutes in “Very Active” physical activity per day, and the other half spend more than 4 minutes. This suggests that while the average is 21 very active minutes, the majority of users are not engaging in very high levels of intense physical activity; many users might be doing much less than the average suggests.

**2. Analysis on daily activity**

![Daily avg  total steps   very active min](https://github.com/user-attachments/assets/bb15bcd7-f55f-43d2-9f04-ba0773776285)

→ The users tend to walk more on Tuesday and Saturday compared to the other days of the week.

→ Based on the very active minutes category, the users are more active on Monday and Tuesday.


![Distribution very active min](https://github.com/user-attachments/assets/939a112a-7629-497b-b411-206541e8b32c)

→ The majority of users have very few “Very Active Minutes” per day, with a large number clustered around the lower end of the spectrum (0-10 minutes).

→ This suggests that a significant portion of users are not engaging in high levels of high-intensity activity regularly.


![Daily avg  min categories - Day of week](https://github.com/user-attachments/assets/f908276b-ef4b-452f-a740-1a6262b43520)


<img width="1119" alt="image" src="https://github.com/user-attachments/assets/5c1eea09-9ce7-4cb1-aeb6-8198e2b5e0bc">

→ This graph indicates again that the majority of the users are often not active. The average sedentary minutes are the highest among the other categories. This might suggest that some users have higher amount of sedentary behaviours, which are defined as time spent sitting or lying with low energy expenditure, while awake, in the context of occupational, educational, home,... (Source: [WHO](https://iris.who.int/bitstream/handle/10665/336656/9789240015128-eng.pdf?sequence=1))



![Total intensity   total calories](https://github.com/user-attachments/assets/c194be44-e055-4321-9ef4-a90d0d0ff6d8)

→ On Monday, Tuesday and Wednesday, the users tend to have higher intensity level in the morning and in the afternoon. The calories burned at these times are also respectively higher compared to the other days of the week.


![Correlation calories vs total steps - very active min - min asleep](https://github.com/user-attachments/assets/e8463c11-3f24-49af-b0f8-e16874071b2a)

<img width="1199" alt="image" src="https://github.com/user-attachments/assets/01cb3400-9734-4ead-91fc-ab1d8e0a7964">

→ There’s moderate positive correlation between calories burned and total steps as well as calories burned and very active minutes.

→ There’s essentially no linear relationship between calories burned and total minutes asleep.

→ However, some data points are at 0 or near 0 on the x-axis (total steps), yet they are higher on the y-axis (calories). This could happen for some reasons:
- Basal Metabolic Rate (BMR): Caloric Burn Without Activity, even if someone does not take any steps during the day, they still burn calories due to their basal metabolic rate (BMR).
- Other Forms of Exercise: Calories could be burned through activities that do not involve step count, such as cycling, swimming, or weightlifting. These activities burn calories without necessarily being reflected in the step count.
- Tracking Errors: There might be discrepancies in how the device recorded steps versus calories. This can happen due to issues like syncing problems, the device being worn improperly, or other technical errors.
- Missing Data: If steps weren’t recorded accurately (e.g., the device wasn’t worn during walking but was during sedentary periods), it could result in zero steps being recorded but still show calories burned.

**3. Analysis on how people sleep**

![Avg  total min asleep   awake weekly](https://github.com/user-attachments/assets/b0781634-adbe-4b42-9d2f-e4687d54860e)

→ The average time asleep of the users is higher on Sunday and Wednesday compared to the other days.

→ The users seem to sleep more on weekend, but they also spend more time awake on bed. This could indicate that the quality of sleep is not very good.

**4. Analysis on intensity level upon time of day and day of week**

Time of day: Morning, Afternoon, Evening, Night
Day of the week: Weekday, Weekend
Dataset: hourlyIntensities_merged
- Investigate how activity intensity varies by time of day, day of the week, and part of the week (weekday vs. weekend).
- Identify Patterns: Look for patterns that might suggest user behaviors, such as peak activity times or consistent days of low activity.
- Behavioral Segmentation: Group users based on their activity patterns

<img width="633" alt="image" src="https://github.com/user-attachments/assets/32de5eb5-03a9-4a8d-aa81-2547593ef12b">

→ The total intensity level among the users is highest on Tuesday, follows by Wednesday.


![Intensity level_time of day_day of week](https://github.com/user-attachments/assets/7cb51c23-2491-4e74-a078-8d89befa2553)

→ Users are more active either in the morning or in the afternoon.

→ Users are mostly active on Tuesday and Wednesday afternoon.


<img width="455" alt="image" src="https://github.com/user-attachments/assets/71738280-5eae-4b49-ac8d-5f9cc172b5c2">

→ The first decile represents the lower bound of intensity, showing where 10% of the data points fall. The total intensity at the first decile tends to be lower on Monday compared to the others.

→ The ninth decile represents the upper bound of intensity, showing where 90% of the data points fall. The total intensity at the ninth decile is generally higher from Tuesday to Thursday compared to others, indicating more active or intense activity on these days.

→ This pattern might suggest that users are less active on weekends, or their activity intensity is more moderate.

**5. Analysis based on achievement groups**

Create total active and fairly active minutes weekly summary for each user and extract all weeks that have active minutes from 150 and above.

The result from SQL query shows 154 records of weekly active minutes of each user through the entire analysis period. Based on this result, the users are then divided into 3 groups:

<img width="1251" alt="image" src="https://github.com/user-attachments/assets/f494f9e2-6066-4961-8cb5-a7fa47f0f3fa">

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

I also created a Tableau dashboard of some important visualizations of this project in this [LINK](https://public.tableau.com/views/BellabeatCaseStudy_17224486675350/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link).

## STEP 6: Act

The important findings from the analysis of smart device fitness data:
- 7638 average total steps of all users are below the recommended daily total steps of 10,000 (source: National Institute of Health)
- The average sedentary active minutes (time spent while sitting or lying down) is highest among the other categories (991 minutes).
- One of the most important metrics of the analysis are the active minutes, including very active minutes and fairly activeminutes. → Nearly half of the users have less than 60% of the weeks where they achieved more than 150 minutes active minutes.
→ Together with the findings about average total steps and average sedentary minutes, I would conclude that most of the users are not active.
- Generally, the users tend to be more active on Monday, Tuesday and Wednesday compared to the other days of the week. The most active time of the day are in the morning and in the afternoon.
- The users seem to sleep more on weekend, but they also spend more time awake on bed. This could indicate that the quality of sleep is not very good or they spend more time on their phone on weekends.

**Recommendations for marketing strategy**

- Targeting less active users (users in group C with low weekly achievement rate) to increase their engagement with Bellabeat app: Develop marketing strategy to target the majority of users who are less active, encouraging them to increase their daily “Very Active Minutes” by implementing the followings:
  - Highlight benefits: Offering free seminars on fitness topic like simple training plans for beginners to create sporty habits, quick and easy diet plans on workout days and rest days.
  - Engagement programs: Creating challenges based on users fitness data. The challenges could be "Complete a 5K run per week", "Reach 150 active minutes per week".
  - Personalized goal setting & training plan: The goal setting could be done by providing the users with some insights from their fitness data (steps, heart rate, activity level) in the last 3 months. Based on these insights, help the users to set suitable weekly goals like weight loss, muscle gain, 5K run, etc. and slowly increased their active level. → This could be combined with Bellabeat membership by offering users one month trial. The users will receive a one-time personalized goal and training plan based on their fitness data to test.
  - Incentive programms: Offering tangible rewards like discounts, cashback, gifts to users who meet their activity goals over a period of time. For example, users can receive discount codes on other Bellabeat products or Bellabeat membership when they achieve 10,000 total daily steps 5 times per week in a month.

→ These initiatives do not only motivate and support the users to be more physically active, they also increase users' engagement with Bellabeat app, at the same time promoting for other Bellabeat products and membership.

- Implement relevant push notifications of Bellabeat app which align with peak activity time and resting time:
  - Combining Bellabeat membership to show diet suggestions in the morning and in the afternoon before and after workout. According to the data, morning and afternoon are when the users being mostly active. By sending relevant push notifications at the right moment, we could increase users's engagement with Bellabeat app and membership.
  - Targeting users who have longer awake time in bed according to the data: sending notifications showing recommendations on helpful tips about sleeps, like ways to have a good sleep, 5 minutes meditation guide before sleep.

- Promoting Bellabeat membership features by highlighting personalized content which is personalized based on users' activity and sleep data:
  - For users in group A and B who are more active, one way to keep their high active level and engagement with Bellabeat app and products is to send reminders to take part in weekly, monthly challenges; reminders to set their personal workout goals; or reminders to share their achievements with others on social media platforms.
  - For users in group C who are less active, I mentioned the recommended activities above. Another suggestion would be to offer monthly online 1:1 consultation with a professional trainer as a valuable feature of Bellabeat membership. By giving the users the reliable support based on their personal need, Bellabeat could keep or increase their users' engagement to their products and services.

Finally, based on these recommendations, a clear implementation plan should be mapped out together with defining some KPIs for this plan. The KPIs could be:
- Users' engagement by considering the number of workout recorded, workout duration, number of seminars participated, etc.
- Changes in the users' minutes categories. A positive result would be the increase of the very active minutes compared to previous users' data.
- Number of new sign-ups for Bellabeat memberships
- Sales of other Bellabeat products







 



 
