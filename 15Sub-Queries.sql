use employees;

-- menampilkan salary yang diatas ratarata
-- Sub-Queries setelah where clause
select emp_no, salary, from_date
from salaries
where salary > (select avg(salary) from salaries);

-- Sub-Queries list of column,

select emp_no, salary, from_date,
(select min(salary) from salaries) MIN_Salary, -- posisi setelah select
(select max(salary) from salaries) MAX_Salary -- bisa menambahkan kolom baru
from salaries;

-- Sub-Queries bisa juga digunakan di from clause
select * from
(select first_name, last_name, gender, birth_date from employees)
as Employees_Biodata;