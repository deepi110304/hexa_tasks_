CREATE DATABASE telecom_assessment;
USE telecom_assessment;
CREATE TABLE customers
(
     customer_id INT PRIMARY KEY,
     customer_name VARCHAR(100),
     city VARCHAR(50),
     mobile VARCHAR(30),
     email VARCHAR(100)
);
INSERT INTO customers VALUES
(1, ' Arjun Rao ', 'Hyderabad', '98765-43210', ' ARJUN@GMAIL.COM '),
(2, 'SARA KHAN', 'Mumbai', '+91 99887 66554', 'sara@gmail.com'),
(3, 'Rohit Mehta ', 'Delhi', '9988 776 655', ''),
(4, 'Neha Singh', 'Hyderabad', '9876543210', 'neha@yahoo.com'),
(5, 'Imran Ali', 'Bangalore', '98765-AB210', NULL),
(6, 'Priya Nair', 'Pune', '9123456789', 'PRIYA@GMAIL.COM'),
(7, 'Kabir Shah', NULL, '9000011111', 'kabir@mail.com');
CREATE TABLE plans 
(
    plan_id INT PRIMARY KEY,
    plan_name VARCHAR(50),
    monthly_charge DECIMAL(10,2)
);
INSERT INTO plans VALUES
(101, 'Basic', 399),
(102, 'Standard', 599),
(103, 'Premium', 999),
(104, 'Unlimited', 1499),
(105, 'Business', 1999);
CREATE TABLE subscriptions 
(
   subscription_id INT PRIMARY KEY,
   customer_id INT,
   plan_id INT,
   start_date DATE,
   status VARCHAR(20)
);
INSERT INTO subscriptions VALUES
(1001, 1, 103, '2026-01-01', 'Active'),
(1002, 2, 102, '2026-01-15', 'Active'),
(1003, 3, 101, '2026-02-01', 'Inactive'),
(1004, 4, 104, '2026-02-10', 'Active'),
(1005, 5, 102, '2026-03-01', 'Active'),
(1006, 1, 105, '2026-04-01', 'Active'),
(1007, 6, NULL, '2026-04-15', 'Pending'),
(1008, 20, 103, '2026-05-01', 'Active');
CREATE TABLE payments 
(
    payment_id INT PRIMARY KEY,
    customer_id INT,
    payment_date DATE,
	amount DECIMAL(10,2)
);
INSERT INTO payments VALUES
(501, 1, '2026-01-05', 999),
(502, 2, '2026-01-18', 599),
(503, 1, '2026-02-05', 999),
(504, 3, '2026-02-10', 399),
(505, 4, '2026-02-15', 1499),
(506, 2, '2026-03-18', 599),
(507, 5, '2026-03-20', 599),
(508, 1, '2026-04-05', 1999),
(509, 4, '2026-04-15', 1499),
(510, 5, '2026-05-20', 599),
(511, 2, '2026-05-22', 599),
(512, 1, '2026-06-05', 1999);
-- BASIC CRUD 
SELECT customer_name, city, email from customers;
SELECT customer_name from customers WHERE city IN('Hyderabad', 'Mumbai');
SELECT * FROM customers WHERE customer_name LIKE '%a%';
INSERT INTO customers VALUES
(8, 'Neha Varma', 'Bangalore', '2345609876', 'neha90@gmail.com');
UPDATE customers SET city = 'Bangalore' WHERE customer_id = '6';
DELETE FROM customers WHERE customer_id = '8';
SELECT * FROM customers ORDER BY customer_name ASC;
-- AGGREGATION/ GROUP BY/ HAVING
SELECT COUNT(payment_id) AS total_payments, SUM(amount) AS total_amount_collected FROM payments;
SELECT customer_id, SUM(amount) AS total_payment_amount FROM payments GROUP BY customer_id;
SELECT c.customer_id, c.customer_name, SUM(p.amount) AS total_payments FROM customers c
INNER JOIN payments p ON c.customer_id = p.customer_id GROUP BY c.customer_id, c.customer_name HAVING SUM(p.amount) > 2000;
SELECT customer_id, AVG(amount) AS avg_payments FROM payments GROUP BY customer_id;
-- JOINs
SELECT c.customer_name, p.plan_name, p.monthly_charge, s.status FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id INNER JOIN plans p ON s.plan_id = p.plan_id;
SELECT c.*, s.subscription_id, s.status FROM customers c LEFT JOIN subscriptions s ON c.customer_id = s.customer_id;
SELECT s.* FROM subscriptions s LEFT JOIN customers c ON s.customer_id = c.customer_id
LEFT JOIN plans p ON s.plan_id = p.plan_id WHERE c.customer_id IS NULL OR p.plan_id IS NULL;
-- DATA Cleansing / RegEx
SELECT customer_id, TRIM(customer_name) AS cleaned_name, city, REGEXP_REPLACE(mobile, '[^0-9]', '') AS cleaned_mobile,
    CASE 
        WHEN TRIM(email) = '' THEN NULL 
        ELSE LOWER(TRIM(email)) 
    END AS cleaned_email FROM customers;
SELECT *  FROM customers WHERE mobile REGEXP '[a-zA-Z]';