SELECT * 
FROM world_life_expectancy;

SELECT Country, MIN(`Life expectancy`),MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`)-MIN(`Life expectancy`),1) as Life_incr_in_15yrs
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`)<>0
AND MAX(`Life expectancy`)<>0
ORDER BY Life_incr_in_15yrs DESC;

SELECT Year, round(AVG(`Life expectancy`),2) as Average_age
FROM world_life_expectancy
WHERE `Life expectancy`<>0
GROUP BY Year
ORDER BY Year
;

SELECT * 
FROM world_life_expectancy;

SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_exp, ROUND(AVG(GDP),2) AS gdp
FROM world_life_expectancy
GROUP BY Country
having ROUND(AVG(`Life expectancy`),1)<>0 AND ROUND(AVG(GDP),2)<>0
ORDER BY gdp ASC
;

SELECT 
SUM(CASE WHEN GDP>=1500 THEN 1 ELSE 0 END) as high_gdp_count,
AVG(CASE WHEN GDP>=1500 THEN `Life expectancy` ELSE NULL END) as high_gdp_life_expectancy,
SUM(CASE WHEN GDP<=1500 THEN 1 ELSE 0 END) as low_gdp_count,
AVG(CASE WHEN GDP<=1500 THEN `Life expectancy` ELSE NULL END) as low_gdp_life_expectancy
FROM world_life_expectancy;

SELECT Status, ROUND(AVG(`Life expectancy`),2) as avg_life
FROM world_life_expectancy
GROUP BY Status
;

SELECT Status, COUNT(DISTINCT Country)
FROM world_life_expectancy
GROUP BY Status
;

SELECT Country,
Year,
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) as Rolling_Total
FROM world_life_expectancy;