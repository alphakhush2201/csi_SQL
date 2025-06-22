WITH DailyCounts AS (
    SELECT
        submission_date,
        hacker_id,
        COUNT(*) AS submissions_per_day
    FROM Submissions
    GROUP BY submission_date, hacker_id
),
TotalScores AS (
    SELECT
        hacker_id,
        SUM(score) AS total_score
    FROM Submissions
    GROUP BY hacker_id
),
RankedDailyTop AS (
    SELECT
        dc.submission_date,
        dc.hacker_id,
        RANK() OVER (
            PARTITION BY dc.submission_date
            ORDER BY dc.submissions_per_day DESC,
                     ts.total_score DESC,
                     dc.hacker_id ASC
        ) AS rnk
    FROM DailyCounts dc
    JOIN TotalScores ts ON dc.hacker_id = ts.hacker_id
)
SELECT
    r.submission_date,
    r.hacker_id,
    h.name
FROM RankedDailyTop r
JOIN Hackers h ON r.hacker_id = h.hacker_id
WHERE r.rnk = 1
ORDER BY r.submission_date;
