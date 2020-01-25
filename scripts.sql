-- The database has two table: app_store_apps and play_store_apps

-- 1.	What are the name of the tables in the database?

SELECT table_name 
FROM information_schema.tables
WHERE table_schema = 'public';

-- 2.	How many apps are in the Apple app store? How many apps are in the Android app store?

SELECT COUNT (*)
FROM app_store_apps	Result: 7197

SELECT COUNT (*)
FROM play_store_apps	Result: 10840

-- 3.	What are the different prices in the app store?  What are the different prices in the Android app store?

SELECT DISTINCT price
FROM app_store_apps
ORDER BY price

SELECT DISTINCT price
FROM play_store_apps
ORDER BY price

-- 4.	What are some different content ratings in the app store? And play store apps?
SELECT DISTINCT content_rating
FROM app_store_apps
ORDER BY content_rating

SELECT DISTINCT content_rating
FROM play_store_apps
ORDER BY content_rating

-- 5.	How many apps in the app store have a price of 0 and rating of 5?

SELECT COUNT (DISTINCT name)
FROM app_store_apps
WHERE price = 0 AND rating = 5;

-- 6.	How many different genres are there in the app store?

SELECT DISTINCT primary_genre
FROM app_store_apps

-- 7.	What are some free apps that have a rating of 5 in the Apple app store? 

SELECT name, price, rating
    FROM app_store_apps
    WHERE price = (SELECT MIN(price) FROM app_store_apps)
	AND rating = 5
	ORDER BY rating


-- 8.	What are some of the lowest priced apps from the Android app store with a rating of 5? 

SELECT name, price, rating
    FROM play_store_apps
    WHERE price = (SELECT MIN(price) FROM play_store_apps)
     AND rating = 5
     ORDER BY rating

-- 9.	What are some apps from the Apple app store that are priced at either 0.99 cents or lower and have a rating of 5? 

SELECT *
FROM app_store_apps
WHERE rating = 5.0 
AND primary_genre LIKE 'Education'
AND price <=0.99
ORDER BY rating DESC
LIMIT 100;


-- 10.	Which apps from the app_store_apps have a price of 0 or 0.99 cent and are rated 5?

SELECT *
FROM app_store_apps
WHERE (price = 0 OR price = 0.99)
AND rating = 5

-- 11.	How many apps are in both app stores?

SELECT COUNT (apple.name)
FROM app_store_apps AS apple
LEFT JOIN play_store_apps AS android
ONE android.name = apple.name

-- 12.	What are the prices of the apps in both tables?

SELECT p.price, p.name AS play_store, a.price, a.name AS app_store
FROM play_store_apps AS p
INNER JOIN app_store_apps AS a
ON p.name = a.name
ORDER BY a.price DESC;

-- 13.	What are the names of apps that have duplicates in the app store?

SELECT name, COUNT(name) 
FROM app_store_apps
GROUP BY name
HAVING COUNT(name) > 1


-- 14.	How many apps are duplicated in the play store?

SELECT COUNT(name) - COUNT(DISTINCT name) AS duplicate_apps
FROM play_store_apps;
