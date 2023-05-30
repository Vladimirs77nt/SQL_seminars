USE lesson_02;

CREATE TABLE IF NOT EXISTS sales (
  id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  order_data DATE,
  count_product INT UNSIGNED
);

INSERT sales (
  order_data, count_product)
VALUES 
  ('2022-01-01', 156),
  ('2022-01-02', 180),
  ('2022-01-03', 21),
  ('2022-01-04', 124),
  ('2022-01-05', 341);
  
SELECT * FROM sales;

SELECT id,
CASE
	WHEN count_product < 100 THEN "Маленький заказ"
    WHEN count_product > 300 THEN "Большой заказ"
    ELSE "Средний заказ"
END AS "Тип заказа"
FROM sales;

CREATE TABLE IF NOT EXISTS orders (
  id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  employee_id VARCHAR(10) UNIQUE NOT NULL,
  amount DECIMAL(10,2),
  order_status VARCHAR(10) NOT NULL
);

INSERT orders (
  employee_id, amount, order_status)
VALUES 
  ('e03', 15.00, "OPEN"),
  ('e01', 25.50, "OPEN"),
  ('e05', 100.70, "CLOSED"),
  ('e02', 22.18, "OPEN"),
  ('e04', 9.50, "CANCELLED");
  
SELECT * FROM orders;

SELECT *,
CASE
	WHEN order_status = "OPEN" THEN "Order is in open state"
    WHEN order_status = "CLOSED" THEN "Order is closed"
    ELSE "Order is cancelled"
END AS "full_order_status"
FROM orders;