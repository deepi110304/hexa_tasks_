CREATE DATABASE sql_practice_pack;
USE sql_practice_pack;
CREATE TABLE menu_items 
(
item_id INT PRIMARY KEY,
item_name VARCHAR(100),
category VARCHAR(50),
price DECIMAL(10,2),
available_qty INT
);
INSERT INTO menu_items VALUES
(1, 'Chicken Biryani', 'Main Course', 320, 25),
(2, 'Paneer Tikka', 'Starter', 240, 15),
(3, 'Masala Dosa', 'Breakfast', 120, 30),
(4, 'Veg Burger', 'Fast Food', 180, 10),
(5, 'Cold Coffee', 'Beverage', 150, 20),
(6, 'Chicken Burger', 'Fast Food', 220, 8),
(7, 'Idli', 'Breakfast', 80, 40),
(8, 'Fresh Lime', 'Beverage', 90, 0);
-- EXERCISE 1
SELECT * FROM menu_items;
-- EXERCISE 2
SELECT item_name, price from menu_items;
-- EXERCISE 3
INSERT INTO menu_items VALUES (9, 'Gobi 65', 'Starter', 260, 20);
-- EXERCISE 4
UPDATE menu_items SET price = 350.00 WHERE item_id = 1; 
-- EXERCISE 5
SET SQL_SAFE_UPDATES = 0;
UPDATE menu_items SET price = price * 1.10 WHERE category = 'Fast Food';
SET SQL_SAFE_UPDATES = 1;
-- EXERCISE 6
UPDATE menu_items SET available_qty = available_qty - 2  WHERE item_id = 4;
-- EXERCISE 7
DELETE FROM menu_items WHERE item_id = 8;
-- EXERCISE 8
SELECT * FROM menu_items WHERE price > 200;
-- EXERCISE 9
SELECT * FROM menu_items WHERE price BETWEEN 100 AND 250;
-- EXERCISE 10
SELECT * FROM menu_items WHERE category = 'Breakfast';
-- EXERCISE 11
SELECT * FROM menu_items WHERE category = 'Breakfast' OR category = 'Beverage';
-- EXERCISE 12
SELECT * FROM menu_items WHERE item_name LIKE '%Chicken%';
-- EXERCISE 13
SELECT * FROM menu_items ORDER BY price DESC;
-- EXERCISE 14
SELECT * FROM menu_items ORDER BY price DESC LIMIT 3;
-- EXERCISE 15
SELECT * FROM menu_items WHERE available_qty < 15;