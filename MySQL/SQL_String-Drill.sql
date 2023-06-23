
-- create
CREATE TABLE employee (
  fname TEXT NOT NULL,
  lname TEXT NOT NULL,
  au_lname TEXT NOT NULL,
  au_fname TEXT NOT NULL,
  address TEXT NOT NULL,
  hire_date DATETIME NOT NULL
);

-- insert
INSERT INTO employee VALUES ('Mark','Biegert','White','Johnson','10932 Bigge Rd','1993-10-26 0:00:00');
INSERT INTO employee VALUES ('Craig','Biegert','Green','Marjorie','309 63rd St. #411','1993-2-21 0:20:00');
INSERT INTO employee VALUES ('Clarence', 'Lundgren','Carson','Cheryl','589 Darwin Ln.','1994-7-16 0:30:00');
INSERT INTO employee VALUES ('Bill','Hermann','OLeary','Michael','22 Cleveland Ave. #14','1993-7-16 0:30:00');
INSERT INTO employee VALUES ('Ray','Warner','Straight','Dean','5420 College Av.','1993-7-16 0:30:00');

-- Select all the full names of employees as "employee_fullname".

SELECT CONCAT(fname, " ", lname) AS employee_fullname
FROM employee;

-- Write a query to see the full names of authors (the same last name cannot appear more than once) and their addresses in a sentence. 

SELECT DISTINCT au_lname, au_fname, CONCAT(au_fname, " ", au_lname, "'s address is: ", address)  AS authors_address_info
FROM employee;

-- Change St. to Street in address field.

SELECT address, REPLACE(address, "St.", "Street") AS updated_address
FROM employee;

-- Change St. to Street, Av. to Avenue, Rd. to Road in address field.

SELECT address, REPLACE(REPLACE(REPLACE(address, "St.", "Street"), "Av.", "Avenue"),"Rd.", "Road") AS updated_address
FROM employee;

-- Select hiring date and time as 2 separate columns.

SELECT hire_date, LEFT(hire_date, 10) AS hire_date_cleaned, RIGHT(hire_date, 8) AS hire_time_cleaned
FROM employee;

-- Select all the full names of employees as "employee_fullname", then convert it to uppercase.

SELECT UPPER(CONCAT(fname, " ", lname)) AS employee_fullname
FROM employee;

-- Select all the full names of employees as "employee_fullname", then convert it to lowercase.

SELECT LOWER(CONCAT(fname, " ", lname)) AS employee_fullname
FROM employee;

-- Select all the book titles, and their lenghts.


SELECT lname, LENGTH(lname) AS title_lenght
FROM employee;

-- Select the first 10 characters of all book titles.

SELECT SUBSTRING(lname, 1, 5) AS short_title
FROM employee;

-- Remove leading and trailing spaces from address field.

SELECT TRIM(address) AS trimmed_address
FROM employee;

-- Reverse the characters in title column.

SELECT REVERSE(lname) AS reversed_title
FROM employee;