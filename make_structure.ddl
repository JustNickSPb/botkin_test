CREATE DATABASE IF NOT EXISTS db;

CREATE TABLE IF NOT EXISTS db.Costs (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    price INT
);

CREATE TABLE IF NOT EXISTS db.Products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    status VARCHAR(100),
    quantity INT, 
    priceId INT,
    FOREIGN KEY (priceId) REFERENCES Costs (id)
);
