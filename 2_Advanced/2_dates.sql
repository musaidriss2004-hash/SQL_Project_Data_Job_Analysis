SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date:: DATE as date 
-- DATE as date removes time so we only want date only
FROM
    job_postings_fact;

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' as date_time 
-- Data was UTC timezone (Luke told) and want it at EST timezone
FROM
    job_postings_fact
LIMIT 5;

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' as date_time,
    EXTRACT (MONTH FROM job_posted_date) AS date_month,
    EXTRACT (YEAR FROM job_posted_date) AS date_year
-- Extract will tell us what month/year it is from date_time
FROM
    job_postings_fact
LIMIT 5;

SELECT
    COUNT(job_id) as job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY
    job_posted_count DESC;

-- Practice Problem 1 (2hr 20 min)
SELECT
    job_schedule_type,
    AVG(salary_year_avg) AS salary_year_avg,
    AVG(salary_hour_avg) AS salary_hour_avg
FROM
    job_postings_fact
WHERE
    job_posted_date > '2023-06-01'
GROUP BY
    job_schedule_type;

-- Practice Problem 2
SELECT
    EXTRACT(MONTH FROM (job_posted_date AT TIME ZONE'UTC' 
    AT TIME ZONE 'America/New_York')) AS job_month,
    COUNT(job_id) AS number_of_postings
FROM
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date) = '2023'
GROUP BY
    job_month
ORDER BY
    job_month;

-- Practice Problem 3
SELECT
    job_postings.job_id,
    company.name AS company_name,
    job_postings.job_title,
    job_postings.job_health_insurance
-- Join job postings with company details using company_id
FROM job_postings_fact AS job_postings
JOIN company_dim AS company
    ON job_postings.company_id = company.company_id
WHERE
    EXTRACT(QUARTER FROM job_postings.job_posted_date) = 2
    AND EXTRACT(YEAR FROM job_postings.job_posted_date) = 2023
    AND job_postings.job_health_insurance = TRUE;