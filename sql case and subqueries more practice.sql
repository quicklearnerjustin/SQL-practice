select department, round(avg(salary)) from employees
group by department;

--write a query to obtain the names of the departments which have more than 38 employees.
select * from employees;

select department from employees
group by department
having count(*)>38;

select distinct department from employees e1
where (select count(*) from employees e2 where e1.department=e2.department) > 38;

--write a query to obtain the departments, first names, salaries and salary_in_ dept
--such that the table returns the first names of two employees which earn the highest and the lowest salaries in each department
--and shows the corresponding departments and salaries of them
--in the end, 'Highest salary' or 'Lowest salary' should follow respectively

select * 
from (select department, 
CASE
	When salary = (select max(salary) from employees e1 where e1.department=e2.department) Then first_name
	When salary = (select min(salary) from employees e1 where e1.department=e2.department) then first_name 
END as first_name,

CASE
	When salary = (select max(salary) from employees e1 where e1.department=e2.department) Then salary
	When salary = (select min(salary) from employees e1 where e1.department=e2.department) then salary
END as salary,

CASE
	When salary = (select max(salary) from employees e1 where e1.department=e2.department) Then 'Highest Salary'
	When salary = (select min(salary) from employees e1 where e1.department=e2.department) then 'Lowest Salary'
END as salary_in_dept 

from employees e2
order by department ASC, salary DESC) a
where salary is not null;