use employees;

-- INNER JOIN
select employees.first_name, employees.last_name, salaries.salary
from employees join salaries
on employees.emp_no = salaries.emp_no;

-- LEFT JOIN
select A.first_name, A.last_name, B.title
from employees A left join titles B
on A.emp_no = B.emp_no;

-- RIGHT JOIN
select A.first_name, A.last_name, B.title
from employees A right join titles B
on A.emp_no = B.emp_no
order by B.title;

-- Self Join
select A.first_name, A.last_name, B.title
from employees A, titles B
where A.emp_no = B.emp_no;