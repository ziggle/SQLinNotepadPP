
-- create
CREATE TABLE Exercise (
  stor_id INTEGER NOT NULL,
  qty INTEGER NOT NULL,
  price TEXT NOT NULL,
  ord_date DATETIME NOT NULL
);

-- insert
INSERT INTO Exercise VALUES (1, 10, 26, '1993-10-26 0:00:00');
INSERT INTO Exercise VALUES (2, 25, 21, '1993-2-21 0:20:00');
INSERT INTO Exercise VALUES (3, 74, 16, '1994-7-16 0:30:00');
INSERT INTO Exercise VALUES (3, 10, 16, '1993-7-16 0:30:00');

-- fetch 
SELECT stor_id, SUM(CASE WHEN YEAR(ord_date) = 1993 THEN qty ELSE 0 END) AS total_sales
FROM Exercise
GROUP BY stor_id;
