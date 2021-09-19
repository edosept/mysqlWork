-- access sakila database
show databases;
use sakila;
show tables;

-- Window Function
-- 1. over partition clause
select 	release_year, rental_rate,
		avg(rental_rate) over() as avg_rental_rate,
        rental_rate - avg(rental_rate) over() as difference -- nilai rental rate awal dikurangi avgnya
from sakila.film f;

-- di dalam over sebenarnya kita jg bisa lakukan group by,
-- klo disini istilah partition by
select 	release_year, rating,
		avg(rental_rate) over() as avg_rental_rating, -- klo ini ratarata rating keseluruhan
        avg(rental_rate) over(partition by rating) as avg_rental_rate -- ratarata disetiap ratingnya
from sakila.film f;

-- MARI KITA BANDINGKAN GROUP BY dan OVER PARTITION
-- group by
select rating, avg(rental_rate)
from sakila.film f
group by 1
order by 1;

-- over partition by jg bisa mengelompokkan lebih dari satu kolom
select 	release_year, rental_rate, rating, replacement_cost,
		avg(rental_rate) over() as avg_rental_rating,
        avg(rental_rate) over(partition by rating, replacement_cost) as avg_rental_rate_2
from sakila.film f;

-- kita lihat group by,
-- ingat klo over partition by itu dia grouping tapi seluruh datanya tetap pada barisnya
-- klo di group by itu kan dia dikelompokkan data nya jadi data avg nya sama ya dia kelompoking jadi satu baris
select rating, replacement_cost, avg(rental_rate)
from sakila.film f
group by 1, 2 -- by rating, replacement_cost
order by 1;

-- 2. ROW NUMBER()
-- membuat kolom baru by indexing
select row_number() over() as no,
		title,
        rating,
        rental_duration
from sakila.film f;

-- menggabungkan row_number dengan over partition
select rating, rental_duration,
row_number() over(partition by rating) as row_group, -- memberi no index berdasarkan kolom rating
avg(rental_rate) over(partition by rating) as avg_rental_rate
from sakila.film f
group by 1, 2;

-- elaborasi atau memperdalam penggunaan row_number dalam CTE
with number_group as (
select 	rating, rental_duration,
		row_number() over(partition by rating) as row_group,
        avg(rental_rate) over(partition by rating) as avg_rental_rate
from sakila.film f
group by 1, 2
)
select *
from number_group
where row_group <= 3;

-- 3. RANK() and DENSE_RANK()
-- klo row number itu menghitung baris data dalam bentuk penomoran angka terendah ke tertinggi

-- klo si RANK() and DENSE_RANK() itu menghitung urutan baris data berdasarkan value yg ingin kita ukur
-- dan bisa berupa angka tertinggi ke terendah

-- perbedaan RANK() and DENSE_RANK() terlihat jika ada nilai yg sama
-- jika RANK() maka menyimpan angka rangking yang sama

-- jika DENSE_RANK() hanya satu baris saja yg terdapat angka rankingnya,
-- data yg lain dengan nilai yang sama itu akan mendapat null atau nilai kosong di rankingnya

select 	rating,
		count(film_id) as total_film,
        rank() over(order by count(film_id) desc) as rank_count -- meranking value dari kolom total_film
from sakila.film f
group by 1;

select 	rating,
		count(film_id) as total_film,
        avg(rental_duration) as avg_rental_duration,
        rank() over(order by count(film_id) desc) as rank_count,
        rank() over(order by avg(rental_duration) desc) as rank_rental_duration
from sakila.film f
group by 1
order by 2 desc;

-- 4. NTILE()
-- melalui ntile kita dapat mengelompokkan data berdasarkan urutan data dari terkecil ke terbesar
-- jumlah kelompok akan disesuaikan dengan persentase pembagian yang dimasukan --> misal ntile(4)
select 	rating, title,
		row_number() over(partition by rating) as no_row,
        ntile(4) over(partition by rating) as quantile_group, -- dikelompokkan menjadi 4 kelompok
        ntile(100) over(partition by rating) as percentile -- dikelompokkan menjadi 100 kelompok
from sakila.film f;

-- 5. SLIDING WINDOW
-- adalah clause untuk menghitung angka aggregate yang bergerak atau kumulatif
-- kita bisa menghitung moving average berdasarkan urutan terkecil ke terbesar, bisa juga SUM
-- dan operasi matematik lain yg biasa kita gunakan pada data aggregasi

with total_film_per_rating as (
select 	rating,
		count(film_id) as total_film
from sakila.film f
group by 1
)

select 	rating, total_film,
		sum(total_film) over(order by total_film desc
        rows between unbounded preceding and current row) as cumulative_sum,
        -- menghitung cumulative by total_film antara baris atas dan bawahnya
        avg(total_film) over(order by total_film desc
        rows between unbounded preceding and current row) as cumulative_avg
from total_film_per_rating;
