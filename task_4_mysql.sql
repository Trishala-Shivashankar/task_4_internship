SELECT * FROM file_updated limit 5;

SELECT * FROM file_updated
WHERE Location = 'Chicago';

SELECT * FROM file_updated
WHERE Coupon_Status = 'Used';

SELECT *, (Online_Spend + Offline_Spend) AS Total_Spend
FROM file_updated
ORDER BY Total_Spend DESC
LIMIT 10;

-- Total quantity sold per product category
SELECT Product_Category, SUM(Quantity) AS Total_Sold
FROM file_updated
GROUP BY Product_Category;

-- Average spend per city
SELECT Location, AVG(Online_Spend + Offline_Spend) AS Avg_Total_Spend
FROM file_updated
GROUP BY Location;

-- Customers who spent more than the average
SELECT CustomerID, SUM(Online_Spend + Offline_Spend) AS Total_Spent
FROM file_updated
GROUP BY CustomerID
HAVING Total_Spent > (
    SELECT AVG(Online_Spend + Offline_Spend)
    FROM file_updated
);

CREATE VIEW high_spenders AS
SELECT CustomerID, SUM(Online_Spend + Offline_Spend) AS Total_Spend
FROM file_updated
GROUP BY CustomerID
HAVING Total_Spend > 5000;
SELECT * FROM high_spenders;

CREATE INDEX idx_customer_id ON file_updated (CustomerID);
CREATE INDEX idx_location ON file_updated (Location);

-- Gender-based spending analysis
SELECT Gender,
       AVG(Online_Spend) AS Avg_Online,
       AVG(Offline_Spend) AS Avg_Offline
FROM file_updated
GROUP BY Gender;

SELECT 
    a.CustomerID, a.Transaction_ID, b.First_Name, b.Email
FROM 
    file_updated AS a
JOIN 
    customer_dataset AS b
ON 
    a.CustomerID = b.CustomerID;






