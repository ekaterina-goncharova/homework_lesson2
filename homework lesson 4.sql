--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type
select model, maker, type 
from product;  


--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, у кого цена вышей средней PC - "1", у остальных - "0"
select *,
case 
    when price > (select avg(price) from pc)
    then 1
    else 0
end flag
from printer;  


--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)


select name 
from ships
where class is null;  

--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.


select name 
from battles 
where DATEPART(date) not in (select DATEPART(date)  
from battles join ships on DATEPART(date)=launched);  


--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.

select battle
from outcomes  
where ship in (select name from ships where class = 'kongo');  

--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag
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
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag
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
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model
select model
from product p
join printer pr
on p.model = pr.model
where price > (select avg(price) from printer where maker = 'D' and maker = 'C') and maker = 'A';  




--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)
Select avg(price)  from laptop inner join product on laptop.model = product.model  
where product.maker= 'A' 
union 
Select avg(price) from pc inner join product on pc.model = product.model  
where product.maker= 'A' 
union 
Select avg(price) from printer inner join product on printer.model = product.model  
where product.maker= 'A';  


--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. Во view: maker, count
CREATE VIEW count_products_by_makers AS
  SELECT maker, count(model) FROM product
  group by maker;    

--task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)
 

--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'

INSERT INTO printer_updated SELECT * FROM printer
delete from printer_updated
where maker = 'D';    

--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя (название printer_updated_with_makers)
create view printer_updated_with_makers as
select * from printer_updated;  

--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)

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
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)

--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: если количество орудий больше или равно 9 - то 1, иначе 0
CREATE TABLE classes_with_flag AS classes,
case 
    when count(numGuns) >= 9
    then 1
    else 0
end flag;  

--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)
select count(class), country
from classes
group by country
order by count;  


--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".
select count(name)
from ships
where name like 'O%' or name like 'M%';  

--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.
select count(name)
from ships
where name like '% %';  

--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)
select count(name), launched as year
from ships 
group by year
order by count;       

