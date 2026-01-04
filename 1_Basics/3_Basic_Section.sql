SELECT
	project_company,
    nerd_id,
    nerd_role,
    hours_rate AS rate_original, 
    hours_rate - 5 AS rate_drop, 
    hours_rate + 5 AS rate_hike,
   (hours_rate + 5) * hours_spent AS project_total
FROM 
	invoices_fact
WHERE
	project_total > 1000;

-- project total (after hike) = rate_hike * hours_spent

/*
'%' means modulus so using 10 % 8 returns 2 so if employee worked 10 hours the 
2 would mean he worked 2 hours beyond the standard 8 hour workday.
*/

SELECT
	activity_id,
    hours_spent, 
    hours_spent % 8 AS extra_hours
FROM
	invoices_fact
WHERE
	(hours_spent BETWEEN 8 AND 16) AND extra_hours > 0
ORDER BY
	hours_spent;
    
-- Practice Problem 1
SELECT
	activity_id,
    hours_spent, 
    hours_rate, 
    hours_spent + hours_rate AS time_cost_priority
FROM
	invoices_fact;
 
-- Practice Problem 2 
SELECT
	activity_id,
    hours_spent, 
    hours_rate,
    hours_spent / hours_rate AS efficiency_ratio
FROM
	invoices_fact;
