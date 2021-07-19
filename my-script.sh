#!/bin/bash
export $(xargs < .env)
if [ $1 == "create" ]
then
    mysql -h 0.0.0.0 -uroot -p$DB_ROOT < create_tables.sql
    psql -h 0.0.0.0 -U postgres -d postgres < create_tables_pgsql.sql
fi
if [ $1 == "autoinsert" ]
then
    for (( i=1; i <= 10; i++ ))
    do
    pseudo_random_string="Product$i"
    random_num=$i*$i
    psql -h 0.0.0.0 -U postgres -d postgres -c "INSERT INTO public.Costs (id, name, price) VALUES ($i, '$pseudo_random_string', $random_num)"
    psql -h 0.0.0.0 -U postgres -d postgres -c "INSERT INTO public.Products (id, name, status, quantity, priceid) VALUES ($i, '$pseudo_random_string', 'IN_STOCK', $random_num, $i)"
    done
fi
if [ $1 == "migrate" ]
then
    # Costs
    CONN="psql -h 0.0.0.0 -U postgres -d postgres"
    QUERY="$(sed 's/;//g;/^--/ d;s/--.*//g;' ./migration/query_costs.sql | tr '\n' ' ')"
    echo "\\copy ($QUERY) to './migration/costs.csv' with CSV HEADER" | $CONN
    cat ./migration/costs.csv | awk -F, 'NR>1{print $1","$2","$3*10}' > ./migration/new_costs.csv
    docker cp ./migration/new_costs.csv botkin_test_mysql_1:/var/lib/mysql/db/new_costs.csv
    mysql -h 0.0.0.0 -uroot -p$DB_ROOT < ./migration/costs_to_my.sql
    # Products
    CONN="psql -h 0.0.0.0 -U postgres -d postgres"
    QUERY="$(sed 's/;//g;/^--/ d;s/--.*//g;' ./migration/query_products.sql | tr '\n' ' ')"
    echo "\\copy ($QUERY) to './migration/products.csv' with CSV HEADER" | $CONN4
    cat ./migration/products.csv | awk -F, 'NR>1{print $1","$2","$3}' > ./migration/new_products.csv
    docker cp ./migration/new_products.csv botkin_test_mysql_1:/var/lib/mysql/db/products.csv
    mysql -h 0.0.0.0 -uroot -p$DB_ROOT < ./migration/products_to_my.sql
fi