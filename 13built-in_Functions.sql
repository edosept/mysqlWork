use world;

-- aggregate Functions
select sum(population) as total_populasi
from city
where CountryCode = 'IDN';

select count(name) as total_city
from city
where CountryCode = 'IDN';

select avg(population) as rata_rata_populasi
from city
where CountryCode = 'IDN';

select min(population) as populasi_terkecil
from city
where CountryCode = 'IDN';

select max(population) as populasi_terbesar
from city
where CountryCode = 'IDN';

use world;
-- scalar Functions
select name, round(LifeExpectancy)
from country;

-- hasil round(, 2) 2 angka dibelakang koma
select name, region, round(Population/SurfaceArea, 2) as kepadatan_penduduk
from country
where region = 'southeast asia';

-- menghitung panjang dari string
select name, length(name) as length_name
from country
where region = 'southeast asia'
order by length_name desc;

-- mengubah huruf ke besar dan kecil
select ucase(name), population
from country
where region = 'southeast asia'
order by population desc;

select lcase(name), population
from country
where region = 'southeast asia'
order by population desc;
