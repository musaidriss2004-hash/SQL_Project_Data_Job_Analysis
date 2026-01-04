SELECT
	project_id,
    hours_spent,
    hours_rate AS rate_original,
    hours_rate + 5 AS rate_hike,
    SUM(hours_spent * hours_rate) AS project_original_cost, 
    SUM(hours_spent * (hours_rate + 5)) AS project_projected_cost
FROM
	invoices_fact
GROUP BY
	project_id

/* 
- Calculate the total earnings (hours_spent* hours_rate) per project
- Calculate a scenario where the hourly rate increases by $5 
*/ 