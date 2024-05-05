--/1. Find the most popular Hacker News stories. This query will give us the top five stories with the highest scores.
SELECT title, score FROM hacker_news ORDER BY score DESC LIMIT 5;

--/2. Find the total score of all the stories.
SELECT SUM(score) AS total_score FROM hacker_news;

--/3. Find the individual users who have gotten combined scores of more than 200, and their combined scores.
SELECT user, SUM(score) AS total_score FROM hacker_news GROUP BY user HAVING total_score > 200;

--/4. Add these users’ scores together and divide by the total to get the percentage.
SELECT SUM(score) / (SELECT SUM(score) FROM hacker_news) AS percentage FROM hacker_news GROUP BY user HAVING SUM(score) > 200;

--/5. Find how many times has each offending user posted this link? "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
SELECT user, COUNT(*) AS num_rolls FROM hacker_news WHERE url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ' GROUP BY user;

--/6. Which of these sites feed Hacker News the most: GitHub, Medium, or New York Times?
SELECT 
    CASE
        WHEN url LIKE '%github.com%' THEN 'GitHub'
        WHEN url LIKE '%medium.com%' THEN 'Medium'
        WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
        ELSE 'Other'
    END AS Source,
    COUNT(*) AS Story_Count
FROM hacker_news
GROUP BY Source;

--/7.  What’s the best time of the day to post a story on Hacker News?
SELECT 
    strftime('%H', timestamp) AS Hour,
    ROUND(AVG(score), 2) AS Average_Score,
    COUNT(*) AS Story_Count
FROM hacker_news
WHERE timestamp IS NOT NULL
GROUP BY Hour
ORDER BY Average_Score DESC;