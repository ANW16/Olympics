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



WITH countires_one_gold_medal AS (SELECT SUM(gold) AS sum_gold
								FROM summer_games
								GROUP BY country_id, gold
								HAVING SUM(gold) = 1)
			
SELECT country, gold
FROM countires_one_gold_medal INNER JOIN countries
ON countires_one_gold_medal.country_id = countries.id


WITH summer_gold AS (SELECT COUNT(gold) AS summer_golds, country, country_id
FROM summer_games INNER JOIN countries ON summer_games.country_id = countries.id
GROUP BY country, country_id
ORDER BY summer_golds DESC)



SELECT summer_golds, COUNT(winter_games.bronze) + COUNT(winter_games.silver) + COUNT(winter_games.gold) AS total_winter_medals, country
FROM summer_gold INNER JOIN winter_games ON summer_gold.country_id = winter_games.country_id
WHERE summer_golds = 1
GROUP BY summer_golds, country
ORDER BY total_winter_medals DESC


WITH sg_medals AS (SELECT country_id, COUNT(silver) + COUNT(bronze) AS sg_total_medals, COUNT(gold) AS sg_gold
					FROM summer_games
					GROUP BY country_id
					ORDER BY sg_total_medals DESC),
					
wg_medals AS (SELECT country_id, COUNT(silver) + COUNT(bronze) AS wg_total_medals, COUNT(gold) AS wg_gold
					FROM winter_games
					GROUP BY country_id
					ORDER BY wg_total_medals DESC)
					
SELECT countries.country,wg_medals.country_id AS country_id, wg_total_medals + sg_total_medals AS total_medals
FROM sg_medals FULL JOIN wg_medals ON sg_medals.country_id = wg_medals.country_id
				INNER JOIN countries ON sg_medals.country_id = countries.id
WHERE sg_gold = 0 AND wg_gold = 0
ORDER BY total_medals DESC
*/

/*
WITH summer_points AS (SELECT country_id, (COUNT(gold) * 5) + (COUNT(silver) * 3) + (COUNT(bronze) * 1) AS sg_medal_points
						FROM summer_games
					   GROUP BY country_id
						ORDER BY sg_medal_points DESC),
						
winter_points AS (SELECT country_id, (COUNT(gold) * 5) + (COUNT(silver) * 3) + (COUNT(bronze) * 1) AS wg_medal_points
						FROM winter_games
				  GROUP BY country_id
						ORDER BY wg_medal_points DESC),
			 
both_games AS (SELECT COALESCE (summer_points.country_id, winter_points.country_id) AS country_id
				FROM winter_points FULL JOIN summer_points ON winter_points.country_id = summer_points.country_id)
				
SELECT (SELECT(SUM(wg_medal_points) + SUM(sg_medal_points))
	   FROM winter_points FULL JOIN summer_points ON winter_points.country_id = summer_points.country_id) / (SUM(CAST(pop_in_millions AS FLOAT)) / 10)
FROM both_games INNER JOIN country_stats ON both_games.country_id = country_stats.country_id
WHERE country_stats.year = '2016-01-01'
*/


						
					






