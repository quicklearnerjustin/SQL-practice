select * from students;
select * from student_enrollment;
select * from teach;

select * from students s 
inner join student_enrollment se 
on s.student_no=se.student_no;

--Write a query that finds students who do not take CS180.
select student_no, student_name from students
except
(select s.student_no, student_name from students s 
inner join student_enrollment se 
on s.student_no=se.student_no
where course_no='CS180');

--Write a query to find students who take CS110 or CS107 but not both.
select student_no, student_name from(
select student_no, student_name, count(*) c
from (select s.student_no, student_name from students s 
inner join student_enrollment se 
on s.student_no=se.student_no
where course_no in ('CS110','CS180')) a
group by student_no,student_name) b
where c=1;

--Write a query to find students who take CS220 and no other courses.
select * from students s 
inner join student_enrollment se 
on s.student_no=se.student_no
where course_no='CS220'
and (select count('Michael') from students s 
inner join student_enrollment se 
on s.student_no=se.student_no)=1;


--Write a query that finds those students who take at most 2 courses. 
--Your query should exclude students that don't take any courses as well as those  that take more than 2 course. 
select student_no, student_name from(
select s.student_no, student_name, count(*) from students s 
inner join student_enrollment se 
on s.student_no=se.student_no
group by s.student_no, student_name) a
where count=2;

--Write a query to find students who are older than at most two other students.
select student_no, student_name, age from 
(select *, rank() over(order by age) from students) a 
where rank<=3;