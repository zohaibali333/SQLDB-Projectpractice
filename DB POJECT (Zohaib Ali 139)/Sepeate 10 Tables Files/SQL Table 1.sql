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

