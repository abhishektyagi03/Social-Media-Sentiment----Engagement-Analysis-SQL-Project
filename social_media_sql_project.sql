-- Q01. Total number of posts
SELECT COUNT(*) AS total_posts
FROM social_media_posts;

-- Q02. Check duplicate post IDs
SELECT post_id, COUNT(*) AS duplicate_count
FROM social_media_posts
GROUP BY post_id
HAVING COUNT(*) > 1;

-- Q03. Check NULL values in important fields
SELECT
    SUM(post_id IS NULL) AS null_post_id,
    SUM(platform IS NULL) AS null_platform,
    SUM(user_id IS NULL) AS null_user_id,
    SUM(sentiment_label IS NULL) AS null_sentiment,
    SUM(topic_category IS NULL) AS null_topic,
    SUM(posted_datetime IS NULL) AS null_datetime
FROM social_media_posts;

-- Q04. Find the date range of the dataset
SELECT
    MIN(posted_datetime) AS first_post,
    MAX(posted_datetime) AS last_post
FROM social_media_posts;

-- ================================================================
-- BASIC BUSINESS QUESTIONS
-- ================================================================

-- Q05. How many posts are available on each platform?
SELECT platform, COUNT(*) AS total_posts
FROM social_media_posts
GROUP BY platform
ORDER BY total_posts DESC;

-- Q06. What is the distribution of sentiment?
SELECT sentiment_label, COUNT(*) AS total_posts,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM social_media_posts
GROUP BY sentiment_label
ORDER BY total_posts DESC;

-- Q07. Which topic categories have the most posts?
SELECT topic_category, COUNT(*) AS total_posts
FROM social_media_posts
GROUP BY topic_category
ORDER BY total_posts DESC;

-- Q08. What is the average engagement score by platform?
SELECT platform,
       ROUND(AVG(engagement_score), 3) AS avg_engagement_score
FROM social_media_posts
GROUP BY platform
ORDER BY avg_engagement_score DESC;

-- Q09. Which platform generates the most likes, comments and shares?
SELECT platform,
       SUM(like_count) AS total_likes,
       SUM(comment_count) AS total_comments,
       SUM(share_count) AS total_shares,
       SUM(like_count + comment_count + share_count) AS total_interactions
FROM social_media_posts
GROUP BY platform
ORDER BY total_interactions DESC;

-- Q10. What is the average sentiment score by platform?
SELECT platform,
       ROUND(AVG(sentiment_score), 3) AS avg_sentiment_score
FROM social_media_posts
GROUP BY platform
ORDER BY avg_sentiment_score DESC;
-- Q11. What are the top 10 posts by total interactions?
SELECT post_id, platform, topic_category, sentiment_label,
       like_count, comment_count, share_count,
       (like_count + comment_count + share_count) AS total_interactions
FROM social_media_posts
ORDER BY total_interactions DESC
LIMIT 10;

-- Q12. What are the top 10 users by follower count?
SELECT user_id, username, user_location, user_followers_count
FROM social_media_posts
ORDER BY user_followers_count DESC
LIMIT 10;

-- Q13. How many verified vs unverified users posted?
SELECT user_verified, COUNT(*) AS total_posts
FROM social_media_posts
GROUP BY user_verified
ORDER BY total_posts DESC;

-- Q14. Which locations have the highest number of posts?
SELECT user_location, COUNT(*) AS total_posts
FROM social_media_posts
GROUP BY user_location
ORDER BY total_posts DESC;

-- ================================================================
-- SENTIMENT & EMOTION ANALYSIS
-- ================================================================

-- Q15. Which platform has the highest positive sentiment rate?
SELECT platform,
       COUNT(*) AS total_posts,
       SUM(sentiment_label = 'Positive') AS positive_posts,
       ROUND(100.0 * SUM(sentiment_label = 'Positive') / COUNT(*), 2) AS positive_rate
FROM social_media_posts
GROUP BY platform
ORDER BY positive_rate DESC;

-- Q16. Which platform has the highest negative sentiment rate?
SELECT platform,
       ROUND(100.0 * SUM(sentiment_label = 'Negative') / COUNT(*), 2) AS negative_rate
FROM social_media_posts
GROUP BY platform
ORDER BY negative_rate DESC;

-- Q17. What is the sentiment distribution by topic?
SELECT topic_category, sentiment_label, COUNT(*) AS total_posts
FROM social_media_posts
GROUP BY topic_category, sentiment_label
ORDER BY topic_category, total_posts DESC;

-- Q18. Which emotions are most common?
SELECT emotion_label, COUNT(*) AS total_posts
FROM social_media_posts
GROUP BY emotion_label
ORDER BY total_posts DESC;

-- Q19. Which emotion has the highest average toxicity?
SELECT emotion_label,
       ROUND(AVG(toxicity_score), 3) AS avg_toxicity
FROM social_media_posts
GROUP BY emotion_label
ORDER BY avg_toxicity DESC;

-- Q20. Find highly negative posts with high toxicity
SELECT post_id, platform, topic_category, sentiment_score,
       toxicity_score, emotion_label, post_text
FROM social_media_posts
WHERE sentiment_label = 'Negative'
  AND toxicity_score >= 0.70
ORDER BY toxicity_score DESC, sentiment_score ASC
LIMIT 20;

-- Q21. Compare sentiment of verified and unverified users
SELECT user_verified, sentiment_label, COUNT(*) AS total_posts
FROM social_media_posts
GROUP BY user_verified, sentiment_label
ORDER BY user_verified, total_posts DESC;

-- ================================================================
-- ENGAGEMENT ANALYSIS
-- ================================================================

-- Q22. Which topics have the highest average engagement?
SELECT topic_category,
       ROUND(AVG(engagement_score), 3) AS avg_engagement,
       ROUND(AVG(like_count), 0) AS avg_likes,
       ROUND(AVG(comment_count), 0) AS avg_comments,
       ROUND(AVG(share_count), 0) AS avg_shares
FROM social_media_posts
GROUP BY topic_category
ORDER BY avg_engagement DESC;

-- Q23. Does sentiment influence engagement?
SELECT sentiment_label,
       ROUND(AVG(engagement_score), 3) AS avg_engagement,
       ROUND(AVG(like_count + comment_count + share_count), 0) AS avg_interactions
FROM social_media_posts
GROUP BY sentiment_label
ORDER BY avg_engagement DESC;

-- Q24. Find posts with engagement score above the overall average
SELECT post_id, platform, topic_category, engagement_score
FROM social_media_posts
WHERE engagement_score > (SELECT AVG(engagement_score) FROM social_media_posts)
ORDER BY engagement_score DESC;

-- Q25. Which day of the week has the highest average engagement?
SELECT day_of_week,
       COUNT(*) AS total_posts,
       ROUND(AVG(engagement_score), 3) AS avg_engagement
FROM social_media_posts
GROUP BY day_of_week
ORDER BY avg_engagement DESC;

-- Q26. Does follower count relate to engagement?
SELECT
    CASE
        WHEN user_followers_count < 100000 THEN 'Under 100K'
        WHEN user_followers_count < 250000 THEN '100K-249K'
        WHEN user_followers_count < 400000 THEN '250K-399K'
        ELSE '400K+'
    END AS follower_group,
    COUNT(*) AS total_posts,
    ROUND(AVG(engagement_score), 3) AS avg_engagement
FROM social_media_posts
GROUP BY follower_group
ORDER BY avg_engagement DESC;

-- ================================================================
-- AI / TRENDING TOPIC ANALYSIS
-- ================================================================

-- Q27. How many posts are marked as trending?
SELECT is_trending_topic, COUNT(*) AS total_posts
FROM social_media_posts
GROUP BY is_trending_topic
ORDER BY total_posts DESC;

-- Q28. Which topics have the highest trending rate?
SELECT topic_category,
       COUNT(*) AS total_posts,
       SUM(is_trending_topic) AS trending_posts,
       ROUND(100.0 * SUM(is_trending_topic) / COUNT(*), 2) AS trending_rate
FROM social_media_posts
GROUP BY topic_category
ORDER BY trending_rate DESC;

-- Q29. How many posts mention AI in hashtags?
SELECT COUNT(*) AS ai_hashtag_posts
FROM social_media_posts
WHERE LOWER(COALESCE(hashtags, '')) LIKE '%ai%';

-- Q30. Which platforms have the most AI-related hashtag posts?
SELECT platform,
       COUNT(*) AS ai_related_posts
FROM social_media_posts
WHERE LOWER(COALESCE(hashtags, '')) LIKE '%ai%'
GROUP BY platform
ORDER BY ai_related_posts DESC;

-- Q31. What is the sentiment of AI-related posts?
SELECT sentiment_label, COUNT(*) AS total_posts
FROM social_media_posts
WHERE LOWER(COALESCE(hashtags, '')) LIKE '%ai%'
GROUP BY sentiment_label
ORDER BY total_posts DESC;

-- ================================================================
-- TOXICITY, SPAM & RISK ANALYSIS
-- ================================================================

-- Q32. What is the spam rate by platform?
SELECT platform,
       COUNT(*) AS total_posts,
       SUM(spam_flag) AS spam_posts,
       ROUND(100.0 * SUM(spam_flag) / COUNT(*), 2) AS spam_rate
FROM social_media_posts
GROUP BY platform
ORDER BY spam_rate DESC;

-- Q33. What is the toxicity rate by platform?
SELECT platform,
       ROUND(AVG(toxicity_score), 3) AS avg_toxicity,
       SUM(toxicity_score >= 0.70) AS high_toxicity_posts
FROM social_media_posts
GROUP BY platform
ORDER BY avg_toxicity DESC;

-- Q34. Compare spam vs non-spam engagement
SELECT spam_flag,
       COUNT(*) AS total_posts,
       ROUND(AVG(engagement_score), 3) AS avg_engagement,
       ROUND(AVG(toxicity_score), 3) AS avg_toxicity
FROM social_media_posts
GROUP BY spam_flag
ORDER BY spam_flag DESC;

-- Q35. Does sarcasm appear more often in negative posts?
SELECT sentiment_label,
       SUM(sarcasm_detected) AS sarcastic_posts,
       COUNT(*) AS total_posts,
       ROUND(100.0 * SUM(sarcasm_detected) / COUNT(*), 2) AS sarcasm_rate
FROM social_media_posts
GROUP BY sentiment_label
ORDER BY sarcasm_rate DESC;

-- Q36. Find high-risk posts using multiple indicators
SELECT post_id, platform, sentiment_label, toxicity_score,
       spam_flag, sarcasm_detected, is_trending_topic,
       engagement_score, post_text
FROM social_media_posts
WHERE toxicity_score >= 0.80
   OR spam_flag = 1
   OR (sentiment_label = 'Negative' AND sarcasm_detected = 1)
ORDER BY toxicity_score DESC, engagement_score DESC
LIMIT 50;

-- ================================================================
-- DATE / TIME TREND ANALYSIS
-- ================================================================

-- Q37. How many posts were created each month?
SELECT DATE_FORMAT(posted_datetime, '%Y-%m') AS month,
       COUNT(*) AS total_posts
FROM social_media_posts
GROUP BY DATE_FORMAT(posted_datetime, '%Y-%m')
ORDER BY month;

-- Q38. Which month has the highest average engagement?
SELECT DATE_FORMAT(posted_datetime, '%Y-%m') AS month,
       ROUND(AVG(engagement_score), 3) AS avg_engagement
FROM social_media_posts
GROUP BY DATE_FORMAT(posted_datetime, '%Y-%m')
ORDER BY avg_engagement DESC
LIMIT 10;

-- Q39. Year-over-year post volume
SELECT YEAR(posted_datetime) AS year,
       COUNT(*) AS total_posts
FROM social_media_posts
GROUP BY YEAR(posted_datetime)
ORDER BY year;

-- Q40. Platform ranking within each topic by average engagement
WITH platform_topic AS (
    SELECT topic_category, platform,
           AVG(engagement_score) AS avg_engagement
    FROM social_media_posts
    GROUP BY topic_category, platform
),
ranked AS (
    SELECT *,
           DENSE_RANK() OVER (
               PARTITION BY topic_category
               ORDER BY avg_engagement DESC
           ) AS platform_rank
    FROM platform_topic
)
SELECT topic_category, platform,
       ROUND(avg_engagement, 3) AS avg_engagement,
       platform_rank
FROM ranked
ORDER BY topic_category, platform_rank;