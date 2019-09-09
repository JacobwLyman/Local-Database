-- Functional form of a query --
-- SELECT > FROM > WHERE > GROUP BY > HAVING > ORDER BY;

-- Explore a table -- 
DESCRIBE actor;

-- Simple Queries --
SELECT 
  * 
FROM actor;

SELECT 
  first_name
  , last_name 
FROM actor;

-- # of rows in a table --
SELECT 
  count(*) 
FROM actor;

-- Basic Calculations--
SELECT 
  min(rental_duration) 
FROM film;

SELECT 
  rating
  , AVG(rental_duration)
FROM film 
GROUP BY rating;

-- Conditional Statements --
SELECT 
  first_name
  , last_name 
FROM actor 
WHERE first_name = 'penelope';

SELECT 
  first_name
  , last_name 
FROM actor 
WHERE first_name <> 'penelope';

SELECT 
  * 
FROM actor 
WHERE actor_id < 5;

SELECT 
  * 
FROM actor 
WHERE actor_id < 5 
  AND actor_id > 3;

SELECT 
  * 
FROM actor 
WHERE actor_id BETWEEN 3 AND 5;

SELECT 
  * 
FROM actor 
WHERE actor_id < 5 
  OR first_name = 'penelope';

SELECT
  * 
FROM actor 
WHERE first_name = 'penelope' 
  OR first_name = 'nick' 
  OR first_name = 'ed';

SELECT 
  * 
FROM actor 
WHERE first_name IN ('penelope','nick','ed');

SELECT 
  * 
FROM actor 
WHERE first_name NOT IN ('penelope','nick','ed');

SELECT 
  * 
FROM actor 
WHERE first_name LIKE 'john%';

SELECT 
  * 
FROM address 
WHERE district = 'Buenos Aires' 
  AND (address LIKE '%EL%' OR address LIKE '%AL%'); 
/*IF you don't use paranthesis in this statement then it screws up the filtering. Give it a shot!*/

SELECT 
  first_name
  , last_name 
FROM actor 
WHERE first_name = 'penelope' 
ORDER BY last_name DESC;

SELECT 
* 
FROM actor 
WHERE first_name <> 'penelope' 
ORDER BY last_name ASC;

-- Length() --
SELECT 
first_name
, length(first_name) AS nameLength 
FROM actor;

-- Intro to concat() --
SELECT 
  concat(first_name, ' ', last_name) AS fullname 
FROM actor;

SELECT
  concat(first_name, ' ', last_name) AS fullname
  , length(concat(first_name, ' ', last_name)) AS nameLength 
FROM actor 
ORDER BY nameLength DESC;

-- Convert names into proper case --
SELECT 
  concat(left(first_name,1)
  , lower(right(first_name,length(first_name)-1))) firstName 
FROM actor;
/* Alternative query... */ SELECT concat(substring(first_name,1,1),lower(substring(first_name,2))) firstName from actor;

-- Use the trim function to avoid unwanted spaces in data --
SELECT 
  * 
FROM actor 
WHERE trim(first_name)='grace';

-- Trim unnecessary text from data --
SELECT 
  description 
  , TRIM(LEADING 'A ' FROM description) description2 
FROM film_text;

-- You can't use an alias in the WHERE clause | Also, AS is optional --
SELECT 
  concat(first_name, ' ', last_name) AS fullname
  , length(concat(first_name, ' ', last_name)) AS nameLength 
FROM actor 
WHERE length(concat(first_name, ' ', last_name)) < 10
ORDER BY nameLength DESC;

-- Dates can be tricky, usually because of the variety of formats --
SELECT 
  * 
FROM actor 
WHERE YEAR(last_update) = 2006; 

SELECT 
  * 
FROM actor 
WHERE DATE(last_update) = '2006-02-15';

SELECT 
  actor_id
  , first_name
  , last_name 
  , DATE_FORMAT(last_update, '%m-%d-%Y') AS last_update 
FROM actor 
WHERE  DATE(last_update) = '2006-02-15';

SELECT 
  actor_id
  , first_name
  , last_name 
  , DATE_FORMAT(last_update, '%D %M %Y') AS last_update 
FROM actor;

-- How many rows belong to a specific district? --
SELECT 
  district
  , count(*) totalAddresses 
FROM address 
WHERE address_id < 10 
GROUP BY district 
ORDER BY totalAddresses DESC;

-- Filtering our groups. HAVING is like a WHERE clause for groups --
SELECT 
  district
  , count(*) AS totalAddresses 
FROM address 
GROUP BY district 
HAVING count(district) > 8 
ORDER BY totalAddresses DESC;

SELECT 
  district
  , count(*) totalAddresses 
FROM address 
GROUP BY district 
HAVING totalAddresses > 8 
ORDER BY totalAddresses DESC;
