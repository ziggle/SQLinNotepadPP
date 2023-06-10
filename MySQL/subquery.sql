
-- create
CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE orders (
  customer_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  value INTEGER NOT NULL
);

CREATE TABLE employees (
  employee_id INTEGER PRIMARY KEY,
  employee_name TEXT NOT NULL,
  salary INTEGER NOT NULL
);

CREATE TABLE publishers (
  publisher_id INTEGER PRIMARY KEY,
  publisher_name TEXT NOT NULL,
  country TEXT NOT NULL
);

-- insert
INSERT INTO employees VALUES (1, 'Clark', 100);
INSERT INTO employees VALUES (2, 'Dave', 200);
INSERT INTO employees VALUES (3, 'Ava', 300);

INSERT INTO customers VALUES (1, 'Clark');
INSERT INTO customers VALUES (2, 'Dave');
INSERT INTO customers VALUES (3, 'Ava');

INSERT INTO orders VALUES (1, 1, 1);
INSERT INTO orders VALUES (2, 2, 2);
INSERT INTO orders VALUES (3, 3, 3);

INSERT INTO publishers VALUES (1, "A", "US");
INSERT INTO publishers VALUES (2, "B", "UK");
INSERT INTO publishers VALUES (3, "C", "IN");
-- fetch 

SELECT name
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders WHERE value > 1);

SELECT publisher_name
FROM publishers
WHERE publisher_id IN (SELECT publisher_id FROM publishers WHERE country="US");

SELECT publisher_id,publisher_name
FROM (SELECT publisher_id, publisher_name FROM publishers WHERE country='IN') AS temp_table;

SELECT employee_name, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);
