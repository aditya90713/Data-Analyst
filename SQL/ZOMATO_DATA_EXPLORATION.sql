USE project;

-- Check Datatype of table
DESCRIBE ZomatoData1;

-- Check tables in all the databases
SELECT DISTINCT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS;
SELECT * FROM INFORMATION_SCHEMA.COLUMNS;

-- Checking for duplicate RestaurantID
SELECT RestaurantID, COUNT(RestaurantID) 
FROM ZomatoData1
GROUP BY RestaurantID
ORDER BY 2 DESC;

-- Removing unwanted rows
DELETE FROM ZomatoData1 
WHERE CountryCode IN (' Bar',' Grill',' Bakers & More"',' Chowringhee Lane"',' Grill & Bar"',' Chinese');

DELETE FROM ZomatoData1 
WHERE RestaurantID = '18306543';

-- Country Code column
SELECT A.CountryCode, B.COUNTRY
FROM ZomatoData1 A 
JOIN ZOMATO_COUNTRY B ON A.CountryCode = B.COUNTRYCODE;

ALTER TABLE ZomatoData1 ADD COUNTRY_NAME VARCHAR(50);

UPDATE ZomatoData1 
SET COUNTRY_NAME = B.COUNTRY
FROM ZomatoData1 A 
JOIN ZOMATO_COUNTRY B ON A.CountryCode = B.COUNTRYCODE;

-- City column
SELECT DISTINCT City 
FROM ZomatoData1 
WHERE CITY LIKE '%?%';

SELECT REPLACE(CITY, '?', 'i') 
FROM ZomatoData1 
WHERE CITY LIKE '%?%';

UPDATE ZomatoData1 
SET City = REPLACE(CITY, '?', 'i') 
WHERE CITY LIKE '%?%';

-- Encapsulation (Drop columns [Locality], [LocalityVerbose], [Address])
ALTER TABLE ZomatoData1 DROP COLUMN Locality, DROP COLUMN LocalityVerbose, DROP COLUMN Address;

-- Cuisines column
SELECT Cuisines, COUNT(Cuisines) 
FROM ZomatoData1
WHERE Cuisines IS NULL OR Cuisines = ' '
GROUP BY Cuisines
ORDER BY 2 DESC;

SELECT Cuisines, COUNT(Cuisines)
FROM ZomatoData1
GROUP BY Cuisines
ORDER BY 2 DESC;

-- Currency column
SELECT Currency, COUNT(Currency) 
FROM ZomatoData1
GROUP BY Currency
ORDER BY 2 DESC;

-- Yes/No columns (Drop column [Switch_to_order_menu])
ALTER TABLE ZomatoData1 DROP COLUMN Switch_to_order_menu;

-- Price range column
SELECT DISTINCT Price_range 
FROM ZomatoData1;

-- Votes column (Checking MIN, MAX, AVG of Vote column)
ALTER TABLE ZomatoData1 MODIFY COLUMN Votes INT;

SELECT MIN(CAST(Votes AS SIGNED)) AS MIN_VT, AVG(CAST(Votes AS SIGNED)) AS AVG_VT, MAX(CAST(Votes AS SIGNED)) AS MAX_VT
FROM ZomatoData1;

-- Cost column
ALTER TABLE ZomatoData1 MODIFY COLUMN Average_Cost_for_two FLOAT;

SELECT Currency, 
       MIN(CAST(Average_Cost_for_two AS SIGNED)) AS MIN_CST,
       AVG(CAST(Average_Cost_for_two AS SIGNED)) AS AVG_CST,
       MAX(CAST(Average_Cost_for_two AS SIGNED)) AS MAX_CST
FROM ZomatoData1
GROUP BY Currency;

-- Rating column
SELECT MIN(Rating) AS MIN_RATING,
       ROUND(AVG(CAST(Rating AS DECIMAL)), 1) AS AVG_RATING,
       MAX(Rating) AS MAX_RATING
FROM ZomatoData1;

ALTER TABLE ZomatoData1 MODIFY COLUMN Rating DECIMAL;

SELECT Rating 
FROM ZomatoData1 
WHERE Rating >= 4;

SELECT Rating,
       CASE
           WHEN Rating >= 1 AND Rating < 2.5 THEN 'POOR'
           WHEN Rating >= 2.5 AND Rating < 3.5 THEN 'GOOD'
           WHEN Rating >= 3.5 AND Rating < 4.5 THEN 'GREAT'
           WHEN Rating >= 4.5 THEN 'EXCELLENT'
       END AS RATE_CATEGORY
FROM ZomatoData1;

ALTER TABLE ZomatoData1 ADD RATE_CATEGORY VARCHAR(20);

UPDATE ZomatoData1 
SET RATE_CATEGORY = CASE
           WHEN Rating >= 1 AND Rating < 2.5 THEN 'POOR'
           WHEN Rating >= 2.5 AND Rating < 3.5 THEN 'GOOD'
           WHEN Rating >= 3.5 AND Rating < 4.5 THEN 'GREAT'
           WHEN Rating >= 4.5 THEN 'EXCELLENT'
       END;

SELECT * FROM ZomatoData1;
