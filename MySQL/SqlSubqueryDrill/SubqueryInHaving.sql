
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
INSERT INTO Exercise VALUES (3, 30, 16, '1993-7-16 0:30:00');

-- fetch

SELECT stor_id, COUNT(stor_id) AS cz
FROM Exercise
GROUP BY stor_id
HAVING cz=(
SELECT MAX(cnt) AS mx
FROM (SELECT COUNT(stor_id) AS cnt FROM Exercise GROUP BY stor_id) AS mepps
)



