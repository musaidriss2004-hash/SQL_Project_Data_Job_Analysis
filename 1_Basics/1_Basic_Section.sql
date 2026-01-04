SELECT job_title_short, job_location 
-- This chooses these 2 columns from job_posting_fact.
-- '*' means it selects all columns
FROM 
	job_postings_fact
LIMIT 5; -- It retrieves 5 rows

SELECT DISTINCT
	job_title_short
FROM
job_postings_fact; -- This input shows each different job title without repeats

SELECT DISTINCT     -- semi colon means 2 inputs in 1 page but only runs last one in this editor
	salary_year_avg
FROM
	job_postings_fact; -- Each unique salary value from each job.
    
 SELECT
	job_title_short,
    job_location,
    job_via,
    salary_year_avg
FROM
	job_postings_fact
WHERE
	job_title_short = 'Data Analyst'
ORDER BY
	salary_year_avg DESC;
 -- select 4 columns from job_posting_fact and where selects jobs called Data Analyst
 -- if after WHERE salary_year_avg > 90000 would select jobs with salary greater than 90000
 -- salary_year_avg DESC means descending order and ASC for ascending order
 
  SELECT
	job_title_short,
    job_location,
    job_via,
    salary_year_avg
FROM
	job_postings_fact
WHERE -- if did WHERE NOT and line of code after it'd negate as 2 negatives = positive
	job_via <> 'via Ai-Jobs.net';
-- Alternatively, do WHERE NOT job_via = 'via Ai-Jobs.net' means same thing
-- '>' = greater than '>=' is greater than and equal to and same for less than

SELECT
	job_title_short,
    job_location,
    job_via,
    salary_year_avg
FROM
	job_postings_fact
WHERE 
	job_title_short = 'Data Analyst'
    AND salary_year_avg > 100000
ORDER BY
	salary_year_avg;
 -- Do same but with 'or' operator below to get either conditions after WHERE

SELECT
	job_title_short,
    job_location,
    job_via,
    salary_year_avg
FROM
	job_postings_fact
WHERE  				-- BETWEEN operator to get it in range
	salary_year_avg BETWEEN 100000 AND 200000
ORDER BY
	salary_year_avg;
    
 SELECT
	job_title_short,
    job_location,
    job_via,
    salary_year_avg
FROM
	job_postings_fact
WHERE  				
	job_title_short IN ('Data Analyst','Data Engineer','Data Scientist')
ORDER BY
	salary_year_avg;
-- IN operator will result in jobs which include these 3 above. 

/* Practice Problem 1
Question: Get Job details for BOTH 'Data Analyst' or 'Business Analyst' positions:

1. For Data Analyst, i want jobs over 100K
2. For Business Analyst, i want jobs over 70K

Only include jobs located in either:

1. Boston or MA
2. Anywhere (Remote Jobs)

*/ 

SELECT
	job_title_short,
    job_location,
    job_via,
    salary_year_avg
FROM
	job_postings_fact
WHERE				-- brackets executed are like BIDMAS 
	job_location IN ('Boston', 'MA', 'Anywhere') AND
    (
    	(job_title_short = 'Data Analyst' AND salary_year_avg > 100000) OR
    	(job_title_short = 'Business Analyst' AND salary_year_avg > 70000)
    );
 
