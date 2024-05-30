CREATE DATABASE ECOM_PLATFORM;
USE ECOM_PLATFORM;

-- SUPPLIERS TABLE(HAVING DETAILS OF SUPPLIERS WHICH SUPPLY THE PRODUCTS)
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