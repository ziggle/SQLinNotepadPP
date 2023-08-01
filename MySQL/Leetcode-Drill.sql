-- https://medium.com/@han.candice/leetcode-sql-question-answer-b0f113623723
-- create


CREATE TABLE Prices (
  product_id INTEGER NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  price INTEGER NOT NULL
);

INSERT INTO Prices VALUES (1,'2019-02-17','2019-02-28',5);
INSERT INTO Prices VALUES (1,'2019-03-01','2019-03-22',20);
INSERT INTO Prices VALUES (2,'2019-02-01','2019-02-20',15);
INSERT INTO Prices VALUES (2,'2019-02-21','2019-03-31',30);

CREATE TABLE UnitsSold (
  product_id INT NOT NULL,
  purchase_date DATE NOT NULL,
  units INT NOT NULL
);

INSERT INTO UnitsSold VALUES (1,"2019-02-25",100);
INSERT INTO UnitsSold VALUES (1,"2019-03-01",15);
INSERT INTO UnitsSold VALUES (2,"2019-02-10",200);
INSERT INTO UnitsSold VALUES (2,"2019-03-22",30);



SELECT p.product_id, 
        round(sum(p.price*u.units)*1.0/sum(u.units),2) as average_price
FROM Prices p
LEFT JOIN UnitsSold u
ON p.product_id = u.product_id
AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP By p.product_id

-- Explanation: 
-- Average selling price = Total Price of Product / Number of products sold.
-- Average selling price for product 1 = ((100 * 5) + (15 * 20)) / 115 = 6.96
-- Average selling price for product 2 = ((200 * 15) + (30 * 30)) / 230 = 16.96
