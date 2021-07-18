--CREATE DATABASE db;

CREATE TABLE public.Costs (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    price INT
);

CREATE TABLE public.Products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    status VARCHAR(100),
    quantity INT, 
    priceId INT,
    FOREIGN KEY (priceId) REFERENCES Costs (id)
);