#! /usr/bin/env python
# -*- coding: utf-8 -*- 

import psycopg2
import random
from mysql.connector import connect
import os

PSEUDO_RANDOM_GOODS = [
    'эссенция', 'багор', 'санки', 'корешок', 'лама', 'грифон', 'манускрипт', 'вестник',
    'гонг', 'подорожник', 'катер', 'канарейка', 'чулок', 'индюк', 'автокран', 'кобра',
    'липа', 'шишка', 'дудка', 'клевер', 'ножны', 'паспорт', 'копилка'
]


def create_tables():
    my_cur.execute('''CREATE TABLE IF NOT EXISTS Costs 
    (
        id INT PRIMARY KEY,
        name VARCHAR(50),
        price float
    );
    ''')
    cur.execute('''CREATE TABLE IF NOT EXISTS public.Costs 
    (
        id INT PRIMARY KEY,
        name TEXT,
        price NUMERIC(5, 2)
    );
    ''')
    my_cur.execute('''CREATE TABLE  IF NOT EXISTS Products 
    (
        id INT PRIMARY KEY,
        name VARCHAR(50),
        status VARCHAR(50),
        quantity INT, 
        priceId INT,
        FOREIGN KEY (priceId) REFERENCES Costs (id)
    );
    ''')
    cur.execute('''CREATE TABLE  IF NOT EXISTS public.Products 
    (
        id INT PRIMARY KEY,
        name TEXT,
        status TEXT,
        quantity INT, 
        priceId INT,
        FOREIGN KEY (priceId) REFERENCES Costs (id)
    );
    ''')
    postgre.commit()


def generate_values():
    for i in range(1,21):
        good = random.choice(PSEUDO_RANDOM_GOODS)
        cur.execute(
            'INSERT INTO public.Costs (id, name, price) '
            'VALUES ({i}, \'{good}\', {price});'.format(
                i=i, good=good, price=round(random.uniform(0.01, 1000.00), 2)
            )
        )
        cur.execute(
            'INSERT INTO public.Products (id, name, status, quantity, priceid) '
            'VALUES({i}, \'{good}\', \'В наличии\', {qty}, {i});'.format(
                i=i, good=good, qty=random.randint(0, 100)
            )
        )
    postgre.commit()


def move_data_from_postgre_to_my():
    cur.execute("SELECT id, name, price from public.Costs;")
    rows = cur.fetchall()
    rows_final = []
    for row in rows:  
        row_editable = []
        for cell in row:
            row_editable.append(cell)
        row_editable[2] *= 10
        row_editable = tuple(row_editable)
        rows_final.append(row_editable)
    my_cur.executemany('''INSERT INTO db.Costs (id, name, price) VALUES (%s, %s, %s)''', rows_final)
    cur.execute('SELECT id, name, status, quantity, priceId from public.products;')
    mysql.commit()
    rows = cur.fetchall()
    my_cur.executemany('''INSERT INTO db.Products (id, name, status, quantity, priceId) 
        VALUES (%s, %s, %s, %s, %s);''', rows)
    mysql.commit()
    print('Done')


postgre = psycopg2.connect(
  database="postgres", 
  user="postgres", 
  password=os.environ.get('DB_PASS'),
  host="0.0.0.0",
  port="5432"
)

mysql = connect(
        database="db",
        host="0.0.0.0",
        user='root',
        password=os.environ.get('DB_ROOT'),
        port="3306"
    )

my_cur = mysql.cursor()
cur = postgre.cursor()  
create_tables()
generate_values()
move_data_from_postgre_to_my()
postgre.close()
mysql.close()
