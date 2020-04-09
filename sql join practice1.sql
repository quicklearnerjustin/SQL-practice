select * from regions;
--return employees' first names, email address and divisions and emails cannot be null
select first_name, email, division from employees, departments
where employees.department=departments.department and email is not null;

--return employees' first names, country and how many employees work in the country
select first_name, regions.country, num 
from employees, regions, (select country, count(*) as num from employees,regions where employees.region_id=regions.region_id group by regions.country) a
where employees.region_id=regions.region_id AND a.country=regions.country;

--return the departments that only show in the employees table, not in the departments table
select distinct employees.department 
from employees left join departments on employees.department=departments.department
where departments.department is null;

--return the departments and the number of employees who work for the departments with the total number

select distinct department, count(*)
from employees
group by department
union all
select 'Total', count(*)
from employees;

--return the first name, hire date, country, and the department of the first and the last hired employees

(select first_name, department, hire_date, country from employees FULL Join regions
on employees.region_id=regions.region_id
where hire_date=(select min(hire_date) from employees)
limit 1)
Union all
select first_name, department, hire_date, country from employees FULL Join regions
on employees.region_id=regions.region_id
where hire_date=(select max(hire_date) from employees);

--return the total amount of salary every 90 days
select hire_date, salary, 
(select sum(salary) from employees e2 where hire_date between e1.hire_date and e1.hire_date+90) as spending_pattern
from employees e1
order by hire_date;
