CREATE DATABASE ECOM_PLATFORM;
USE ECOM_PLATFORM;

CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

INSERT INTO Categories (CategoryName) VALUES
("Electronics"),
("Books"),
("Clothing");

SELECT p.* FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = "Electronics";


SELECT c.CategoryName, p.ProductName
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID;

SELECT c.CategoryName, COUNT(p.ProductID) AS ProductCount
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName;

SELECT c.CategoryName, SUM(od.Quantity * od.Price) AS TotalSales
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY c.CategoryName;

