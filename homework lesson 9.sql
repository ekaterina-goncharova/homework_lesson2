--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

SELECT IF(GRADE < 8, NULL, NAME), GRADE, MARKS
FROM STUDENTS JOIN GRADES
WHERE MARKS BETWEEN MIN_MARK AND MAX_MARK
ORDER BY GRADE DESC, NAME;

--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem



--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem

--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem

--1 вариант
SELECT distinct CITY 
FROM STATION 
where CITY not LIKE 'a%' and CITY not LIKE 'e%' and CITY not LIKE 'i%' and CITY not LIKE 'o%' and CITY not LIKE 'u%';

--2 вариант(не могу понять, почему не работает, вроде запрос корректен, поясните пожалуйста)

SELECT DISTINCT CITY 
FROM STATION 
WHERE CITY NOT RLIKE '^[aeiouAEIOU].*$';

--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem

Select DISTINCT CITY FROM STATION Where CITY NOT LIKE '%A' AND CITY NOT LIKE '%E' AND CITY NOT LIKE '%I' AND CITY NOT LIKE '%O' AND CITY NOT LIKE '%U';

--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem

select distinct city from station where city not regexp '^[aeiou]' and city not regexp '[aeiou]$';

--2 вариант

select distinct CITY from STATION where CITY NOT RLIKE '^[aeiouAEIOU]' AND CITY NOT RLIKE '[AEIOUaeiou]$' GROUP BY CITY;


--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem

select name from employee where salary > 2000 and months < 10;

--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
