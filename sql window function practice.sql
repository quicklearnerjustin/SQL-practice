--write a query to find the first name, department, and the total number of employees in the department
select first_name, department, count(*) over(partition by department) num
from employees;

--write a query to find the first name, department, and the total salary in the department
select first_name, department, sum(salary) over(partition by department)
from employees;

--write a query to find the first name, department, and the number of employees in the department and in the region
select first_name, department, 
count(*) over(partition by department) num_in_dept,
count(*) over(partition by region_id) num_in_region
from employees
order by num_in_region desc, department asc;

--write a query to find the first name, department and the number of employees in each department in region 3
select first_name, department, count(*) over(partition by department)
from employees
where region_id=3;

--write a query to find the first name, department, hire date, and the total salary from the first hired employee to the last one
select first_name, department, hire_date, salary, sum(salary) over(order by hire_date)
from employees;

--we could also do this by department
select first_name, department, hire_date, salary,
sum(salary) over(partition by department order by hire_date)
from employees;

--what if we want to have the sum of adjacent salaries?
select first_name, department, hire_date, salary,
sum(salary) over(order by hire_date rows between 1 preceding and current row)
from employees;

select first_name, department, hire_date, salary,
sum(salary) over(order by hire_date rows between current row and 2 following)
from employees;

--write a query to find first name, department, salary, and the rank of salaries in each department
select first_name, department, salary, 
rank() over(partition by department order by salary)
from employees;

--write a query to find first name, department, salary, whose rank of salary is 8 in each department
select * from
(select first_name,department, salary,
rank() over(partition by department order by salary)
from employees) a
where rank=8;
--alternative solution
select first_name, department, salary,
nth_value(salary, 8) over(partition by department order by salary desc)
from employees;

--we divide the salaries into 5 levels for each department
--write a query to find first name, department, salary, and which level the employee belongs to in the department
select first_name, department, salary,
NTILE(5) over(partition by department order by salary DESC)
from employees;

--write a query to find first name, department, salary, and the highest salary in the department
select first_name, department, salary,
first_value(salary) over(partition by department order by salary desc)
from employees;


