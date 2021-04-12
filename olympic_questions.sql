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


WITH tall_athletes AS (SELECT *
						FROM athletes
						WHERE CAST(height AS decimal) >
						(SELECT AVG(CAST(height AS decimal))FROM athletes) AND age > 30 AND gender = 'F') 	
SELECT AVG(weight)
FROM tall_athletes


WITH total_medals AS (SELECT COUNT(bronze) + COUNT(silver) + COUNT(gold) AS medals, country_id
FROM winter_games
GROUP BY country_id
ORDER BY medals)

SELECT medals, country_stats.country_id, country, CAST(pop_in_millions AS FLOAT), year, medals/CAST(pop_in_millions AS FLOAT) AS medals_per_capita
FROM (total_medals INNER JOIN country_stats ON total_medals.country_id = country_stats.country_id INNER JOIN countries ON country_stats.country_id=countries.id)
WHERE pop_in_millions IS NOT NULL AND year = '2016-01-01'
GROUP BY country_stats.country_id, total_medals.medals, country_stats.pop_in_millions,country_stats.year, countries.country
ORDER BY medals_per_capita DESC

*/





WITH summer_gold_one AS (SELECT countries.country, COUNT(summer_games.gold) AS total_gold, COUNT(winter_games.bronze) + COUNT(winter_games.silver) + COUNT(winter_games.gold) AS total_winter_medals
							FROM summer_games INNER JOIN winter_games 
						 	ON summer_games.country_id = winter_games.country_id
							INNER JOIN countries 
						 	ON summer_games.country_id = countries.id
							GROUP BY countries.country, summer_games.gold)
							
SELECT *
FROM summer_gold_one
WHERE total_gold = 1
ORDER BY total_winter_medals DESC


/*
WITH countires_one_gold_medal AS (SELECT SUM(gold) AS sum_gold
								FROM summer_games
								GROUP BY country_id, gold
								HAVING SUM(gold) = 1)
			
SELECT country, gold
FROM countires_one_gold_medal INNER JOIN countries
ON countires_one_gold_medal.country_id = countries.id

*/



