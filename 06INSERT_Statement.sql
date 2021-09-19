create database Seller;
use Seller;

create table Person (
PersonID int,
FirstName varchar(255),
LastName varchar(255),
Address varchar(255),
City varchar(255)
);

show tables;
select * from person;

insert into person (PersonID, FirstName, LastName, Address, City)
values (01, 'Edo', 'Septian', 'Jln Binahong', 'BSD');

insert into person values (02, 'Si', 'Bro', 'Jln Lavender', 'DKI');