--> Question 1: Achieving 1NF (First Normal Form) 
-- Ensure that each column contains atomic values and each record is unique.
USE salesdb;

CREATE TABLE ProductDetail (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL
    );

CREATE TABLE ProductOrder (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    Product VARCHAR(15) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES ProductDetail(OrderID)
);

INSERT INTO ProductDetail (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

INSERT INTO ProductOrder (OrderID, Product)
VALUES
(101, 'Laptop'),
(101, 'Mouse'),
(102, 'Tablet'),
(102, 'Keyboard'),
(102, 'Mouse'),
(103, 'Phone');

-- JOIN query = "Show all products with their customer names"
SELECT pd.OrderID, pd.CustomerName, po.Product
FROM ProductDetail pd
JOIN ProductOrder po
ON pd.OrderID = po.OrderID
ORDER BY pd.OrderID, po.Product;

-- Question 2: Achieving 2NF (Second Normal Form)
-- Ensure that all non-key attributes are fully functionally dependent on the primary key.
CREATE TABLE OrderDetail (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL
);

CREATE TABLE ProductOrder (
    OrderID INT NOT NULL,
    Product VARCHAR(15) NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, Product),  -- composite key
    FOREIGN KEY (OrderID) REFERENCES OrderDetail(OrderID)
);

-- Insert into OrderDetail
INSERT INTO OrderDetail (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Insert into ProductOrder
INSERT INTO ProductOrder (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- JOIN query = "Show all products with their customer names and quantities"
SELECT od.OrderID, od.CustomerName, po.Product, po.Quantity 
FROM OrderDetail od
JOIN ProductOrder po
ON od.OrderID = po.OrderID
ORDER BY od.OrderID, po.Product;