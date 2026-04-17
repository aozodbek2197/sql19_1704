-- 1-mashq
SELECT 
    w.id, 
    wp.age, 
    w.coins_needed, 
    w.power
FROM wands w
JOIN wands_property wp ON w.code = wp.code
WHERE wp.is_evil = 0
  AND w.coins_needed = (
      SELECT MIN(w2.coins_needed) 
      FROM wands w2 
      JOIN wands_property wp2 ON w2.code = wp2.code
      WHERE wp2.is_evil = 0 
        AND w2.power = w.power 
        AND wp2.age = wp.age
  )
ORDER BY w.power DESC, wp.age DESC;
-- 2-mashq
SELECT 
    c.contest_id,
    c.hacker_id,
    c.name,
    SUM(s.total_submissions) AS total_submissions,
    SUM(s.total_accepted_submissions) AS total_accepted_submissions,
    SUM(v.total_views) AS total_views,
    SUM(v.total_unique_views) AS total_unique_views
FROM contests c
JOIN colleges co ON c.contest_id = co.contest_id
JOIN challenges ch ON co.college_id = ch.college_id
LEFT JOIN submission_stats s ON ch.challenge_id = s.challenge_id
LEFT JOIN view_stats v ON ch.challenge_id = v.challenge_id
GROUP BY c.contest_id, c.hacker_id, c.name
HAVING SUM(s.total_submissions) > 0 
   OR SUM(s.total_accepted_submissions) > 0 
   OR SUM(v.total_views) > 0 
   OR SUM(v.total_unique_views) > 0
ORDER BY c.contest_id;
