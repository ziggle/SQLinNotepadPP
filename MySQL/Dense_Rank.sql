-- First of all, let's create a table called “employees”:
CREATE TABLE employees (
  id integer,
  first_name varchar(20),
  last_name varchar(20),
  position varchar(20),
  salary varchar(20)
);


-- Let's add some values to our table employees:
INSERT INTO employees VALUES 
(1, 'James', 'Flynn', 'Manager', 62000),
(2, 'Ajay', 'Ramoray', 'Manager', 62000),
(3, 'Ayse', 'Berry', 'Senior Manager', 98000),
(4, 'Gail', 'Edward', 'Associate', 50000),
(5, 'Maria', 'Frey', 'Senior Associate', 82000),
(6, 'Daniel', 'Lordman', 'Associate', 73000),
(7, 'Ferehsteh', 'Asmus', 'Senior Associate', 92000),
(8, 'Kalpana', 'Kumar', 'Manager', 86000),
(9, 'Peter', 'Ashley', 'Associate', 73000),
(10, 'Joanna', 'White', 'Senior Associate', 54000),
(11, 'Drake', 'Valley', 'Senior Associate', 54000);

-- Here’s how our employees table looks like
SELECT *
FROM employees;

SELECT * , DENSE_RANK() OVER(ORDER BY salary DESC) AS employee_rank
FROM employees;

SELECT * , DENSE_RANK() OVER(PARTITION BY position ORDER BY salary DESC) AS employee_rank
FROM employees;
