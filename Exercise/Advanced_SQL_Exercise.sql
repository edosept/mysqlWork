use sakila;
show tables;
select * from film limit 5;
select * from film_category limit 5;
select * from category limit 5;
select * from rental limit 5;
select * from inventory limit 5;
select * from customer limit 5;

-- Question No 1
-- Find out the five highest total rental_duration of film category name
-- calculate its cumulative sum of total rental duration and moving average of total rental_duration.
-- For data filtering: Select only film whose rental_duration is lower
-- or equal to the average of overall rental_duration.

with rental_duration_sum_avg as(
	select c.name as category_name,
    avg(f.rental_duration) as avg_rental_duration,
    sum(f.rental_duration) as total_rental_duration
    from film f left join film_category fc on f.film_id = fc.film_id 
    left join category c on c.category_id = fc.category_id
    where f.rental_duration <= (select avg(rental_duration) from film)
    group by c.name
)
select rdsa.category_name, rdsa.total_rental_duration, 
sum(rdsa.total_rental_duration) over(order by rdsa.total_rental_duration desc rows between unbounded preceding and current row) 
as cumulative_sum,
round(avg(rdsa.total_rental_duration) over(order by rdsa.total_rental_duration desc rows between unbounded preceding and current row), 2) 
as moving_average
from rental_duration_sum_avg rdsa, film
group by rdsa.category_name;

-- Question No 2
-- Find out film’s rating and its average rental duration.
-- Please note that the film category must be the category whose the total films inside is the three highest in numbers among all film categories.

with best_three_film as (
	select c.name as name_category,
	count(f.film_id) as total_film, 
    rank() over(order by count(f.film_id) desc) as rank_count 
    from film f left join film_category fc on f.film_id = fc.film_id 
    left join category c on c.category_id = fc.category_id
    group by c.name
    order by 1 desc
)
select f.rating, avg(f.rental_duration) 
	from film f left join film_category fc on f.film_id = fc.film_id 
    left join category c on c.category_id = fc.category_id
    where c.name in (select btf.name_category from best_three_film btf where rank_count <= 3) 
    group by rating
    order by 2 desc;
    


-- Question No 3
-- Find out film’s title and its total rented customers. Please satisfy these conditions:
-- 1. The prefix of film’s name is either “C” or “G”
-- 2. Total rented customer is higher than its overall average
-- 3. Total rented customer is higher or equal to 15 and lower or equal to 25

with prefix_c_g as (
select f.title as title, 
	count(c.customer_id) as total_customer,
    count(c.customer_id) - avg(count(c.customer_id)) over() as difference
	from film f left join inventory i on f.film_id = i.film_id 
	left join rental r on i.inventory_id = r.inventory_id
	left join customer c on r.customer_id = c.customer_id
    where f.title like 'C%' or f.title like 'G%'
	group by 1
)
select pcg.title, pcg.total_customer
from prefix_c_g pcg
where pcg.difference > 0 and
pcg.total_customer between 15 and 25
order by 1
limit 5;