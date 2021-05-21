---task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/ 

---1 вариант решения

create table result as
SELECT d.name as department, e.name as employee, salary 
from department d
join employee e
on d.id = e.id
WITH result CTE AS (
    SELECT department, employee, salary,
        RANK() OVER (ORDER BY SALARY) rnk_max where department = 'it',
        RANK() OVER (ORDER BY SALARY DESC) rnk_max1 where department = 'Sales'
    FROM result
)

SELECT department, employee, salary
FROM result_table
WHERE rnk_max = 3 OR rnk_max2 = 3
ORDER BY SALARY;

---2 вариант решения объясните пожалуйста эту задачу

create table result as
SELECT d.name as department, e.name as employee, salary 
from department d
join employee e
on d.id = e.id
WITH result AS ( SELECT department, employee, salary, RANK() OVER (PARTITION BY department ORDER BY salary DESC) rnk
              FROM result )
SELECT department, employee, salary
FROM result
WHERE rnk = 3;

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17

SELECT fm.member_name, fm.status, SUM(p.amount*p.unit_price) as costs
FROM FamilyMembers as fm
JOIN Payments as p ON p.family_member = fm.member_id
WHERE YEAR(p.date) = 2005
GROUP BY fm.member_id, fm.member_name, fm.status

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13

select name
from Passenger
group by name
HAVING COUNT(name)>1 

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

SELECT count(first_name) as count FROM Student
WHERE first_name = 'anna'

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35

select count(class) as count from Schedule
where date = '2019-09-02'

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

SELECT count(first_name) as count FROM Student
WHERE first_name = 'anna'

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32

SELECT floor(avg(
    (YEAR(CURRENT_DATE) - YEAR(birthday)) -                             /* step 1 */
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d')) /* step 2 */
  )) AS age
from FamilyMembers

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27

select goo.good_type_name, SUM(p.amount*p.unit_price) as costs
from payments p 
join goods g 
on p.good = g.good_id
join GoodTypes Goo 
on g.type = goo.good_type_id
where p.date like '2005%'
group by good_type_name

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37


SELECT min(
    (YEAR(CURRENT_DATE) - YEAR(birthday)) -                             /* step 1 */
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d')) /* step 2 */
  ) AS year
from Student


--task10  (lesson8)
-- https://https://sql-academy.org/ru/trainer/tasks/44

SELECT max(
    (YEAR(CURRENT_DATE) - YEAR(birthday)) -                             /* step 1 */
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d')) /* step 2 */
  ) AS max_year
from Student S 
join Student_in_class St 
on s.id = st.student
join class c 
on st.class = c.id
where c.name like '10%'


--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20

select f.status, f.member_name, SUM(p.amount*p.unit_price) as costs
from FamilyMembers f
join Payments p 
on f.member_id = p.family_member
join goods g 
on p.good = g.good_id 
join GoodTypes gt 
on g.type = gt.good_type_id
where good_type_name = 'entertainment'
group by f.member_name



--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55

-- не могу разобраться, как удалить дубликаты, вроде, есть простая схема удаления delete from where и нужно использовать вложенный запрос, но не получается


SELECT COUNT(ID) as count
from trip
where count > min(count)
group by company



--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45

select classroom
from Schedule 
where count(number_pair) = max(select count(number_pair) from Schedule group by classroom)
GROUP BY classroom

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43

select t.last_name
from Teacher t 
join Schedule s 
on t.id = s.teacher
join Subject su 
on s.subject = su.id
where su.name = 'Physical Culture'
ORDER BY last_name

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63


