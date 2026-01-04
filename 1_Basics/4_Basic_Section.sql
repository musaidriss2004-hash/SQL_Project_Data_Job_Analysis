-- Aggregation Section (1hr Mark) 

-- SUM(..) adds the whole column 
-- COUNT(*) counts how many rows
SELECT
	SUM(salary_year_avg) as salary_sum, 
    COUNT(*) AS count_rows
FROM
	job_postings_fact;
    
SELECT
	COUNT(DISTINCT job_title_short) AS job_type_total
FROM
	job_postings_fact;
-- Counts how many unique jobs 

SELECT
	job_title_short AS jobs,
    COUNT(job_title_short) AS job_count, 
	AVG(salary_year_avg) AS salary_avg, 
    MIN(salary_year_avg) AS salary_min,
    MAX(salary_year_avg) AS salary_max
FROM
	job_postings_fact
GROUP BY
	job_title_short
HAVING
	COUNT(job_title_short) > 100
ORDER BY
	salary_avg;

-- Practice Problem 1 (1hr 6 min mark)
SELECT
	(SUM(salary_year_avg) / COUNT(salary_year_avg)) AS avg_yearly_salary_remote
FROM
	job_postings_fact
WHERE
	(job_work_from_home = TRUE) AND (salary_year_avg IS NOT NULL);	

-- Practice Problem 2
SELECT -- COUNT(*) counts how many rows
	COUNT(*) AS total_jobs_with_health_insurance
FROM
	job_postings_fact
WHERE
	job_health_insurance = TRUE;
    
-- Practice Problem 3
SELECT
	job_country,
    COUNT(job_id) AS num_job_postings
FROM
	job_postings_fact
GROUP BY
	job_country;
 
-- NULL values 
SELECT
	job_title_short, 
    job_location,
    job_via,
    salary_year_avg
FROM
	job_postings_fact
WHERE
	salary_year_avg IS NOT NULL
ORDER BY
	salary_year_avg;

-- Practice Problem 1
SELECT
	skill_id, 
    skills
FROM
	skills_dim
WHERE
	type IS NULL;
-- reproduces nothing thus no type is null in data 

-- Practice Problem 2 
SELECT
	job_id, job_title, salary_year_avg, salary_hour_avg
FROM
	job_postings_fact
WHERE
	salary_year_avg IS NULL AND salary_hour_avg IS NULL;

-- JOIN Tables 
SELECT
	job_postings.job_id,
    job_postings.job_title_short AS title, 
    companies.name AS company
FROM job_postings_fact AS job_postings 
LEFT JOIN company_dim AS companies 
	ON job_postings.company_id = companies.company_id;
-- LEFT JOIN joins anything from left table and stuff that is in left and right table. 

SELECT
	job_postings.job_id,
    job_postings.job_title_short AS title, 
    companies.name AS company
FROM job_postings_fact AS job_postings 
RIGHT JOIN company_dim AS companies 
	ON job_postings.company_id = companies.company_id;
-- RIGHT JOIN joins anything from right table and stuff that is in left and right table. 

SELECT
	job_postings.job_id,
    job_postings.job_title, 
    skills_to_job.skill_id,
    skills.skills
FROM 
	job_postings_fact AS job_postings 
INNER JOIN skills_job_dim AS skills_to_job ON job_postings.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id;
-- INNER JOIN joins that is in both left and right table 
-- FULL OUTER JOIN joins everything from both tables (not really useful)

-- Practice Problem 1 (1hr 20 min mark)
SELECT
	job_postings.job_title, companies.name
FROM
	job_postings_fact AS job_postings
JOIN
	company_dim AS companies 
    ON job_postings.company_id = companies.company_id
WHERE
	job_postings.job_title LIKE '%Data Scientist%';
    
-- Practice Problem 2 
SELECT
	job_postings.job_title,
    job_postings.job_location,
    job_postings.job_health_insurance,
    skills.skills
FROM
	job_postings_fact AS job_postings 
LEFT JOIN
	skills_job_dim AS skills_to_job ON job_postings.job_id = skills_to_job.job_id
LEFT JOIN
	skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
WHERE
	job_postings.job_location = 'New York'
    AND job_postings.job_health_insurance = TRUE;
/*
First LEFT JOIN compare to job_postings but second do it skills_to_job as thats 
the result after running the First LEFT JOIN
*/

/* 
Practice Problem 5 (1hr 23 min) 
- Write a query to list each unique skill from skill_dim table 
- Count how many job postings mention each skill from the skills_to_job_dim table
- Calculate the average yearly salary for job postings associated with each skill
- Group the results by the skill name
- Order by the average salary
*/ 
SELECT
	skills.skills AS skill_name,
    COUNT(skills_to_job.job_id) AS number_of_job_postings,
    AVG(job_postings.salary_year_avg) AS average_salary_for_skill
FROM
	skills_dim AS skills 
LEFT JOIN skills_job_dim AS skills_to_job ON skills.skill_id = skills_to_job.skill_id
LEFT JOIN job_postings_fact AS job_postings ON skills_to_job.job_id = job_postings.job_id
GROUP BY
	skills.skills
ORDER BY
	average_salary_for_skill DESC