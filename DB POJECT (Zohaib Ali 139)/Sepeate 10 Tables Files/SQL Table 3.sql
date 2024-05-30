CREATE DATABASE ECOM_PLATFORM;
USE ECOM_PLATFORM;

-- PRODUCT TABLE(ALL THE DETAILS ABOUT PRODUCTS)
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT,
    Price DECIMAL(10, 2),
    Stock INT,
    Description TEXT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- product table(CONTAIN ALL THE PRODUCT/ITEMS DETAIL)
INSERT INTO Products (ProductName, CategoryID, Price, Stock, Description) VALUES
("Laptop", 1, 99999.99, 50, "High performance laptop"),
("Smartphone", 1, 59999.99, 100, "Latest model smartphone"),
("Novel", 2, 999.99, 200, "Bestselling novel"),
("T-shirt", 3, 1599.99, 150, "Comfortable cotton t-shirt");


SELECT p.* FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = "Electronics";

SELECT p.* FROM Products p
JOIN ProductSuppliers ps ON p.ProductID = ps.ProductID
JOIN Suppliers s ON ps.SupplierID = s.SupplierID
WHERE s.SupplierName = "TechSupplier";

UPDATE Products
SET Stock = Stock + 10
WHERE ProductID = 1;

SELECT p.ProductName, s.SupplierName
FROM Products p
JOIN ProductSuppliers ps ON p.ProductID = ps.ProductID
JOIN Suppliers s ON ps.SupplierID = s.SupplierID;

SELECT p.ProductName, COUNT(od.ProductID) AS OrderCount
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY od.ProductID
ORDER BY OrderCount DESC;

SELECT p.ProductName, r.Rating, r.ReviewText
FROM Reviews r
JOIN Products p ON r.ProductID = p.ProductID
WHERE r.UserID = 1;

SELECT p.ProductName
FROM Products p
LEFT JOIN Reviews r ON p.ProductID = r.ProductID
WHERE r.ReviewID IS NULL;


SELECT p.ProductName
FROM Products p
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
WHERE od.OrderDetailID IS NULL;

SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantitySold
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;

SELECT p.ProductName, AVG(r.Rating) AS AverageRating
FROM Products p
JOIN Reviews r ON p.ProductID = r.ProductID
GROUP BY p.ProductName;

SELECT ProductName
FROM Products
WHERE Stock = 0;

SELECT DISTINCT s.SupplierName
FROM Suppliers s
JOIN ProductSuppliers ps ON s.SupplierID = ps.SupplierID
JOIN Products p ON ps.ProductID = p.ProductID
WHERE p.Price > 5000;

SELECT c.CategoryName, AVG(p.Price) AS AveragePrice
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName;

SELECT p.ProductName, s.SupplierName, s.ContactEmail, s.Phone
FROM Products p
JOIN ProductSuppliers ps ON p.ProductID = ps.ProductID
JOIN Suppliers s ON ps.SupplierID = s.SupplierID;

SELECT c.CategoryName, COUNT(p.ProductID) AS ProductsInStock
FROM Categories c
JOIN Products p ON c.CategoryID = c.CategoryID
WHERE p.Stock > 0
GROUP BY c.CategoryName;