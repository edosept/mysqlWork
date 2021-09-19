-- ACCESS SAKILA DATABASE
show databases;
use sakila;
show tables;

-- Common Table Expression in SQL
WITH rental_duration_avg as (
	select avg(rental_duration) as avg_duration
    from sakila.film)

-- select * from rental_duration_avg; -- ambil dari tabel sementara
-- mirip mirip function sih jadi CTE bisa dipakai berkali-kali

select f.film_id, f.rental_duration
from sakila.film f
where f.rental_duration >= (select avg_duration from rental_duration_avg)
order by 2 desc -- urutkan by kolom ke 2 yaitu si rental_duration
limit 5;

-- note aja jadi si CTE ini harus berpasangan,
-- kita buat CTE itu harus berpasangan dengan yg kita panggil nanti querynya
-- dan buat kuerynya ini gga bisa double, akan muncul error	table sementaranya doesn't exist
-- jadi satu query di dalam CTE buat dipakai satu query select dibawahnya