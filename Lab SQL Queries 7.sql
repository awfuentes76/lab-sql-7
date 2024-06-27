-- In the table actor, which are the actors whose last names are not repeated? 
-- For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd.
-- These three actors have the same last name. So we do not want to include this last name in our output. 
-- Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.

SELECT first_name, last_name, COUNT(*) OVER (PARTITION BY last_name) as conteo
FROM sakila.actor
-- GROUP BY last_name
-- HAVING COUNT(last_name) = 1 
ORDER BY last_name;

SELECT first_name, last_name
FROM actor
WHERE last_name IN (
    SELECT last_name 
    FROM actor 
    GROUP BY last_name 
    HAVING COUNT(last_name) = 1
);

-- Which last names appear more than once?
-- We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once

SELECT first_name, last_name
FROM actor
WHERE last_name IN (
    SELECT last_name 
    FROM actor 
    GROUP BY last_name 
    HAVING COUNT(last_name) > 1
);
-- otra manera: 
WITH result AS (
	SELECT first_name, last_name, COUNT(*) OVER (PARTITION BY last_name) AS counter
	FROM sakila.actor
)
SELECT first_name, last_name
FROM result
WHERE counter=1;


-- Using the rental table, find out how many rentals were processed by each empSELECT staff_id, COUNT(*) AS rental_count

SELECT staff_id, COUNT(*) AS rental_count
FROM rental
GROUP BY staff_id;

-- Using the film table, find out how many films were released each year.

SELECT COUNT(film_id), release_year
FROM sakila.film
GROUP BY release_year;

-- Using the film table, find out for each rating how many films were there.

SELECT COUNT(film_id), rating
FROM sakila.film
GROUP BY rating;

-- What is the mean length of the film for each rating type. Round off the average lengths to two decimal places

SELECT rating, ROUND(AVG(length), 2) AS average_length
FROM sakila.film
GROUP BY rating;

-- Which kind of movies (rating) have a mean duration of more than two hours?

SELECT rating, ROUND(AVG(length), 2) AS average_length
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120;




