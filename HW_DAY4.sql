-- Week 5 - Thursday Questions

-- 1. Create a Stored Procedure that will insert a new film into the film table with the
-- following arguments: title, description, release_year, language_id, rental_duration,
-- rental_rate, length, replace_cost, rating

SELECT * 
FROM film f ;

CREATE OR REPLACE PROCEDURE  add_film(title VARCHAR, description VARCHAR, release_year YEAR, language_id INTEGER, rental_duration INTEGER, rental_rate NUMERIC(5,2), length INTEGER, replacement_cost NUMERIC (5,2), rating VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO film(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating)
	VALUES(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating::mpaa_rating);
END;
$$;


-- 2. Create a Stored Function that will take in a category_id and return the number of
-- films in that category

SELECT  c.category_id, NAME, COUNT(*) AS num_movies_in_cat
	FROM category c
	JOIN film_category fc 
	ON c.category_id = fc.category_id
	GROUP BY c.category_id 
	ORDER BY count(*) DESC;

CREATE OR REPLACE FUNCTION get_category_count (category_name VARCHAR)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
	DECLARE category_count INTEGER;
BEGIN 
	SELECT COUNT(*) INTO category_count
	FROM category c
	JOIN film_category fc 
	ON c.category_id = fc.category_id
	WHERE NAME = category_name;
	RETURN category_count;
END;
$$;

SELECT get_category_count('Action');

