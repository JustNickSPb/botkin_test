CREATE TABLE IF NOT EXISTS public.Costs 
    (
        id INT PRIMARY KEY,
        name TEXT,
        price NUMERIC(5, 2)
    );
CREATE TABLE  IF NOT EXISTS public.Products 
(
    id INT PRIMARY KEY,
    name TEXT,
    status TEXT,
    quantity INT, 
    priceId INT,
    FOREIGN KEY (priceId) REFERENCES Costs (id)
);