use world;

select name, population
from city
where population between
1000000 and 2000000;

select Name, Region, LifeExpectancy
from Country
where LifeExpectancy between -- berada diantara
80 and 90;

select Name, Region, LifeExpectancy
from Country
where LifeExpectancy not between -- tidak berada diantara
45 and 90;