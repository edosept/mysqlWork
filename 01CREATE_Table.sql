show databases;

create database Seller;
use Seller;
drop database Seller;

use world;
show tables;

create table TestTable AS
select PersonID, FirstName
from person;

create table people (
PeopleID int,
Name varchar(255),
Hometown varchar(300)
);