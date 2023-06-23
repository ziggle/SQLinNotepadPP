-- https://medium.com/@gozdebarin/the-ultimate-guide-to-data-cleaning-in-sql-56eaad2d97da
-- create
CREATE TABLE Exercise (
  order_id INTEGER,
  customer_id INTEGER,
  email TEXT,
  person TEXT
);

-- insert
INSERT INTO Exercise VALUES (0, 10, ' m@jim.com ', 'mepps');
INSERT INTO Exercise VALUES (1, 1, 'm@jim.com', null);
INSERT INTO Exercise VALUES (3, 74, null           , 'grep');
INSERT INTO Exercise VALUES (3, 10, 'm@biff.com', 'sfafd');
INSERT INTO Exercise VALUES (3, 30, 'm@jim.com', 'ddd');
INSERT INTO Exercise VALUES (3, 40,  null          , 'aaaa');
INSERT INTO Exercise VALUES (4, 40, ' m@mark.com ', 'bb');

-- find missing values

SELECT order_id, customer_id, email
FROM Exercise
WHERE email IS NULL;

-- COALESCE function

SELECT order_id, COALESCE(email, 'Unknown') AS filled_column
FROM Exercise;

-- Check for duplicate rows

SELECT order_id, customer_id, COUNT(*)
FROM Exercise
GROUP BY order_id, customer_id
HAVING COUNT(*) > 1;

-- Eliminate dupes

SELECT DISTINCT email
FROM Exercise;

-- I have never done a delete

DELETE p1
FROM Exercise as p1, Exercise as p2
WHERE p1.email = p2.email AND p1.order_id > p2.order_id;

SELECT *
FROM Exercise;

-- Standardizing

SELECT order_id, UPPER(person) AS uppercase_column
FROM Exercise;

-- Change St. to Street in address field.

SELECT email, REPLACE(email, "jim", "ziggle") AS updated_address
FROM Exercise;

-- Select the first 10 characters of all book titles.

SELECT SUBSTRING(email, 1, 3) AS short_email
FROM Exercise;

-- Remove leading and trailing spaces from address field.

SELECT TRIM(email) AS trimmed_address
FROM Exercise;

-- case

SELECT SUM(order_id),
CASE
WHEN order_id >= 2 THEN "high sales"
WHEN 1 <= order_id < 2 THEN "medium sales"
WHEN order_id < 1 THEN "low sales"
END AS "sales_category"
FROM Exercise
GROUP BY order_id;


-- Update the email of the customer with customer_id 1.
UPDATE Exercise
SET email = 'john.doe@example.com'
WHERE customer_id = 40;

SELECT TRIM(email) AS trimmed_address
FROM Exercise;