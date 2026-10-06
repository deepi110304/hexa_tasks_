CREATE TABLE staff_hierarchy 
(
employee_id INT PRIMARY KEY,
employee_name VARCHAR(100),
manager_id INT,
designation VARCHAR(100)
);
INSERT INTO staff_hierarchy VALUES
(1, 'Raj Malhotra', NULL, 'CEO'),
(2, 'Meera Shah', 1, 'CTO'),
(3, 'Vikram Rao', 1, 'Sales Director'),
(4, 'Aman Khan', 2, 'Engineering Manager'),
(5, 'Sara Ali', 2, 'Data Manager'),
(6, 'Rohit Das', 4, 'Developer'),
(7, 'Priya Singh', 4, 'Developer'),
(8, 'Kabir Ahmed', 5, 'Data Engineer'),
(9, 'Neha Rao', 5, 'Data Analyst'),
(10, 'Imran Sheikh', 3, 'Sales Manager'),
(11, 'Pooja Jain', 10, 'Sales Executive');
-- EXERCISE 1
SELECT * FROM staff_hierarchy WHERE manager_id IS NULL;
-- EXERCISE 2
SELECT * FROM staff_hierarchy WHERE manager_id = 1;
-- EXERCISE 3
SELECT * FROM staff_hierarchy WHERE manager_id = 2;
-- EXERCISE 4
WITH RECURSIVE OrgHierarchy AS (
    SELECT employee_id, employee_name, manager_id, designation
    FROM staff_hierarchy
    WHERE manager_id IS NULL
    UNION ALL
    SELECT sh.employee_id, sh.employee_name, sh.manager_id, sh.designation
    FROM staff_hierarchy sh
    INNER JOIN OrgHierarchy oh ON sh.manager_id = oh.employee_id
)
SELECT * FROM OrgHierarchy;
-- EXERCISE 5
WITH RECURSIVE OrgHierarchy AS (
    SELECT employee_id, employee_name, manager_id, designation, 1 AS h_level
    FROM staff_hierarchy
    WHERE manager_id IS NULL
    UNION ALL
    SELECT sh.employee_id, sh.employee_name, sh.manager_id, sh.designation, oh.h_level + 1
    FROM staff_hierarchy sh
    INNER JOIN OrgHierarchy oh ON sh.manager_id = oh.employee_id
)
SELECT * FROM OrgHierarchy;
-- EXERCISE 6
WITH RECURSIVE MeeraReports AS (
    SELECT employee_id, employee_name, manager_id, designation
    FROM staff_hierarchy
    WHERE employee_id = 2
    UNION ALL
    SELECT sh.employee_id, sh.employee_name, sh.manager_id, sh.designation
    FROM staff_hierarchy sh
    INNER JOIN MeeraReports mr ON sh.manager_id = mr.employee_id
)
SELECT * FROM MeeraReports WHERE employee_id <> 2;
-- EXERCISE 7
WITH RECURSIVE AmanReports AS (
    SELECT employee_id, employee_name, manager_id, designation
    FROM staff_hierarchy
    WHERE employee_id = 4
    UNION ALL
    SELECT sh.employee_id, sh.employee_name, sh.manager_id, sh.designation
    FROM staff_hierarchy sh
    INNER JOIN AmanReports ar ON sh.manager_id = ar.employee_id
)
SELECT * FROM AmanReports WHERE employee_id <> 4;
-- EXERCISE 8
SELECT emp.employee_name AS employee, mgr.employee_name AS manager FROM staff_hierarchy emp
LEFT JOIN staff_hierarchy mgr ON emp.manager_id = mgr.employee_id;
-- EXERCISE 9
WITH RECURSIVE OrgHierarchy AS (
    SELECT employee_id, 1 AS h_level
    FROM staff_hierarchy
    WHERE manager_id IS NULL
    UNION ALL
    SELECT sh.employee_id, oh.h_level + 1
    FROM staff_hierarchy sh
    INNER JOIN OrgHierarchy oh ON sh.manager_id = oh.employee_id
)
SELECT h_level, COUNT(*) AS employee_count FROM OrgHierarchy GROUP BY h_level;
-- EXERCISE 10
WITH RECURSIVE DownwardOrg AS 
(
    SELECT employee_id, employee_name, manager_id, designation, CAST(employee_name AS CHAR(255)) AS path
    FROM staff_hierarchy
    WHERE manager_id IS NULL
    UNION ALL
    SELECT sh.employee_id, sh.employee_name, sh.manager_id, sh.designation, CONCAT(do.path, ' -> ', sh.employee_name)
    FROM staff_hierarchy sh
    INNER JOIN DownwardOrg do ON sh.manager_id = do.employee_id
)
SELECT employee_id, designation, path FROM DownwardOrg;