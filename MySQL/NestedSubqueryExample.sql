-- https://medium.com/@abdelilah.moulida/3-challenging-problems-of-working-with-nested-subqueries-in-sql-22e19173a13d
CREATE TABLE sales (
  sale_id INT PRIMARY KEY,
  customer INT NOT NULL,
  department TEXT NOT NULL,
  employee INT NOT NULL,
  sale INT NOT NULL
);

CREATE TABLE orders (
  customer_id INT NOT NULL,
  item INT NOT NULL,
  value INT NOT NULL
);

INSERT INTO sales VALUES (1,1,'Clothes',11,200);
INSERT INTO sales VALUES (2,2,'Sports',12,300);
INSERT INTO sales VALUES (3,2,'Jewelry',13,1200);
INSERT INTO sales VALUES (8,2,'Toys',13,12500);
INSERT INTO sales VALUES (4,3,'Sports',14,300);
INSERT INTO sales VALUES (5,3,'Jewelry',15,400);
INSERT INTO sales VALUES (6,4,'Clothes',16, 900);
INSERT INTO sales VALUES (7, 5,'Jewelry',15,400);

SELECT department, employee, sale
FROM sales AS s
WHERE sale = (
  SELECT MAX(sale) FROM sales WHERE department = s.department
);

--

SELECT customer, COUNT(*) AS num_orders, (
  SELECT SUM(sale) FROM sales WHERE customer = s.customer
) AS total_value 
FROM sales AS s
GROUP BY customer;

SELECT sum(sale) AS total_sale,department,
       ROW_NUMBER() OVER (ORDER BY SUM(sale) DESC) AS r1
FROM sales
GROUP BY department;

SELECT department, total_sale
FROM (SELECT sum(sale) AS total_sale,department,
       ROW_NUMBER() OVER (ORDER BY SUM(sale) DESC) AS r1
FROM sales
GROUP BY department) AS sub
WHERE r1<=2;

--

WITH ranked_items AS (
SELECT sum(sale) AS total_sale,department,
       ROW_NUMBER() OVER (ORDER BY SUM(sale) DESC) AS r1
FROM sales
GROUP BY department
)

SELECT department, total_sale
FROM ranked_items
WHERE r1<=2;
