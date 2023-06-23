-- https://medium.com/@gozdebarin/the-ultimate-guide-to-data-cleaning-in-sql-56eaad2d97da
-- create
CREATE TABLE Exercise (
  title TEXT NOT NULL,
  price INT NOT NULL,
  pub_id INT NOT NULL
);

CREATE TABLE Publisher (
  pub_id INT NOT NULL,
  pname TEXT NOT NULL,
  country TEXT NOT NULL
);

-- insert
INSERT INTO Exercise VALUES ('AA', 10, 1);
INSERT INTO Exercise VALUES ('BA', 11, 2);
INSERT INTO Exercise VALUES ('C', 12, 3);
INSERT INTO Exercise VALUES ('D', 13, 4);
INSERT INTO Exercise VALUES ('E', 14, 5);
INSERT INTO Exercise VALUES ('F', 15, 6);
INSERT INTO Exercise VALUES ('F', 16, 7);

INSERT INTO Publisher VALUES (1,'Z', 'US');
INSERT INTO Publisher VALUES (2,'Y', 'US');
INSERT INTO Publisher VALUES (3,'X', 'US');
INSERT INTO Publisher VALUES (4,'W', 'US');
INSERT INTO Publisher VALUES (5,'V', 'UK');
INSERT INTO Publisher VALUES (6,'U', 'UK');
INSERT INTO Publisher VALUES (7,'T', 'UK');

-- Let's create a temporary table as 'titles_publishers'.

CREATE TEMPORARY TABLE titles_publishers
SELECT title, country
FROM Exercise
LEFT JOIN Publisher
USING (pub_id);

-- Let's retrieve all the data from the temporary table 'titles_publishers'.

SELECT *
FROM titles_publishers;

-- Display book's titles and publisher's country where title starts with 'The'.

SELECT *
FROM titles_publishers
WHERE title LIKE 'A%';

-- Display book's titles and publisher's country where title starts with 'The'.

SELECT Exercise.title, Publisher.country
FROM Publisher
LEFT JOIN Exercise
ON Exercise.pub_id = Publisher.pub_id;

-- Drop the table

DROP TABLE titles_publishers;