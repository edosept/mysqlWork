use sakila;

select customer_id, day(payment_date) -- tanggal
from payment
where amount > 11;

select avg(amount) as avg_amount, dayname(payment_date) as hari
from payment
group by hari
order by avg_amount;

select sum(amount) as total_amount_august
from payment
where month(payment_date) = 8;

select avg(amount) as avg_amount, monthname(payment_date) as bulan
from payment
group by bulan
order by avg_amount;

select customer_id, amount, dayname(payment_date + 1) as next_day_payment
from payment
where staff_id = 1 and amount > 11;

select avg(amount) as avg_amountYear, year(payment_date) as tahun
from payment
group by tahun;
