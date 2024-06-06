CREATE DATABASE ECOM_PLATFORM;
USE ECOM_PLATFORM;

CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE,
    Email VARCHAR(100) UNIQUE,
    Password VARCHAR(100),
    DateJoined DATE
);

INSERT INTO Users (Username, Email, Password, DateJoined) VALUES
("Zohaib Ali", "zohaib@example.com", "zohaib139", "2024-03-01"),
("Hitesh", "hitesh@example.com", "hitesh122", "2024-03-25"),
("Abdur Rauf", "rauf@example.com", "rauf255", "2024-04-01"),
("Babar Azam", "babar@example.com", "babar56", "2024-04-05");


SELECT u.* FROM Users u
LEFT JOIN Orders o ON u.UserID = o.UserID
WHERE o.OrderID IS NULL;

SELECT DISTINCT u.Username
FROM Users u
JOIN Reviews r ON u.UserID = r.UserID;


SELECT Username, Email, DateJoined
FROM Users
WHERE YEAR(DateJoined) = 2024;

SELECT u.Username, a.Street, a.City, a.State, a.ZipCode, a.Country
FROM Users u
JOIN Addresses a ON u.UserID = a.UserID;

SELECT u.Username, COUNT(w.WishlistID) AS WishlistCount
FROM Users u
JOIN Wishlists w ON u.UserID = w.UserID
GROUP BY u.Username
HAVING WishlistCount > 1;

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


CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT,
    Price DECIMAL(10, 2),
    Stock INT,
    Description TEXT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);


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

-- 15 Queries Completed

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

-- 30 Queries Completed

SELECT c.CategoryName, SUM(od.Quantity * od.Price) AS TotalSales
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY c.CategoryName;

SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantitySold
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;


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


CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(100),
    ContactEmail VARCHAR(100),
    Phone VARCHAR(15) 
);

INSERT INTO Suppliers (SupplierName, ContactEmail, Phone) VALUES
("TechSupplier", "techsupplier@gmail.com", "0123-456-789"),
("BookSupplier", "booksupplier@gmail.com", "234-567-8910"),
("ClothingSupplier", "clothingsupplier@gmail.com.com", "345-678-91011");

SELECT p.* FROM Products p
JOIN ProductSuppliers ps ON p.ProductID = ps.ProductID
JOIN Suppliers s ON ps.SupplierID = s.SupplierID
WHERE s.SupplierName = 'BookSupplier';

SELECT s.SupplierName
FROM Suppliers s
JOIN ProductSuppliers ps ON s.SupplierID = ps.SupplierID
WHERE ps.ProductID = 3;


CREATE TABLE ProductSuppliers (
    ProductSupplierID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    SupplierID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);
INSERT INTO ProductSuppliers (ProductID, SupplierID) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3);

SELECT p.* FROM Products p
JOIN ProductSuppliers ps ON p.ProductID = ps.ProductID
JOIN Suppliers s ON ps.SupplierID = s.SupplierID
WHERE s.SupplierName = "ClothingSupplier";


SELECT s.SupplierName
FROM Suppliers s
JOIN ProductSuppliers ps ON s.SupplierID = ps.SupplierID
WHERE ps.ProductID = 4;


CREATE TABLE Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    UserID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewText TEXT,
    ReviewDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

INSERT INTO Reviews (ProductID, UserID, Rating, ReviewText, ReviewDate) VALUES
(4, 1, 4, "Good quality.", "2024-04-05"),
(4, 2, 5, "Nice shirt.", "2024-04-07"),
(1, 3, 5, "Excellent laptop.", "2024-04-09");

SELECT * FROM Reviews ORDER BY ReviewDate DESC LIMIT 10;
SELECT p.ProductName, r.Rating, r.ReviewText
FROM Reviews r
JOIN Products p ON r.ProductID = p.ProductID
WHERE r.UserID = 1;


SELECT r.UserID, COUNT(r.ReviewID) AS ReviewCount
FROM Reviews r
GROUP BY r.UserID
HAVING ReviewCount > 1;


CREATE TABLE Wishlists (
    WishlistID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    ProductID INT,
    DateAdded DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID));
    

INSERT INTO Wishlists (UserID, ProductID, DateAdded) VALUES
(1, 3, "2024-04-05"),
(2, 2, "2024-04-12"),
(3, 4,"2024-04-23");

SELECT u.Username, COUNT(w.WishlistID) AS WishlistCount
FROM Users u
JOIN Wishlists w ON u.UserID = w.UserID
GROUP BY u.Username
HAVING WishlistCount = 1;

CREATE TABLE Addresses (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    Street VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    Country VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

INSERT INTO Addresses (UserID, Street, City, State, ZipCode, Country) VALUES
(1, '123 Block A', 'Karachi', 'Sindh', '10001', 'Pakistan'),
(2, '456 Block B', 'Karachi', 'Sindh', '10002', 'Pakistan'),
(3, '123 Block C', 'Lahore', 'Punjab', '10003', 'Pakistan');

SELECT u.Username, a.Street, a.City, a.State, a.ZipCode, a.Country, p.ProductName
FROM Users u
JOIN Orders o ON u.UserID = o.UserID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Addresses a ON u.UserID = a.UserID;

-- 45 Queries Completed