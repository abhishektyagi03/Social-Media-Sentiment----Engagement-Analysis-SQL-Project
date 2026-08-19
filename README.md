# 📱 Social Media Sentiment & Engagement Analysis — SQL Project

## 📌 Project Overview

This project focuses on analyzing **social media posts using SQL** to extract meaningful insights related to platform performance, user engagement, sentiment, emotions, toxicity, trending topics, spam, and user influence.

The project demonstrates practical SQL skills including **data exploration, filtering, aggregation, grouping, sorting, conditional analysis, subqueries, string analysis, date analysis, and business-focused analytical queries**.

---

## 🎯 Project Objective

The main objective of this project is to analyze social media data and answer important business questions such as:

* Which platform generates the highest engagement?
* What are the most engaging posts?
* Which sentiment has the highest engagement?
* Which topics are most frequently discussed?
* How does verification status affect engagement?
* Which day of the week has the highest average engagement?
* What percentage of posts are trending topics?
* Which emotions are most common in posts?
* Which posts have high toxicity or spam scores?
* What factors are associated with higher engagement?

---

## 📊 Dataset

The dataset contains social media post, user, engagement, sentiment, emotion, and content-moderation information. The fields analyzed in this project are:

| Column                 | Description                                  |
| ---------------------- | -------------------------------------------- |
| `platform`             | Social media platform                        |
| `post_id`              | Unique post identifier                       |
| `user_id`              | Unique user identifier                       |
| `username`             | Username of the post author                  |
| `user_verified`        | Whether the user is verified                 |
| `user_followers_count` | Number of followers of the user              |
| `user_location`        | User location                                |
| `post_text`            | Text content of the post                     |
| `language`             | Language of the post                         |
| `hashtags`             | Hashtags used in the post                    |
| `mentions`             | Mentioned users or accounts                  |
| `post_length`          | Length of the post text                      |
| `like_count`           | Number of likes                              |
| `comment_count`        | Number of comments                           |
| `share_count`          | Number of shares                             |
| `engagement_score`     | Overall engagement score                     |
| `posted_datetime`      | Date and time of publication                 |
| `day_of_week`          | Day on which the post was published          |
| `is_trending_topic`    | Whether the post relates to a trending topic |
| `topic_category`       | Category of the discussed topic              |
| `sentiment_label`      | Sentiment classification                     |
| `sentiment_score`      | Numerical sentiment score                    |
| `emotion_label`        | Detected emotion                             |
| `toxicity_score`       | Toxicity score of the post                   |
| `sarcasm_detected`     | Whether sarcasm was detected                 |
| `spam_flag`            | Whether the post is flagged as spam          |
| `data_source_url`      | Source URL of the data                       |

---

## 🛠️ Technologies Used

* **SQL**
* **MySQL**
* **GitHub**
* **CSV Dataset**

---

## 🧠 SQL Concepts Used

This project covers several important SQL concepts:

* `SELECT`
* `WHERE`
* `ORDER BY`
* `GROUP BY`
* `HAVING`
* `DISTINCT`
* `CASE`
* Aggregate Functions

  * `COUNT()`
  * `SUM()`
  * `AVG()`
  * `MIN()`
  * `MAX()`
* Date and Time Functions
* String Functions
* Text Analysis
* Conditional Filtering
* Subqueries
* Data Aggregation
* Sentiment Analysis
* Engagement Analysis
* Trend Analysis
* Business Intelligence Queries

---

## 🔍 Key Business Questions

### Q1. What is the total number of posts on each platform?

### Q2. Which platform has the highest average engagement score?

### Q3. What are the top 10 posts by engagement score?

### Q4. Which sentiment label receives the highest average engagement?

### Q5. Which topic category has the highest number of posts?

### Q6. Do verified users receive higher engagement than non-verified users?

### Q7. Which day of the week has the highest average engagement?

### Q8. What percentage of posts are trending topics?

### Q9. Which emotion appears most frequently in posts?

### Q10. Which posts have high toxicity, spam, or sarcasm indicators?

---

## 📈 Example SQL Analysis

### Total Posts by Platform

```sql
SELECT
    platform,
    COUNT(*) AS total_posts
FROM social_media_analysis
GROUP BY platform
ORDER BY total_posts DESC;
```

### Average Engagement by Platform

```sql
SELECT
    platform,
    AVG(engagement_score) AS average_engagement
FROM social_media_analysis
GROUP BY platform
ORDER BY average_engagement DESC;
```

### Engagement by Sentiment

```sql
SELECT
    sentiment_label,
    AVG(engagement_score) AS average_engagement
FROM social_media_analysis
GROUP BY sentiment_label
ORDER BY average_engagement DESC;
```

### Top 10 Posts by Engagement

```sql
SELECT
    platform,
    post_id,
    username,
    like_count,
    comment_count,
    share_count,
    engagement_score
FROM social_media_analysis
ORDER BY engagement_score DESC
LIMIT 10;
```

### Engagement by Verification Status

```sql
SELECT
    user_verified,
    AVG(engagement_score) AS average_engagement
FROM social_media_analysis
GROUP BY user_verified
ORDER BY average_engagement DESC;
```

---

## 📂 Project Structure

```text
Social-Media-Sentiment-SQL-Analysis/
│
├── social_media_sentiment_analysis.sql
├── social_media_sentiment_dataset.csv
├── README.md
└── project_screenshot.png
```

---

## 💡 Key Insights

The analysis can help identify:

* Overall social media engagement performance.
* Top-performing platforms and posts.
* Sentiment and emotion patterns.
* Trending topic performance.
* Engagement differences between verified and non-verified users.
* User influence based on follower count.
* Toxic, sarcastic, and spam content patterns.
* Best-performing posting days.

---

## 🚀 How to Run the Project

### Step 1 — Download the Repository

Clone the repository using:

```bash
git clone https://github.com/your-username/Social-Media-Sentiment-SQL-Analysis.git
```

### Step 2 — Open MySQL

Open **MySQL Workbench** or another MySQL-compatible SQL environment.

### Step 3 — Create/Select Database

```sql
CREATE DATABASE ecommerce_analysis;

USE ecommerce_analysis;
```

### Step 4 — Create the Table

Run the table creation query from:

```text
social_media_sentiment_analysis.sql
```

### Step 5 — Import Dataset

Import the social media sentiment CSV dataset into the table:

```text
social_media_analysis
```

### Step 6 — Run Analysis Queries

Execute the analytical SQL queries provided in the SQL file.

---

## 📌 Project Highlights

✅ Real-world social media data analysis
✅ 10+ business-focused SQL questions
✅ Platform and engagement analysis
✅ Sentiment and emotion analysis
✅ Trending topic analysis
✅ Toxicity, sarcasm, and spam analysis
✅ User verification and follower analysis
✅ Conditional categorization using `CASE`
✅ Beginner-to-intermediate SQL concepts
✅ Portfolio-ready Data Analyst project

---

## 👨‍💻 Author

### Abhishek Tyagi

**MCA | Aspiring Data Analyst / Data Scientist**

Skills:

`SQL` `Python` `Excel` `Power BI` `Pandas` `NumPy` `Data Analysis`

---

## ⭐ If You Like This Project

If you find this project useful, consider giving the repository a **⭐ Star** on GitHub.

---

## 📜 License

This project is created for **educational and portfolio purposes**.
