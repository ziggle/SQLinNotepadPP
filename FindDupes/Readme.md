https://towardsdatascience.com/2-best-sql-tricks-to-find-duplicate-values-in-a-table-1197618dcc74

SELECT OrderID, Quantity, Product_Category, COUNT(*) AS occurrences FROM THIS GROUP BY OrderID,Quantity, Product_Category HAVING COUNT(*)>1
SELECT OrderID FROM THIS GROUP BY OrderID HAVING COUNT(*)>1
SELECT OrderID, Quantity, Product_Category, COUNT(*) AS occurrences FROM THIS GROUP BY OrderID,Quantity, Product_Category