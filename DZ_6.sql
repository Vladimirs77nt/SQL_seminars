USE lesson_06;

-- Домашнее задание №6

-- Задача 1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DELIMITER //

-- ВАРИАНТ №1 - замудренный вариант, с использованием временных переменных,
-- использую простые арифметические действия и условия для проверок, чтобы отсечь нулевые значения
-- результирующая строка соединяется с помощью функции CONCAT

DROP PROCEDURE IF EXISTS seс_time1//
CREATE PROCEDURE seс_time1 (sectime INT)
BEGIN
  DECLARE times TEXT DEFAULT "";
  DECLARE days INT;
  DECLARE hours INT;
  DECLARE minutes INT;
  DECLARE seconds INT;
  SET days = sectime div (60*60*24);
  IF (days > 0) THEN SET times = CONCAT(times, CONVERT(days, CHAR(2)), " days ");
  END IF;
  SET sectime = sectime - days*60*60*24;
  SET hours = sectime div (60*60);
  IF (hours > 0) THEN SET times = CONCAT(times, CONVERT(hours, CHAR(2)), " hours ");
  END IF;
  SET sectime = sectime - hours*60*60;
  SET minutes = sectime div 60;
  IF (minutes > 0) THEN SET times = CONCAT(times, CONVERT(minutes, CHAR(2)), " minutes ");
  END IF;
  SET seconds = sectime - minutes*60;
  SELECT CONCAT(times, CONVERT(seconds, CHAR(2)), " seconds") as times;
END//

CALL seс_time1(123456)//


-- ВАРИАНТ №2 - полегче с форматированием:
-- Для решения использую встроенные функции TIME_FORMAT и SEC_TO_TIME, а также маски вывода времени
-- результирующая строка соединяется с помощью функции CONCAT

DROP PROCEDURE IF EXISTS seс_time2//
CREATE PROCEDURE seс_time2 (sectime INT)
BEGIN
  SELECT CONCAT(
    FLOOR(TIME_FORMAT(SEC_TO_TIME(sectime), '%H') / 24), ' days ',
    TIME_FORMAT(SEC_TO_TIME(sectime - ((sectime div (24*60*60))*24*60*60)), '%H'), ' hours ',
    TIME_FORMAT(SEC_TO_TIME(sectime), '%i'), ' minutes ',
    TIME_FORMAT(SEC_TO_TIME(sectime), '%s'), ' seconds '
  )
  AS times;
END//

CALL seс_time2(123456)//


-- Задача 2. Выведите только четные числа от 1 до 10. Пример: 2,4,6,8,10
-- Решаю задачу через функцию с аргументом 10, использую условие IF и функцию объединения строк CONCAT

DROP PROCEDURE IF EXISTS even_numbers//
CREATE PROCEDURE even_numbers (numbers INT)
BEGIN
  DECLARE count INT DEFAULT 1;				-- счетчик
  DECLARE result VARCHAR(45) DEFAULT "";	-- результирующая строка
  WHILE count <= numbers DO
	IF (count % 2 = 0) THEN SET result = CONCAT(result, CONVERT(count, CHAR(2)), ", ");
	END IF;
    SET count = count + 1;
  END WHILE;
  SET result = LEFT(result, LENGTH(result)-2); -- убираем в конце ", "
  SELECT result;
END//

CALL even_numbers(10)//