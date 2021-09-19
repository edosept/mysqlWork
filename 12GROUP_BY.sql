use world;

select count(ID), countrycode
from city
group by countrycode;

select avg(population) as Rata_rata, district as Provinsi
from city
where countrycode = 'IDN'
group by district;

select avg(population) as Rata_rata, district as Provinsi
from city
where countrycode = 'IDN'
group by Provinsi
having Rata_rata > 500000;

select avg(population) as Rata_rata, district as Provinsi
from city
where countrycode = 'IDN'
group by Provinsi
having Provinsi like 'K%'