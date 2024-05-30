CREATE DATABASE ECOM_PLATFORM;
USE ECOM_PLATFORM;

-- ORDER DETAILS (DETAILS ABOUT THE ORDER)
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES
(1, 4, 1, 1599.99),
(2, 4, 1, 1599.99),
(3, 1, 1, 99999.99);

SELECT SUM(od.Quantity * od.Price) AS TotalSales
FROM OrderDetails od
WHERE od.ProductID = 1;

SELECT p.ProductName, COUNT(od.ProductID) AS OrderCount
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY od.ProductID
ORDER BY OrderCount DESC;

SELECT p.ProductName
FROM Products p
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
WHERE od.OrderDetailID IS NULL;

SELECT c.CategoryName, SUM(od.Quantity * od.Price) AS TotalSales
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY c.CategoryName;