use employees;

-- Multiple Tables Sub-Queries
select * from employees
where emp_no in
(select emp_no from titles where title = 'Senior Staff');

select * from employees
where emp_no in
(select emp_no from salaries where salary > 60000);

-- Multiple Tables Implicit join
select * from employees E, salaries S
where E.emp_no = S.emp_no; -- lebih mudah pakai alias name

select E.first_name, E.last_name, S.salary
from employees E, salaries S
where E.emp_no = S.emp_no;