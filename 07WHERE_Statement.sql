use world;

select * from city where population > 1000000;
-- bisa juga gga semua kolom seperti dibawah ini
select name, district from city where population > 1000000;

-- memfilter string
select * from city where name like 'X%';
