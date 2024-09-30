Select * from world_life_expectancy;

Select Country,Year,CONCAT(Country,Year),COUNT(CONCAT(Country,Year))
from world_life_expectancy
GROUP BY Country,Year,CONCAT(Country,Year)
HAVING COUNT(CONCAT(Country,Year))>1;

SELECT * from (
   SELECT Row_ID, 
   CONCAT(Country, Year), 
   ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS row_num
   from world_life_expectancy
) as row_table
where row_num>1
;

DELETE from world_life_expectancy
WHERE 
     Row_ID IN (
     SELECT Row_ID
     FROM (
     SELECT Row_ID, 
   CONCAT(Country, Year), 
   ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS row_num
   from world_life_expectancy
) as row_table
where row_num>1
);

SELECT *
FROM world_life_expectancy
WHERE Status='';

SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE Status <>'';

UPDATE world_life_expectancy
SET Status= 'Developing'
WHERE Country IN (
SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE Status = 'Developing'
);

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
on t1.Country=t2.Country
SET t1.Status='Developing'
WHERE t1.Status =''
AND t2.Status <> ''
AND t2.Status='Developing';

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
on t1.Country=t2.Country
SET t1.Status='Developed'
WHERE t1.Status =''
AND t2.Status <> ''
AND t2.Status='Developed';

SELECT t1.Country, t1.Year, t1.`Life expectancy`,
       t2.Country, t2.Year, t2.`Life expectancy`,
       t3.Country,t3.Year, t3.`Life expectancy`,
       ROUND((t2.`Life expectancy`+t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.Country=t2.Country AND t1.Year=t2.Year-1
JOIN world_life_expectancy t3
ON t1.Country=t3.Country AND t1.Year=t3.Year+1
WHERE t1.`Life expectancy`=''
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.Country=t2.Country AND t1.Year=t2.Year-1
JOIN world_life_expectancy t3
ON t1.Country=t3.Country AND t1.Year=t3.Year+1
SET t1.`Life expectancy`=ROUND((t2.`Life expectancy`+t3.`Life expectancy`)/2,1)
where t1.`Life expectancy`='' ;












