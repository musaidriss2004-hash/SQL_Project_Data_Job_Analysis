SELECT *
FROM january_jobs;

SELECT *
FROM february_jobs;

SELECT *
FROM march_jobs;

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION
-- Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION
-- Get jobs and companies from March
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs;

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL
-- Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL
-- Get jobs and companies from March
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs;

-- Practice Problem 1 (2hr 54min)
-- Jobs with skills
SELECT
    j.job_id,
    s.skills,
    s.type AS skill_type
FROM
    job_postings_fact AS j
INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id
WHERE
    j.salary_year_avg > 70000
    AND j.job_posted_date BETWEEN '2023-01-01' AND '2023-03-01'

UNION ALL

-- Jobs without skills
SELECT
    j.job_id,
    NULL AS skills,
    NULL AS skill_type
FROM
    job_postings_fact AS j
WHERE
    j.salary_year_avg > 70000
    AND j.job_posted_date BETWEEN '2023-01-01' AND '2023-03-01'
    AND j.job_id NOT IN (
        SELECT job_id
        FROM skills_job_dim
    );

/*
Find job postings from the first quarter that have a greater salary than $70k
- Combine job posting tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary > $70,000
*/

SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_postings
WHERE
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg