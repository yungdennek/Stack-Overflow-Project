WITH TaggedPosts AS (
  SELECT
    p.id AS post_id,
    t.tag_name AS trending_topic,
    EXTRACT(MONTH FROM p.creation_date) AS month,
    EXTRACT(YEAR FROM p.creation_date) AS year
  FROM
    `bigquery-public-data.stackoverflow.posts_questions` p
  JOIN
    UNNEST(SPLIT(p.tags, '|')) AS tag
  JOIN
    `bigquery-public-data.stackoverflow.tags` t
  ON
    t.tag_name = tag  -- Join on tag_name instead of id
)
SELECT
  trending_topic,
  COUNT(post_id) AS post_count,
  month,
  year
FROM
  TaggedPosts
GROUP BY
  trending_topic,
  month,
  year
ORDER BY
  post_count DESC;