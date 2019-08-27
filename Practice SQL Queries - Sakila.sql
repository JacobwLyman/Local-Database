-- Functional form of a query --
-- SELECT > FROM > WHERE > GROUP BY > HAVING > ORDER BY;

-- Explore a table -- 
DESCRIBE actor;

-- Simple Queries --
select * from actor;
select first_name, last_name from actor;

-- # of rows in a table --
SELECT count(*) FROM actor;

-- Basic Calculations--
SELECT min(rental_duration) FROM film;
SELECT rating, AVG(rental_duration) FROM film GROUP BY rating;

-- Conditional Statements --
select first_name, last_name from actor where first_name = 'penelope';
select first_name, last_name from actor where first_name <> 'penelope';
select * from actor where actor_id < 5;
select * from actor where actor_id < 5 and actor_id > 3;
select * from actor where actor_id BETWEEN 3 and 5;
select * from actor where actor_id < 5 or first_name = 'penelope';
select * from actor where first_name = 'penelope' or first_name = 'nick' or first_name = 'ed';
select * from actor where first_name in ('penelope','nick','ed');
select * from actor where first_name not in ('penelope','nick','ed');
select * from actor where first_name like 'john%';
select * from address where district = 'Buenos Aires' and (address like '%EL%' or address like '%AL%'); /*IF you don't use paranthesis in this statement then it screws up the filtering. Give it a shot!*/
select first_name, last_name from actor where first_name = 'penelope' order by last_name DESC;
SELECT * FROM actor WHERE first_name <> 'penelope' ORDER BY last_name ASC;

-- Length() --
select first_name, length(first_name) nameLength from actor;

-- Intro to concat() --
select concat(first_name, ' ', last_name) fullname from actor;
select concat(first_name, ' ', last_name) fullname, length(concat(first_name, ' ', last_name)) nameLength from actor order by nameLength DESC;

-- Convert names into proper case --
SELECT concat(left(first_name,1), lower(right(first_name,length(first_name)-1))) firstName from actor;
/* Alternative query... */ SELECT concat(substring(first_name,1,1),lower(substring(first_name,2))) firstName from actor;

-- Use the trim function to avoid unwanted spaces in data --
SELECT * FROM actor WHERE trim(first_name)='grace';

-- Trim unnecessary text from data --
SELECT description , TRIM(LEADING 'A ' FROM description) description2 FROM film_text;

-- You can't use an alias in the WHERE clause | Also, AS is optional --
SELECT concat(first_name, ' ', last_name) AS fullname, length(concat(first_name, ' ', last_name)) AS nameLength 
FROM actor 
WHERE length(concat(first_name, ' ', last_name)) < 10
ORDER BY nameLength DESC;

-- Dates can be tricky, usually because of the variety of formats --
SELECT * FROM actor WHERE YEAR(last_update) = 2006; 
SELECT * FROM actor WHERE DATE(last_update) = '2006-02-15';
SELECT actor_id, first_name, last_name , DATE_FORMAT(last_update, '%m-%d-%Y') AS last_update FROM actor WHERE  DATE(last_update) = '2006-02-15'; 
SELECT actor_id, first_name, last_name , DATE_FORMAT(last_update, '%D %M %Y') AS last_update FROM actor;

-- How many rows belong to a specific district? --
SELECT district, count(*) totalAddresses FROM address WHERE address_id < 10 GROUP BY district ORDER BY totalAddresses DESC;

-- Filtering our groups. HAVING is like a WHERE clause for groups --
SELECT district, count(*) totalAddresses FROM address GROUP BY district HAVING count(district) > 8 ORDER BY totalAddresses DESC;
SELECT district, count(*) totalAddresses FROM address GROUP BY district HAVING totalAddresses > 8 ORDER BY totalAddresses DESC;