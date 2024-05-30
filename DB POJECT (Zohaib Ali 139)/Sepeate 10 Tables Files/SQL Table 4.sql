CREATE DATABASE ECOM_PLATFORM;
USE ECOM_PLATFORM;

-- ORDER TABLE(HAVING ALL THE ORDER DETAILS)
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);



INSERT INTO Orders (UserID, OrderDate, TotalAmount) VALUES
(1, "2024-04-01", 1799.99),
(2, "2024-04-01", 1799.99),
(3, "2024-04-05", 99999.99);

SELECT COUNT(*) AS TotalOrders FROM Orders;
SELECT AVG(TotalAmount) AS AverageOrderAmount FROM Orders;


SELECT * FROM Products ORDER BY Price DESC LIMIT 1;
SELECT * FROM Orders ORDER BY TotalAmount DESC LIMIT 5;

SELECT COUNT(DISTINCT UserID) AS DistinctUsersWithOrders
FROM Orders;

SELECT u.Username, o.OrderDate, o.TotalAmount
FROM Users u
JOIN Orders o ON u.UserID = o.UserID
WHERE o.OrderDate = (
    SELECT MAX(o2.OrderDate)
    FROM Orders o2
    WHERE o2.UserID = o.UserID
);



SELECT c.CategoryName, SUM(od.Quantity * od.Price) AS TotalSales
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY c.CategoryName;

SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantitySold
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;
