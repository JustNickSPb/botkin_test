SET GLOBAL local_infile=1;
CREATE DATABASE IF NOT EXISTS db;
USE db;
CREATE TABLE IF NOT EXISTS Costs 
    (
        id INT PRIMARY KEY,
        name VARCHAR(50),
        price float
    );
CREATE TABLE  IF NOT EXISTS Products 
    (
        id INT PRIMARY KEY,
        name VARCHAR(50),
        status VARCHAR(50),
        quantity INT, 
        priceId INT,
        FOREIGN KEY (priceId) REFERENCES Costs (id)
    );