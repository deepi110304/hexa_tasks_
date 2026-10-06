CREATE TABLE students (
student_id INT PRIMARY KEY,
student_name VARCHAR(100),
city VARCHAR(50)
);
INSERT INTO students VALUES
(1, 'Arun', 'Hyderabad'),
(2, 'Megha', 'Mumbai'),
(3, 'Zaid', 'Hyderabad'),
(4, 'Pooja', 'Pune'),
(5, 'Rohan', 'Delhi'),
(6, 'Sana', NULL),
(7, 'Vijay', 'Bangalore');
CREATE TABLE courses (
course_id INT PRIMARY KEY,
course_name VARCHAR(100),
fee DECIMAL(10,2)
);
INSERT INTO courses VALUES
(101, 'Python', 15000),
(102, 'Data Engineering', 25000),
(103, 'Power BI', 12000),
(104, 'Cloud Computing', 20000),
(105, 'Cyber Security', 22000),
(106, 'Machine Learning', 28000);
CREATE TABLE enrollments 
(
enrollment_id INT PRIMARY KEY,
student_id INT,
course_id INT,
enrollment_date DATE
);
INSERT INTO enrollments VALUES
(1001, 1, 101, '2026-09-01'),
(1002, 1, 102, '2026-09-03'),
(1003, 2, 103, '2026-09-04'),
(1004, 3, 102, '2026-09-05'),
(1005, 4, 104, '2026-09-06'),
(1006, 2, 101, '2026-09-07'),
(1007, 3, 105, '2026-09-08'),
(1008, 20, 102, '2026-09-09'),
(1009, 5, NULL, '2026-09-10');
-- EXERCISE 1
SELECT s.student_name, c.course_name FROM enrollments e INNER JOIN students s ON e.student_id = s.student_id 
INNER JOIN courses c ON e.course_id = c.course_id;
-- EXERCISE 2
SELECT s.student_name, s.city, c.course_name, c.fee FROM enrollments e INNER JOIN students s ON e.student_id = s.student_id
INNER JOIN courses c ON e.course_id = c.course_id;
-- EXERCISE 3
SELECT s.student_name FROM enrollments e INNER JOIN students s ON e.student_id = s.student_id
INNER JOIN courses c ON e.course_id = c.course_id WHERE c.course_name = 'Data Engineering';
-- EXERCISE 4
SELECT s.*, e.course_id FROM students s LEFT JOIN enrollments e ON s.student_id = e.student_id;
-- EXERCISE 5
SELECT s.* FROM students s LEFT JOIN enrollments e ON s.student_id = e.student_id WHERE e.student_id IS NULL;
-- EXERCISE 6
SELECT c.*, e.student_id FROM courses c LEFT JOIN enrollments e ON c.course_id = e.course_id;
-- EXERCISE 7
SELECT c.* FROM courses c LEFT JOIN enrollments e ON c.course_id = e.course_id WHERE e.course_id IS NULL;
-- EXERCISE 8
SELECT e.* FROM enrollments e LEFT JOIN students s ON e.student_id = s.student_id WHERE s.student_id IS NULL;
-- EXERCISE 9
SELECT e.* FROM enrollments e LEFT JOIN courses c ON e.course_id = c.course_id WHERE c.course_id IS NULL OR e.course_id IS NULL;
-- EXERCISE 10
SELECT s.student_name, COUNT(e.course_id) AS total_courses FROM students s LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name;
-- EXERCISE 11
SELECT s.student_name, IFNULL(SUM(c.fee), 0) AS total_fees FROM students s LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id GROUP BY s.student_id, s.student_name;
-- EXERCISE 12
SELECT s.student_name, COUNT(e.course_id) AS course_count FROM students s INNER JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name HAVING COUNT(e.course_id) > 1;
-- EXERCISE 13
SELECT c.course_name, COUNT(e.student_id) AS student_count FROM courses c INNER JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name HAVING COUNT(e.student_id) > 1;
-- EXERCISE 14
SELECT c.course_name, IFNULL(SUM(c.fee), 0) AS total_revenue FROM courses c LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;
-- EXERCISE 15
SELECT c.course_name, SUM(c.fee) AS total_revenue FROM courses c INNER JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name ORDER BY total_revenue DESC LIMIT 1;