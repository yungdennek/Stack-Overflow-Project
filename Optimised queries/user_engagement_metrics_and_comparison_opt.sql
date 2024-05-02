WITH user_metrics AS (
    SELECT
        u.id AS user_id,
        u.display_name,
        u.reputation,
        u.up_votes,
        u.down_votes,
        u.views,
        COUNT(b.id) AS badge_count
    FROM
        `bigquery-public-data.stackoverflow.users` u
    LEFT JOIN
        `bigquery-public-data.stackoverflow.badges` b
    ON
        u.id = b.user_id
    WHERE
        u.display_name = 'YourLoggedInUserName'
    GROUP BY
        u.id, u.display_name, u.reputation, u.up_votes, u.down_votes, u.views
),
top_users AS (
    SELECT
        u.id AS user_id,
        u.display_name,
        u.reputation,
        u.up_votes,
        u.down_votes,
        u.views,
        COUNT(b.id) AS badge_count
    FROM
        `bigquery-public-data.stackoverflow.users` u
    LEFT JOIN
        `bigquery-public-data.stackoverflow.badges` b
    ON
        u.id = b.user_id
    GROUP BY
        u.id, u.display_name, u.reputation, u.up_votes, u.down_votes, u.views
    ORDER BY
        u.reputation DESC
    LIMIT
        20
)
SELECT
    'Logged-in User' AS user_type,
    user_id,
    display_name,
    reputation,
    up_votes,
    down_votes,
    views,
    badge_count
FROM
    user_metrics

UNION ALL

SELECT
    'Top User' AS user_type,
    user_id,
    display_name,
    reputation,
    up_votes,
    down_votes,
    views,
    badge_count
FROM
    top_users;