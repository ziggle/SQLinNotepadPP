-- https://medium.com/@gozdebarin/mastering-sql-aggregation-functions-a-comprehensive-guide-with-examples-7f1e33ef1018
-- create
CREATE TABLE titles (
  title_id INT PRIMARY KEY,
  pub_id INT NOT NULL,
  au_id INT NOT NULL,
  qty INT NOT NULL
);

CREATE TABLE stores (
  st_id INT NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE authors (
  au_id INT NOT NULL,
  name TEXT NOT NULL
);
								
INSERT INTO titles VALUES (1, 1,1,11);
INSERT INTO titles VALUES (2, 2,1,12);
INSERT INTO titles VALUES (3, 2,1,130);
INSERT INTO titles VALUES (4, 2,2,12);
INSERT INTO titles VALUES (5, 3,2,14);
INSERT INTO titles VALUES (6, 3,3,15);
INSERT INTO titles VALUES (7, 4,1,160);
INSERT INTO titles VALUES (8, 4,1,15);

INSERT INTO stores VALUES (1, "A");
INSERT INTO stores VALUES (2, "B");

INSERT INTO authors VALUES (1, "A");
INSERT INTO authors VALUES (2, "B");
INSERT INTO authors VALUES (3, "C");
INSERT INTO authors VALUES (4, "C");

SELECT COUNT(*) AS total_rows
FROM authors;

SELECT COUNT(DISTINCT au_id) AS number_of_authors
FROM authors;

-- Find out the total sales by quantity.

SELECT SUM(qty) AS sales_quantity
FROM titles;

SELECT COUNT(qty), AVG(qty) , SUM(qty)
FROM titles;

SELECT pub_id,  MIN(qty) AS minimum_price
FROM titles
GROUP BY pub_id;

SELECT pub_id, SUM(qty)
FROM titles
GROUP BY pub_id
WITH ROLLUP;

-- Find out the top 3 stores with the most sales.

SELECT st_id
FROM stores
GROUP BY st_id
ORDER BY st_id DESC
LIMIT 3;

