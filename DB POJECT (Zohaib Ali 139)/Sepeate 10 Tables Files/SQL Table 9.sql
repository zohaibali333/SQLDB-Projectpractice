CREATE DATABASE ECOM_PLATFORM;
USE ECOM_PLATFORM;

-- WISHLIST TABLE(INFORMATION ABOUT THE WISHLIST)
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
(3, 4,"20224-04-23");

SELECT u.Username, COUNT(w.WishlistID) AS WishlistCount
FROM Users u
JOIN Wishlists w ON u.UserID = w.UserID
GROUP BY u.Username
HAVING WishlistCount = 1;