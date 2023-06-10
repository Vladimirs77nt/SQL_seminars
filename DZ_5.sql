-- ДОМАШНЯЯ РАБОТА К УРОКУ №5

USE lesson_05;

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT * FROM cars;

-- Задача 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов

 CREATE VIEW cars25
   AS
	SELECT *
	FROM cars
	WHERE cost <= 25000;

SELECT * FROM cars25;

-- Задача 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)

 ALTER VIEW cars25
   AS
	SELECT *
	FROM cars
	WHERE cost <= 30000;
    
SELECT * FROM cars25;

-- Задача 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)

 CREATE VIEW carsSkodaAudi
   AS
	SELECT *
	FROM cars
	WHERE name IN ("Skoda", "Audi");

SELECT * FROM carsSkodaAudi;

-----------------------------------------------------
/* Задача 4. Добавьте новый столбец под названием «время до следующей станции». Чтобы получить это значение, мы вычитаем время станций
для пар смежных станций. Мы можем вычислить это значение без использования оконной функции SQL, но это может быть очень сложно.
Проще это сделать с помощью оконной функции LEAD . Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат.
В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее. */

-- Создаем таблицу

DROP TABLE IF EXISTS schedule_stations;
CREATE TABLE schedule_stations
(
    train_id INT,
    station VARCHAR(45),
    station_time TIME
);

INSERT schedule_stations
VALUES
	(110, "San Francisc", "10:00:00"),
    (110, "Redwood City", "10:54:00"),
    (110, "Palo Alto", "11:02:00"),
    (110, "San Jose", "12:35:00"),
    (120, "San Francisc", "11:00:00"),
    (120, "Palo Alto", "12:49:00"),
    (120, "San Jose", "13:30:00");
    
SELECT * FROM schedule_stations;

-- Вариант 1 - просто выводим таблицу с дополнительным столбиком "time_to_next_stantion"
SELECT *,
	SUBTIME(LEAD (station_time, 1, "конечная станция") OVER(PARTITION BY train_id ORDER BY station_time), station_time)
		AS time_to_next_stantion
FROM schedule_stations;

-- Вариант 2 - создаем представление с дополнительным столбиком "time_to_next_stantion"       
CREATE VIEW schedulschedule_stations_extended
	AS
	SELECT *,
		SUBTIME(LEAD (station_time, 1, "конечная станция") OVER(PARTITION BY train_id ORDER BY station_time), station_time)
			AS time_to_next_stantion
	FROM schedule_stations;
    
SELECT * FROM schedulschedule_stations_extended;