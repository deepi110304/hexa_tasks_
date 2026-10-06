CREATE TABLE insurance_claims 
(
claim_id INT PRIMARY KEY,
customer_name VARCHAR(100),
insurance_type VARCHAR(50),
claim_amount DECIMAL(12,2),
branch VARCHAR(50)
);
INSERT INTO insurance_claims VALUES
(1, 'Ajay Kumar', 'Health', 75000, 'Hyderabad'),
(2, 'Meena Shah', 'Motor', 45000, 'Mumbai'),
(3, 'Rohit Jain', 'Health', 125000, 'Hyderabad'),
(4, 'Sara Ali', 'Travel', 30000, 'Delhi'),
(5, 'Vikas Rao', 'Motor', 85000, 'Mumbai'),
(6, 'Nisha Singh', 'Health', 60000, 'Delhi'),
(7, 'Imran Khan', 'Travel', 55000, 'Hyderabad'),
(8, 'Pooja Patel', 'Motor', 40000, 'Delhi'),
(9, 'Karan Mehta', 'Health', 150000, 'Mumbai'),
(10, 'Farah Ahmed', 'Travel', 35000, 'Hyderabad');
-- EXERCISE 1
WITH TypeClaims AS 
(
    SELECT insurance_type, SUM(claim_amount) AS total_amount 
    FROM insurance_claims 
    GROUP BY insurance_type
)
SELECT * FROM TypeClaims;
-- EXERCISE 2
WITH BranchClaims AS (
    SELECT branch, SUM(claim_amount) AS total_amount 
    FROM insurance_claims 
    GROUP BY branch
)
SELECT * FROM BranchClaims;

-- EXERCISE 3
WITH TypeClaims AS (
    SELECT insurance_type, SUM(claim_amount) AS total_amount 
    FROM insurance_claims 
    GROUP BY insurance_type
)
SELECT * FROM TypeClaims WHERE total_amount > 200000;
-- EXERCISE 4
WITH AvgClaimValue AS 
(
    SELECT AVG(claim_amount) AS overall_avg FROM insurance_claims
)
SELECT * FROM insurance_claims WHERE claim_amount > (SELECT overall_avg FROM AvgClaimValue);
-- EXERCISE 5
WITH RankedTypes AS 
(
    SELECT insurance_type, SUM(claim_amount) AS total_amount,
           DENSE_RANK() OVER(ORDER BY SUM(claim_amount) DESC) AS ranking
    FROM insurance_claims 
    GROUP BY insurance_type
)
SELECT * FROM RankedTypes;
-- EXERCISE 6
WITH TotalStats AS 
(
    SELECT SUM(claim_amount) AS total_spend FROM insurance_claims
),
CountStats AS (
    SELECT COUNT(*) AS claim_count FROM insurance_claims
)
SELECT * FROM TotalStats CROSS JOIN CountStats;
-- EXERCISE 7
SELECT * FROM insurance_claims ic_outer
WHERE claim_amount > 
(
    SELECT AVG(ic_inner.claim_amount) 
    FROM insurance_claims ic_inner 
    WHERE ic_inner.insurance_type = ic_outer.insurance_type
);
-- EXERCISE 8
SELECT * FROM insurance_claims ic_outer
WHERE claim_amount > 
(
    SELECT AVG(ic_inner.claim_amount) 
    FROM insurance_claims ic_inner 
    WHERE ic_inner.branch = ic_outer.branch
);
-- EXERCISE 9
SELECT * FROM insurance_claims ic_outer
WHERE claim_amount = 
(
    SELECT MAX(ic_inner.claim_amount) 
    FROM insurance_claims ic_inner 
    WHERE ic_inner.insurance_type = ic_outer.insurance_type
);
-- EXERCISE 10
SELECT customer_name, claim_amount, branch
FROM insurance_claims ic_outer
WHERE claim_amount > (
    SELECT AVG(ic_inner.claim_amount) 
    FROM insurance_claims ic_inner 
    WHERE ic_inner.branch = ic_outer.branch
);