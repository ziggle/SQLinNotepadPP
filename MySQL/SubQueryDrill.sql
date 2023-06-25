
-- create
CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name TEXT NOT NULL
);

-- create
CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id  INTEGER NOT NULL,
  order_amount   INTEGER NOT NULL
);

-- create
CREATE TABLE employees (
  employee_id INTEGER PRIMARY KEY,
  employee_name  TEXT NOT NULL,
  department_id INTEGER NOT NULL
);

-- create
CREATE TABLE departments (
  department_id INTEGER PRIMARY KEY,
  department_name  TEXT NOT NULL
);
-- insert
INSERT INTO departments VALUES (1, 'Eng');
INSERT INTO departments VALUES (2, 'Sales');
INSERT INTO departments VALUES (3, 'Eng');

-- insert
INSERT INTO employees VALUES (1, 'Clark',1);
INSERT INTO employees VALUES (2, 'Dave',2);
INSERT INTO employees VALUES (3, 'Ava',3);

-- insert
INSERT INTO customers VALUES (1, 'Clark');
INSERT INTO customers VALUES (2, 'Dave');
INSERT INTO customers VALUES (3, 'Ava');

-- insert
INSERT INTO orders VALUES (1, 1, 10);
INSERT INTO orders VALUES (2, 2, 11);
INSERT INTO orders VALUES (3, 3, 12);

-- fetch 
-- Display the order ids and the average order amount for all of the orders.

SELECT customer_id, (SELECT AVG(order_amount) FROM orders) AS average_order_amount
FROM customers;

-- Find customers with transaction value greater than 1000.

SELECT customer_name
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders WHERE order_amount > 10);

-- Display the UNIQUE department id's from both employees and departments tables.

SELECT department_id
FROM employees
UNION
SELECT department_id
FROM departments;

-- Display the MATCHING department id's from employees and departments tables.

SELECT department_id
FROM employees
INNER JOIN departments
USING (department_id);

SELECT department_id
FROM employees
UNION ALL
SELECT department_id
FROM departments;

SELECT employee_id, employee_name, department_name
FROM employees
JOIN departments
USING (department_id);

SELECT customer_id, order_id, order_amount,
       SUM(order_amount) OVER (PARTITION BY customer_id ORDER BY customer_id) AS RunningTotal
FROM orders;

-- Let's create a temporary table as 'titles_publishers'.

CREATE TEMPORARY TABLE emps
SELECT employee_name, department_name
FROM employees
LEFT JOIN departments
USING(department_id);
-- Let's retrieve all the data from the temporary table 'titles_publishers'.

SELECT *
FROM emps;

CREATE TABLE TempTable (
    employee_name TEXT NOT NULL,
    department_name TEXT NOT NULL
);

INSERT INTO TempTable
SELECT employee_name, department_name
FROM emps;

SELECT * FROM TempTable;

