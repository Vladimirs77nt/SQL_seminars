-- ДОМАШНЕЕ ЗАДАНИЕ К СЕМИНАРУ 3

USE lesson_03;

-- ----------------------------------------------
-- 1 ЧАСТЬ

 -- ТАБЛИЦА 1: ПРОДАВЦЫ (SALESPEOPLE) 

DROP TABLE IF EXISTS salespeople;

CREATE TABLE salespeople (
  snum INT UNSIGNED PRIMARY KEY NOT NULL,
  sname VARCHAR(15),
  city VARCHAR(15),
  comm DECIMAL(3,2)
);

INSERT INTO salespeople(snum, sname, city, comm)
VALUES
(1001, "Peel", "London", 0.12),
(1002, "Serres", "San Jose", 0.13),
(1004, "Motika", "London", 0.11),
(1007, "Rifkin", "Barcelona", 0.15),
(1003, "Axelrod", "New York", 0.10);

 -- ТАБЛИЦА 2: ЗАКАЗЧИКИ (CUSTOMERS)  

DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  cnum INT UNSIGNED UNIQUE PRIMARY KEY NOT NULL,
  cname VARCHAR(15),
  city VARCHAR(15),
  rating INT UNSIGNED NOT NULL DEFAULT 0,
  snum INT UNSIGNED NOT NULL,
  FOREIGN KEY (snum) REFERENCES salespeople (snum)
);

INSERT INTO customers(cnum, cname, city, rating, snum)
VALUES
(2001, "Hoffman", "London", 100, 1001),
(2002, "Giovanni", "Rome", 200, 1003),
(2003, "Liu", "San Jose", 200, 1002),
(2004, "Grass", "Berlin", 300, 1002),
(2006, "Clemens", "London", 100, 1001),
(2008, "Cisneros", "San Jose", 300, 1007),
(2007, "Pereira", "Rome", 100, 1004);

-- ТАБЛИЦА 3: ЗАКАЗЫ (ORDERS)

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  onum INT UNSIGNED UNIQUE PRIMARY KEY NOT NULL,
  amt DECIMAL(8,2),
  odate DATE,
  cnum INT UNSIGNED NOT NULL,
  FOREIGN KEY (cnum) REFERENCES customers (cnum),
  snum INT UNSIGNED NOT NULL,
  FOREIGN KEY (snum) REFERENCES salespeople (snum)
);

INSERT INTO orders(onum, amt, odate, cnum, snum)
VALUES
(3001, 18.69, "1990-10-03", 2008, 1007),
(3003, 767.19, "1990-10-03", 2001, 1001),
(3002, 1900.10, "1990-10-03", 2007, 1004),
(3005, 5160.45, "1990-10-03", 2003, 1002),
(3006, 1098.16, "1990-10-03", 2008, 1007),
(3009, 1713.23, "1990-10-04", 2002, 1003),
(3007, 75.75, "1990-10-04", 2004, 1002),
(3008, 4723.00, "1990-10-05", 2006, 1001),
(3010, 1309.95, "1990-10-06", 2004, 1002),
(3011, 9891.88, "1990-10-06", 2006, 1001);

-- ЗАДАНИЯ:

-- 1. Напишите запрос, который вывел бы таблицу со столбцами в следующем порядке: city, sname, snum, comm. (к первой или второй таблице, используя SELECT)
SELECT city, sname, snum, comm FROM salespeople;

-- 2. Напишите команду SELECT, которая вывела бы оценку(rating), сопровождаемую именем каждого заказчика в городе San Jose. (“заказчики”)
SELECT cname, rating FROM customers
WHERE city = "San Jose";

-- 3. Напишите запрос, который вывел бы значения snum всех продавцов из таблицы заказов без каких бы то ни было повторений.
--    (уникальные значения в  “snum“ “Продавцы”)
SELECT DISTINCT snum AS "Продавцы snum" FROM orders;

-- 4*. Напишите запрос, который бы выбирал заказчиков, чьи имена начинаются с буквы G.
--     Используется оператор "LIKE": (“заказчики”) https://dev.mysql.com/doc/refman/8.0/en/string-comparison-functions.html
SELECT * FROM customers
WHERE cname LIKE 'G%';

-- 5. Напишите запрос, который может дать вам все заказы со значениями суммы выше чем $1,000. (“Заказы”, “amt”  - сумма)
SELECT * FROM orders
WHERE amt>1000;

-- 6. Напишите запрос который выбрал бы наименьшую сумму заказа.
-- (Из поля “amt” - сумма в таблице “Заказы” выбрать наименьшее значение)
SELECT * FROM orders
WHERE amt = (SELECT MIN(amt) FROM orders);

-- 7. Напишите запрос к таблице “Заказчики”, который может показать всех заказчиков, у которых рейтинг больше 100 и они
--    находятся не в Риме.
SELECT * FROM customers
WHERE rating>100 and city != "Rome";


-- ----------------------------------------------
-- 2 ЧАСТЬ

DROP TABLE IF EXISTS staff;

CREATE TABLE IF NOT EXISTS staff (
  id INT AUTO_INCREMENT PRIMARY KEY, 
  first_name VARCHAR(45), 
  last_name VARCHAR(45), 
  post VARCHAR(45), 
  seniority INT, 
  -- DECIMAL(общее количество знаков, количество знаков после запятой)
  -- DECIMAL(5,2) будут числа от -999.99 до 999.99
  salary DECIMAL(8, 2), 
  -- это числа от -999999.99 до 999999.99
  age INT
);

INSERT  staff (first_name, last_name, post, seniority, salary, age)
VALUES
	 ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
	 ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
	 ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
	 ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
	 ('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
	 ('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
	 ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
	 ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
	 ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
	 ('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
	 ('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
	 ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);
     
SELECT * FROM staff;

-- 1. Отсортируйте поле “зарплата” в порядке убывания и возрастания
-- 1.1. сортировка по возрастанию зарплаты
SELECT * FROM staff
ORDER BY salary;
-- 1.2. сортировка по убыванию зарплаты
SELECT * FROM staff
ORDER BY salary DESC;

-- 2. Отсортируйте по возрастанию поле “Зарплата” и выведите 5 строк с наибольшей заработной платой (возможен подзапрос)
SELECT * FROM staff
ORDER BY salary
LIMIT 5;

-- 3. Выполните группировку всех сотрудников по специальности , суммарная зарплата которых превышает 100000
SELECT post as "Специальность", SUM(salary) as "Суммарная зарплата" FROM staff
GROUP BY post
HAVING SUM(salary)>100000;