CREATE TABLE call_performance 
(
call_id INT PRIMARY KEY,
agent_name VARCHAR(100),
team VARCHAR(50),
calls_handled INT,
customer_rating DECIMAL(3,2),
performance_date DATE
);
INSERT INTO call_performance VALUES
(1, 'Aman', 'Alpha', 42, 4.50, '2026-09-01'),
(2, 'Sara', 'Alpha', 38, 4.70, '2026-09-01'),
(3, 'Ravi', 'Beta', 50, 4.20, '2026-09-01'),
(4, 'Neha', 'Beta', 45, 4.80, '2026-09-01'),
(5, 'Aman', 'Alpha', 48, 4.60, '2026-09-02'),
(6, 'Sara', 'Alpha', 44, 4.50, '2026-09-02'),
(7, 'Ravi', 'Beta', 46, 4.30, '2026-09-02'),
(8, 'Neha', 'Beta', 52, 4.90, '2026-09-02'),
(9, 'Kabir', 'Alpha', 41, 4.40, '2026-09-01'),
(10, 'Kabir', 'Alpha', 49, 4.60, '2026-09-02'),
(11, 'Pooja', 'Beta', 45, 4.70, '2026-09-01'),
(12, 'Pooja', 'Beta', 50, 4.80, '2026-09-02');
-- EXERCISE 1
SELECT *, SUM(calls_handled) OVER() AS total_calls_overall FROM call_performance;
-- EXERCISE 2
SELECT *, SUM(calls_handled) OVER(PARTITION BY team) AS team_total_calls FROM call_performance;
-- EXERCISE 3
SELECT *, AVG(calls_handled) OVER(PARTITION BY team) AS team_avg_calls FROM call_performance;
-- EXERCISE 4
SELECT *, AVG(customer_rating) OVER(PARTITION BY team) AS team_avg_rating FROM call_performance;
-- EXERCISE 5
SELECT *, SUM(calls_handled) OVER(PARTITION BY agent_name ORDER BY performance_date) AS cumulative_agent_calls FROM call_performance;
-- EXERCISE 6
SELECT *, SUM(calls_handled) OVER(PARTITION BY team ORDER BY performance_date) AS cumulative_team_calls FROM call_performance;
-- EXERCISE 7
SELECT *, calls_handled - AVG(calls_handled) OVER(PARTITION BY team) AS variance_from_team_avg FROM call_performance;
-- EXERCISE 8
SELECT *, LAG(calls_handled, 1) OVER(PARTITION BY agent_name ORDER BY performance_date) AS previous_day_calls FROM call_performance;
-- EXERCISE 9
SELECT *, calls_handled - LAG(calls_handled, 1) OVER(PARTITION BY agent_name ORDER BY performance_date) AS call_difference FROM call_performance;
-- EXERCISE 10
SELECT *, SUM(calls_handled) OVER(PARTITION BY agent_name) AS total_agent_calls FROM call_performance;