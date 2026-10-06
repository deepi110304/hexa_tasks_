CREATE TABLE registrations 
(
registration_id INT PRIMARY KEY,
full_name VARCHAR(100),
email VARCHAR(100),
mobile VARCHAR(40),
city VARCHAR(50),
postal_code VARCHAR(20)
);
INSERT INTO registrations VALUES
(1, ' rohit sharma ', ' ROHIT@GMAIL.COM ', '+91-98765-43210', 'hyderabad', NULL), 
(2, 'SARA KHAN', 'sara@yahoo.com', '99887 66554', ' MUMBAI ', '400001'),
(3, ' amit patel ', '', '(040)99887766', 'Hyderabad', '500 032'),
(4, 'Neha Singh ', NULL, '9876543210', 'BANGALORE', '560001'),
(5, 'imran ali', 'IMRAN@MAIL.COM ', '91 9988772211', NULL, '500084'),
(6, 'Priya Rao', 'priya@gmail', '98765-AB210', 'Pune', '411001');
-- EXERCISE 1
SELECT REGEXP_REPLACE(full_name, '^\\s+|\\s+$', '') AS trimmed_name FROM registrations;
-- EXERCISE 2
SELECT UPPER(full_name) AS upper_name FROM registrations;
-- EXERCISE 3
SELECT LOWER(email) AS lower_email FROM registrations;
-- EXERCISE 4
SELECT NULLIF(TRIM(email), '') AS email_cleaned FROM registrations;
-- EXERCISE 5
SELECT REPLACE(REPLACE(mobile, ' ', ''), '-', '') AS clean_mobile FROM registrations;
-- EXERCISE 6
SELECT REGEXP_REPLACE(mobile, '[^0-9]', '') AS numeric_mobile FROM registrations;
-- EXERCISE 7
SELECT UPPER(city) AS standard_city FROM registrations;
-- EXERCISE 8
SELECT * FROM registrations WHERE city IS NULL;
-- EXERCISE 9
SELECT * FROM registrations WHERE email IS NULL OR TRIM(email) = '';
-- EXERCISE 10
SELECT * FROM registrations WHERE email REGEXP '@gmail\\.com';
-- EXERCISE 11
SELECT * FROM registrations WHERE email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$' OR email IS NULL;
-- EXERCISE 12
SELECT REGEXP_REPLACE(postal_code, '[^0-9]', '') AS clean_postal FROM registrations;
-- EXERCISE 13
SELECT * FROM registrations WHERE mobile REGEXP '[A-Za-z]';
-- EXERCISE 14
SELECT 
    UPPER(TRIM(full_name)) AS name,
    LOWER(NULLIF(TRIM(email), '')) AS email,
    REGEXP_REPLACE(mobile, '[^0-9]', '') AS mobile,
    UPPER(TRIM(city)) AS city
FROM registrations;
-- EXERCISE 15
CREATE TABLE cleaned_registrations AS
SELECT 
    registration_id,
    UPPER(TRIM(full_name)) AS full_name,
    LOWER(NULLIF(TRIM(email), '')) AS email,
    REGEXP_REPLACE(mobile, '[^0-9]', '') AS mobile,
    UPPER(TRIM(city)) AS city,
    REGEXP_REPLACE(postal_code, '[^0-9]', '') AS postal_code
FROM registrations;