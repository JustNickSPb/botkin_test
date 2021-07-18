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

do
$do$
declare
	i int;
begin
	for i in 1..20 loop
		insert into public.costs (id, "name", price)
		values(i, (SELECT md5(random()::text)), random());
		insert into public.products (id, "name", status, quantity, priceid) 
		values(i, (SELECT md5(random()::text)), 'В наличии', random(), i);
	end loop;
end;
$do$;