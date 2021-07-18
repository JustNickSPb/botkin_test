-- create the database if it does not already exist
if not exists(select * from sys.databases 
where name = 'db')
begin
  create database db
end
go

-- specify that all subsequent sql commands use this database
use [db]
go

-- add UserAccount table if it does not already exist
if not exists (select * from information_schema.columns
where table_name = 'Costs')
begin
	create table Costs 
	(
		id int identity(1000,1) not null,
		name nvarchar(50) not null,
		price int not null,
		
		constraint PK_Costs primary key (id),
	)	
end
go