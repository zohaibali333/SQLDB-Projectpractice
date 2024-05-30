CREATE DATABASE ECOM_PLATFORM;
USE ECOM_PLATFORM;

-- PRODUCT SUPPLIER TABLE(ALL ABOUT PRODUCT SUPPLIERS)

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
