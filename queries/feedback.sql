SELECT
    id AS comment_id,
    text AS feedback_text,
    creation_date AS feedback_date,
    user_id,
    user_display_name,
    CASE
        WHEN LOWER(text) LIKE '%bug%' THEN 'Bug Report'
        WHEN LOWER(text) LIKE '%suggestion%' THEN 'Feature Request'
        ELSE 'General Feedback'
    END AS feedback_type
FROM
    `bigquery-public-data.stackoverflow.comments`
WHERE
    LOWER(text) LIKE '%bug%' OR LOWER(text) LIKE '%suggestion%' OR LOWER(text) LIKE '%feedback%';