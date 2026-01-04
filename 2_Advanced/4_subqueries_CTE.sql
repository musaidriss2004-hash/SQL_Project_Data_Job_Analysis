SELECT *
FROM ( -- SubQuery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date ) = 1
) AS january_jobs;
-- SubQuery ends here

WITH january_jobs AS ( -- CTE definition starts here
    SELECT *
    FROM job_postings_fact
     WHERE EXTRACT(MONTH FROM job_posted_date ) = 1
) -- CTE definition ends here

SELECT *
FROM january_jobs

-- The outer query selects company_id and company_name from company_dim.
-- The WHERE clause filters companies to only include those whose company_id
-- appears in the subquery result (i.e., companies that have at least one job
-- where job_no_degree_mention = TRUE). 
-- Essentially, it returns all companies that have jobs not requiring a degree.

SELECT
    company_id,
    name AS company_name
FROM 
    company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
    ORDER BY
        company_id
);

/*
Find the companies that have the most job openings.
- Get the total number of job postings per company id
- Return the total number of jobs with the company name
*/

WITH company_job_count AS (
SELECT
    company_id,
    COUNT(*) AS total_jobs
FROM
    job_postings_fact
GROUP BY
    company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC

-- Practice Problem 1 (2hr 42min)
WITH top_skills AS (
    SELECT
        skills.skill_id,
        skills.skills AS skill_name,
        COUNT(sjd.job_id) AS job_count
    FROM
        skills_dim AS skills
        JOIN skills_job_dim AS sjd ON skills.skill_id = sjd.skill_id
    GROUP BY
        skills.skill_id, skills.skills
)

SELECT
    skill_name,
    job_count
FROM
    top_skills
ORDER BY
    job_count DESC
LIMIT 5;


-- Practice Problem 2
WITH company_job_count AS (
    SELECT
        c.company_id,
        c.name AS company_name,
        COUNT(j.job_id) AS total_jobs_postings
    FROM
        company_dim AS c
    LEFT JOIN
        job_postings_fact AS j
    ON
        c.company_id = j.company_id
    GROUP BY
        c.company_id, c.name
)

SELECT
    company_id,
    company_name,
    CASE
        WHEN total_jobs_postings < 10 THEN 'Small'
        WHEN total_jobs_postings BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size
FROM
    company_job_count
ORDER BY
    total_jobs_postings ASC;

/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings required the skill
*/

WITH remote_job_skills AS (
SELECT
    skill_id,
    COUNT(*) AS skill_count
 -- job_postings.job_work_from_home here to verify WHERE comment is actually correct
FROM
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE
    job_postings.job_work_from_home = TRUE AND
    job_postings.job_title_short = 'Data Analyst'
GROUP BY
    skill_id
)

SELECT 
    skills.skill_id,
    skills as skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills on skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;