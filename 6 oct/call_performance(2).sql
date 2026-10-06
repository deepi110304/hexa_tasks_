-- EXERCISE 1
SELECT *, RANK() OVER(ORDER BY calls_handled DESC) AS global_rank FROM call_performance;
-- EXERCISE 2
SELECT *, ROW_NUMBER() OVER(ORDER BY calls_handled DESC) AS record_number FROM call_performance;
-- EXERCISE 3
SELECT *, RANK() OVER(ORDER BY calls_handled DESC) AS standard_rank FROM call_performance;
-- EXERCISE 4
SELECT *, DENSE_RANK() OVER(ORDER BY calls_handled DESC) AS continuous_rank FROM call_performance;
-- EXERCISE 5
SELECT *, 
       ROW_NUMBER() OVER(ORDER BY calls_handled DESC) AS row_num,
       RANK() OVER(ORDER BY calls_handled DESC) AS rnk,
       DENSE_RANK() OVER(ORDER BY calls_handled DESC) AS dense_rnk
FROM call_performance;
-- EXERCISE 6
SELECT *, RANK() OVER(PARTITION BY team ORDER BY calls_handled DESC) AS team_rank FROM call_performance;
-- EXERCISE 7
SELECT *, RANK() OVER(ORDER BY customer_rating DESC) AS rating_rank FROM call_performance;
-- EXERCISE 8
WITH RankedTeamPerformance AS 
(
    SELECT *, DENSE_RANK() OVER(PARTITION BY team ORDER BY calls_handled DESC) AS rn
    FROM call_performance
)
SELECT * FROM RankedTeamPerformance WHERE rn <= 3;
-- EXERCISE 9
WITH RankedAgentDays AS 
(
    SELECT *, ROW_NUMBER() OVER(PARTITION BY agent_name ORDER BY calls_handled DESC, customer_rating DESC) AS rn
    FROM call_performance
)
SELECT * FROM RankedAgentDays WHERE rn = 1;
-- EXERCISE 10
WITH TotalAgentCalls AS 
(
    SELECT agent_name, SUM(calls_handled) AS aggregate_calls
    FROM call_performance
    GROUP BY agent_name
)
SELECT agent_name, aggregate_calls, RANK() OVER(ORDER BY aggregate_calls DESC) AS agent_rank FROM TotalAgentCalls;