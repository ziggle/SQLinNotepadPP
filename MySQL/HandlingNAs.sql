-- https://medium.com/@gozdebarin/sql-data-cleaning-for-handling-missing-values-and-duplicates-d833a6727fc
-- create
CREATE TABLE EMPLOYEE (
  order_id INTEGER,
  order_status TEXT NOT NULL,
  order_delivered_carrier_date DATE 
);

-- insert
INSERT INTO EMPLOYEE VALUES (1, 'unavailable', '2023-01-01');
INSERT INTO EMPLOYEE VALUES (2, 'cancelled',   '2023-01-01');
INSERT INTO EMPLOYEE VALUES (2, 'cancelled',   '2023-01-01');
INSERT INTO EMPLOYEE VALUES (3, 'pending',             NULL);
INSERT INTO EMPLOYEE VALUES (4, 'delivered',   '2023-01-01');
INSERT INTO EMPLOYEE VALUES (5, 'delivered',   '2023-01-01');
INSERT INTO EMPLOYEE VALUES (6, 'delivered',           NULL);
INSERT INTO EMPLOYEE VALUES (7, 'delivered',           NULL);
INSERT INTO EMPLOYEE VALUES (2, 'cancelled',   '2023-01-01');

-- fetch       
SELECT order_id, order_status, order_delivered_carrier_date
FROM EMPLOYEE
WHERE order_delivered_carrier_date IS NULL;


SELECT order_id, order_status, COALESCE(order_delivered_carrier_date, 'Unknown') AS filled_column
FROM EMPLOYEE;

SELECT order_id, COUNT(*)
FROM EMPLOYEE
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Select all the unique emails.

SELECT DISTINCT order_id
FROM EMPLOYEE;

-- Delete all the duplicate emails, keeping only one unique email with the smallest id.

DELETE p1
FROM EMPLOYEE as p1, EMPLOYEE as p2
WHERE p1.order_id = p2.order_id;

-- Delete all the duplicate emails, keeping only one unique email with the smallest id.
 CREATE TABLE Test (SELECT * FROM EMPLOYEE);
 SELECT * FROM Test;