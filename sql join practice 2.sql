--Write a query that shows the student's name, 
--the courses the student is taking and one of the professors that teach that course (if a course is taught by more than one professor). 
--solution 1
select a.student_no, s1.student_name,a.course_no, prof_name from
(select s.student_no, se.course_no, min(last_name) prof_name from
students s inner join student_enrollment se on s.student_no=se.student_no
inner join teach t on se.course_no=t.course_no
group by s.student_no,se.course_no) a, students s1
where a.student_no=s1.student_no;

--alternative solution
select s.student_no, student_name, se.course_no, prof_name from
students s inner join student_enrollment se on s.student_no=se.student_no
inner join (select min(last_name) prof_name, course_no from teach group by course_no) t on se.course_no=t.course_no;

--Write a query that returns ALL of the students as well as any courses they may or may not be taking. 
select * from students, (select distinct course_no from student_enrollment) a;

--write a query that returns employees whose salary is above average for their given department

--solution 1
select e.*,avg_salary from 
employees e inner join (select round(avg(salary)) avg_salary,department from employees group by department) d
on e.department=d.department
where salary>avg_salary;

--solution 2
SELECT *
   FROM employees e1
   WHERE salary > (select avg(salary) from employees e2 where e1.department=e2.department)