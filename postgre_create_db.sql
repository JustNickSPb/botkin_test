CREATE DATABASE "db" OWNER = dcuser;

\connect dbname=db user=dcuser password=dcpas$w0rd;

CREATE TABLE public.Costs
(
    id serial NOT NULL,
    name CHARACTER VARYING,
    price INT,
    PRIMARY KEY (id)
);
ALTER TABLE public.Costs
    OWNER TO dcuser;

CREATE TABLE public.Products 
(
    id serial NOT NULL,
    name CHARACTER VARYING,
    status VARCHAR(100),
    quantity INT, 
    priceId INT,
    PRIMARY KEY (id)
   -- FOREIGN KEY (priceId) REFERENCES Costs (id)
);
ALTER TABLE public.Products
    OWNER TO dcuser;
