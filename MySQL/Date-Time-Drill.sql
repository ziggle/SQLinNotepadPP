
-- create
CREATE TABLE Hiring (
  hire_date DATETIME NOT NULL
);

-- insert
INSERT INTO Hiring VALUES ('1993-10-26 0:00:00');
INSERT INTO Hiring VALUES ('1993-2-21 0:20:00');
INSERT INTO Hiring VALUES ('1994-7-16 0:30:00');
INSERT INTO Hiring VALUES ('1993-7-16 0:30:00');
INSERT INTO Hiring VALUES ('1993-7-16 0:30:00');
INSERT INTO Hiring VALUES ('1993-7-16 0:30:00');
INSERT INTO Hiring VALUES ('1993-7-17 0:30:00');

-- fetch

-- Extract the date from hire_date column.

SELECT DATE(hire_date), hire_date
FROM Hiring;

-- Extract the time and date from hire_date column.

SELECT TIME(hire_date), DATE(hire_date), hire_date
FROM Hiring;

-- Extract the year, month, day from hire_date column.

SELECT EXTRACT(YEAR FROM hire_date) as year, EXTRACT(MONTH FROM hire_date) as month, EXTRACT(DAY FROM hire_date) as day, hire_date
FROM Hiring;

-- Extract the year, month, day from hire_date column.

SELECT YEAR(hire_date) AS year, MONTH(hire_date) AS month, DAY(hire_date) AS day, hire_date
FROM Hiring;

-- Display the current date and time.

SELECT NOW(), CURRENT_DATE, CURRENT_TIME, CURDATE(), CURTIME();

-- Format: 01 Jan 2023

SELECT DATE_FORMAT(LEFT(hire_date, 10), "%d %b %Y") AS hiring_date_cleaned
FROM Hiring;

-- Format: 01 January 2023

SELECT DATE_FORMAT(RIGHT(hire_date, 20), "%d %M %Y") AS hiring_date_cleaned
FROM Hiring;

-- Find out how many YEARS an employee has worked there.

SELECT TIMESTAMPDIFF(YEAR, hire_date, CURRENT_DATE) AS employee_workingtime, hire_date
FROM Hiring
ORDER BY employee_workingtime DESC;

-- Find out how many MONTHS an employee has worked there.

SELECT TIMESTAMPDIFF(MONTH, hire_date, CURRENT_DATE) AS employee_workingtime, hire_date
FROM Hiring
ORDER BY employee_workingtime DESC;

-- Find out how many DAYS an employee has worked there.

SELECT DATEDIFF(CURRENT_DATE, hire_date) AS employee_workingtime, hire_date
FROM Hiring
ORDER BY employee_workingtime DESC;

-- Subtract 2 months from hire_date column.

SELECT DATE_ADD(hire_date, INTERVAL -2 MONTH), hire_date
FROM Hiring;

-- Add 3 hours to hire_date column.

SELECT DATE_ADD(hire_date, INTERVAL 3 HOUR), hire_date
FROM Hiring;

-- Subtract 2 months from hire_date column.

SELECT DATE_SUB(hire_date, INTERVAL 2 MONTH), hire_date
FROM Hiring;

-- Subtract 3 hours from hire_date column.

SELECT STR_TO_DATE('May 17, 2022', '%M %d, %Y');

-- Output: 2023–05–17

SELECT STR_TO_DATE(hire_date, '"%d %M %Y')
FROM Hiring;

-- Output: 01 January 2023

-- Find out what day employees started to work there.

SELECT WEEKDAY(hire_date), hire_date
FROM Hiring;