--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--������������ �����: ������� ������ ���� ��������� � ������������� � ��������� ���� �������� (pc, printer, laptop). �������: model, maker, type
select model, maker, type 
from product;  


--task14 (lesson3)
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���, � ���� ���� ����� ������� PC - "1", � ��������� - "0"
select *,
case 
    when price > (select avg(price) from pc)
    then 1
    else 0
end flag
from printer;  


--task15 (lesson3)
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)


select name 
from ships
where class is null;  

--task16 (lesson3)
--�������: ������� ��������, ������� ��������� � ����, �� ����������� �� � ����� �� ����� ������ �������� �� ����.


select name 
from battles 
where DATEPART(date) not in (select DATEPART(date)  
from battles join ships on DATEPART(date)=launched);  


--task17 (lesson3)
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.

select battle
from outcomes  
where ship in (select name from ships where class = 'kongo');  

--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ > 300. �� view ��� �������: model, price, flag
CREATE VIEW all_products_flag_300 AS
  (
  Select laptop.model , laptop.price
  from laptop 
  inner join product
  on laptop.model = product.model,
  case 
    when price > 300
    then 1
    else 0
  end flag
union 
  Select pc.model , pc.price
  from pc
  inner join product
  on pc.model = product.model,
  case 
    when price > 300
    then 1
    else 0
  end flag
union 
  Select printer.model , printer.price 
  from printer 
  inner join product 
  on printer.model = product.model,
  case 
    when price > 300
    then 1
    else 0
  end flag
);   





--task2  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ c������ . �� view ��� �������: model, price, flag
CREATE VIEW all_products_flag_300 AS
  (
  Select laptop.model , laptop.price
  from laptop 
  inner join product
  on laptop.model = product.model,
  case 
    when price > avg(price)
    then 1
    else 0
  end flag
union 
  Select pc.model , pc.price
  from pc
  inner join product
  on pc.model = product.model,
  case 
    when price > avg(price
    then 1
    else 0
  end flag
union 
  Select printer.model , printer.price 
  from printer 
  inner join product 
  on printer.model = product.model,
  case 
    when price > avg(price
    then 1
    else 0
  end flag
);   

--task3  (lesson4)
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model
select model
from product p
join printer pr
on p.model = pr.model
where price > (select avg(price) from printer where maker = 'D' and maker = 'C') and maker = 'A';  




--task5 (lesson4)
-- ������������ �����: ����� ������� ���� ����� ���������� ��������� ������������� = 'A' (printer & laptop & pc)
Select avg(price)  from laptop inner join product on laptop.model = product.model  
where product.maker= 'A' 
union 
Select avg(price) from pc inner join product on pc.model = product.model  
where product.maker= 'A' 
union 
Select avg(price) from printer inner join product on printer.model = product.model  
where product.maker= 'A';  


--task6 (lesson4)
-- ������������ �����: ������� view � ����������� ������� (�������� count_products_by_makers) �� ������� �������������. �� view: maker, count
CREATE VIEW count_products_by_makers AS
  SELECT maker, count(model) FROM product
  group by maker;    

--task7 (lesson4)
-- �� ����������� view (count_products_by_makers) ������� ������ � colab (X: maker, y: count)
 

--task8 (lesson4)
-- ������������ �����: ������� ����� ������� printer (�������� printer_updated) � ������� �� ��� ��� �������� ������������� 'D'

INSERT INTO printer_updated SELECT * FROM printer
delete from printer_updated
where maker = 'D';    

--task9 (lesson4)
-- ������������ �����: ������� �� ���� ������� (printer_updated) view � �������������� �������� ������������� (�������� printer_updated_with_makers)
create view printer_updated_with_makers as
select * from printer_updated;  

--task10 (lesson4)
-- �������: ������� view c ����������� ����������� �������� � ������� ������� (�������� sunk_ships_by_classes). �� view: count, class (���� �������� ������ ���/IS NULL, �� �������� �� 0)

create view sunk_ships_by_classes as
SELECT c.class, COUNT(s.ship)
FROM classes c
  LEFT JOIN
    (
       SELECT o.ship, sh.class
       FROM outcomes o
       LEFT JOIN ships sh ON sh.name = o.ship
       WHERE o.result = 'sunk'
    )
    AS s ON s.class = c.class OR s.ship = c.class
 GROUP BY c.class
select  isnull(class, 0) as class;    

--task11 (lesson4)
-- �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)

--task12 (lesson4)
-- �������: ������� ����� ������� classes (�������� classes_with_flag) � �������� � ��� flag: ���� ���������� ������ ������ ��� ����� 9 - �� 1, ����� 0
CREATE TABLE classes_with_flag AS classes,
case 
    when count(numGuns) >= 9
    then 1
    else 0
end flag;  

--task13 (lesson4)
-- �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count)
select count(class), country
from classes
group by country
order by count;  


--task14 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ���������� � ����� "O" ��� "M".
select count(name)
from ships
where name like 'O%' or name like 'M%';  

--task15 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ������� �� ���� ����.
select count(name)
from ships
where name like '% %';  

--task16 (lesson4)
-- �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)
select count(name), launched as year
from ships 
group by year
order by count;       

