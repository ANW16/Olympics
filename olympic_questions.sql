/*
SELECT COUNT (DISTINCT athlete_id), country
FROM (summer_games INNER JOIN athletes ON summer_games.athlete_id = athletes.id
INNER JOIN countries ON country_id = countries.id)
GROUP BY country


SELECT COUNT(DISTINCT summer_games.event) AS summer, COUNT(DISTINCT winter_games.event) AS winter, summer_games.country_id
FROM (summer_games INNER JOIN winter_games ON summer_games.country_id = winter_games.country_id)
GROUP BY summer_games.country_id
*/

SELECT *
FROM country_stats
WHERE year = 

