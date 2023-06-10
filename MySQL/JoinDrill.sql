-- https://medium.com/@gozdebarin/mastering-sql-joins-a-comprehensive-guide-with-code-examples-9c5e88eff7e2

CREATE TABLE employees (
  employee_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  department_id INT
);

CREATE TABLE departments (
  department_id INT PRIMARY KEY,
  department_name VARCHAR(50)
);

INSERT INTO employees (employee_id, first_name, last_name, department_id)
VALUES
  (1, 'John', 'Doe', 1),
  (2, 'Jane', 'Smith', 1),
  (3, 'Michael', 'Johnson', 2),
  (4, 'Emily', 'Williams', NULL);

INSERT INTO departments (department_id, department_name)
VALUES
  (1, 'Sales'),
  (2, 'Marketing'),
  (3, 'Finance');
  
SELECT employee_id, first_name, last_name, department_name
FROM employees
JOIN departments
USING (department_id);

SELECT employee_id, first_name, last_name, department_name
FROM employees
LEFT JOIN departments
USING (department_id);

SELECT employee_id, first_name, last_name, department_name
FROM employees
RIGHT JOIN departments
USING (department_id);

SELECT employees.employee_id, employees.first_name, employees.last_name, departments.department_name
FROM employees
CROSS JOIN departments;

SELECT department_id
FROM employees
UNION
SELECT department_id
FROM departments;

SELECT department_id
FROM employees
INNER JOIN departments
USING (department_id);

SELECT department_id
FROM employees
UNION ALL
SELECT department_id
FROM departments;