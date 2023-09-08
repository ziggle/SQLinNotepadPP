-- https://medium.com/@gozdebarin/15-sql-string-functions-you-should-know-as-a-data-analyst-or-data-scientist-6b6936b74971
-- create
CREATE TABLE employee (
  title TEXT NOT NULL,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL,
  address TEXT NOT NULL,
  hire_date TEXT NOT NULL
);

-- insert
INSERT INTO EMPLOYEE VALUES ("Engineer","Mark","Biegert","108 6th Ave. NE, Osseo 55425","May 10, 2023");
INSERT INTO EMPLOYEE VALUES ("teacher","pat","biegert", "108 6th St. NE, Osseo 55425","May 10, 2023");
INSERT INTO EMPLOYEE VALUES ("machinist","tim","biegert","108 6th St. NE, Osseo 55425","May 10, 2023");
INSERT INTO EMPLOYEE VALUES ("scientist","Craig","biegert","108 6th St. NE, Osseo 55425","May 10 2023");

-- fetch 
SELECT * FROM employee;

-- Select all the full names of employees as "employee_fullname".
SELECT CONCAT(fname, " ", lname) AS employee_fullname
FROM employee;

-- Change St. to Street in the address field.
SELECT address, REPLACE(address, "St.", "Street") AS updated_address
FROM employee;

-- Select hiring date and time as two separate columns.
SELECT hire_date, RIGHT(hire_date, 10) AS hire_date_cleaned, RIGHT(hire_date, 8) AS hire_time_cleaned
FROM employee;

-- Select the hiring date without the time.
SELECT hire_date, LEFT(hire_date, 10) AS hire_date_cleaned
FROM employee;

-- Select all the full names of employees as "employee_fullname", then convert it to uppercase.
SELECT UPPER(CONCAT(fname, " ", lname)) AS employee_fullname
FROM employee;

-- Select all the full names of employees as "employee_fullname", then convert it to lowercase.
SELECT LOWER(CONCAT(fname, " ", lname)) AS employee_fullname
FROM employee;

-- Select all the book titles and their lengths.
SELECT title, LENGTH(title) AS title_length
FROM employee;

-- Select the first 10 characters of all book titles.
SELECT SUBSTRING(title, 1, 10) AS short_title
FROM employee;

-- Remove leading and trailing spaces from the address field.
SELECT TRIM(address) AS trimmed_address
FROM employee;

-- Reverse the characters in the title column.
SELECT REVERSE(title) AS reversed_title
FROM employee;