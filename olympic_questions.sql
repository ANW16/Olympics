/*
SELECT COUNT (DISTINCT athlete_id), country
FROM (summer_games INNER JOIN athletes ON summer_games.athlete_id = athletes.id
INNER JOIN countries ON country_id = countries.id)
GROUP BY country


SELECT COUNT(DISTINCT summer_games.event) AS summer, COUNT(DISTINCT winter_games.event) AS winter, summer_games.country_id
FROM (summer_games INNER JOIN winter_games ON summer_games.country_id = winter_games.country_id)
GROUP BY summer_games.country_id


SELECT DISTINCT(c1.country_id), c1.year, c1.pop_in_millions, c2.year, c2.pop_in_millions
FROM country_stats AS c1 INNER JOIN country_stats AS c2
USING (country_id)
WHERE c1.year = '2000-01-01' AND c2.year = '2006-01-01'
AND c2.pop_in_millions < c1.pop_in_millions


SELECT DISTINCT (country_id), CAST(pop_in_millions AS FLOAT),
	CASE WHEN CAST(pop_in_millions AS FLOAT) < 50.0 THEN 'low pop'
		WHEN CAST(pop_in_millions AS FLOAT) > 50.0 AND CAST(pop_in_millions AS FLOAT)<= 200.0 THEN 'medium pop'
		ELSE 'high pop' END AS pop_level
FROM country_stats
WHERE country_stats.year = '2016-01-01' AND country_stats.pop_in_millions IS NOT null
ORDER BY (CAST (pop_in_millions AS FLOAT))



SELECT DISTINCT(TRIM(country)), gdp, year
FROM (country_stats INNER JOIN countries ON country_stats.country_id =countries.id)
WHERE country_stats.gdp > 
	(SELECT AVG(country_stats.gdp) FROM country_stats)
AND year = '2004-01-01'
*/	

SELECT AVG(height) AS avg_height, gender, height, age, name
FROM athletes
GROUP BY gender, height, age, name






