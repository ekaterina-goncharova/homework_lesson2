--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--�������: ��� ������� ������ ���������� ����� �������� ����� ������, ����������� � ���������. �������: ����� � ����� ����������� ��������.
SELECT c.class, COUNT(s.ship)
FROM classes c
LEFT JOIN (SELECT o.ship, sh.class
FROM outcomes o
LEFT JOIN ships sh ON sh.name = o.ship
WHERE o.result = 'sunk') AS s ON s.class = c.class OR s.ship = c.class
GROUP BY c.class;  
--task2
--�������: ��� ������� ������ ���������� ���, ����� ��� ������ �� ���� ������ ������� ����� ������. ���� ��� ������ �� ���� ��������� ������� ����������, ���������� ����������� ��� ������ �� ���� �������� ����� ������. �������: �����, ���.
select c.class, min(s.launched)
from classes c
join ships s 
on c.class= s.class
group by c.class;  

--task3
--�������: ��� �������, ������� ������ � ���� ����������� �������� � �� ����� 3 �������� � ���� ������, ������� ��� ������ � ����� ����������� ��������.
SELECT c.class, COUNT(s.ship)
FROM classes c
LEFT JOIN (SELECT o.ship, sh.class
FROM outcomes o
LEFT JOIN ships sh ON sh.name = o.ship
WHERE o.result = 'sunk') AS s ON s.class = c.class OR s.ship = c.class
GROUP BY c.class
having count(s.ship) > 2;      



--task4
--�������: ������� �������� ��������, ������� ���������� ����� ������ ����� ���� �������� ������ �� ������������� (������ ������� �� ������� Outcomes).
SELECT name
FROM (SELECT O.ship AS name, numGuns, displacement
FROM Outcomes O INNER JOIN
Classes C ON O.ship = C.class AND
O.ship NOT IN (SELECT name
FROM Ships
)
UNION
SELECT S.name AS name, numGuns, displacement
FROM Ships S INNER JOIN
Classes C ON S.class = C.class
) OS INNER JOIN
(SELECT MAX(numGuns) AS MaxNumGuns, displacement
FROM Outcomes O INNER JOIN
Classes C ON O.ship = C.class AND
O.ship NOT IN (SELECT name
FROM Ships
)
GROUP BY displacement
UNION
SELECT MAX(numGuns) AS MaxNumGuns, displacement
FROM Ships S INNER JOIN
Classes C ON S.class = C.class
GROUP BY displacement
) GD ON OS.numGuns = GD.MaxNumGuns AND
OS.displacement = GD.displacement;  

--task5
--������������ �����: ������� �������������� ���������, ������� ���������� �� � ���������� ������� RAM � � ����� ������� ����������� ����� ���� ��, ������� ���������� ����� RAM. �������: Maker
SELECT DISTINCT maker
FROM product
WHERE model IN (
SELECT model
FROM pc
WHERE ram = (SELECT MIN(ram)FROM pc)
AND speed = (
  SELECT MAX(speed)
  FROM pc
  WHERE ram = (
      SELECT MIN(ram)
      FROM pc
      )
  )
)
AND
maker IN (
SELECT maker
FROM product
WHERE type='printer'
);   