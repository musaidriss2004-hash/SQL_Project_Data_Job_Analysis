SELECT
	job_id,
    job_title,
	job_title_short,
    job_location
FROM
	job_postings_fact
WHERE
	job_title LIKE '%Business%Analyst%'; 
-- '%' means 0, 1 or more characters
-- shows roles which have analyst in before and after denoted by % sign respectively
-- '%Analyst%' would show roles that have Analyst in job_title anywhere

SELECT
	job_id,
    job_title,
	job_title_short,
    job_location
FROM
	job_postings_fact
WHERE
	job_title LIKE '%Business_Analyst%'; 
    /* 
    '_' = underscore represents one single character so if only want but we added
    percentage sign on either side so any characters before Business_Analyst can be
    in the job title and can see if run.
  	*/
-- Practice Problem 1 
SELECT 
	company_id, name
FROM 
	company_dim
WHERE
	name LIKE '%Tech%';    -- anything that involves Tech
-- Practice Problem 2
SELECT
	job_id,
    job_title,
	job_posted_date
FROM
	job_postings_fact
WHERE
	job_title LIKE '%Engineer_';
-- exactly one character after engineer and anything before

SELECT
	jpc.job_title_short AS job_title,
    jpc.job_location AS location,
    jpc.job_via AS online_platform,
    jpc.salary_year_avg AS salary
FROM
	job_postings_fact AS jpc;
-- dont need jpc for this example so could remove but needed later to join multiple tables
    
 -- Practice Problem 1
 SELECT
	jpc.job_id,
    jpc.job_title_short,
    jpc.job_location,
    jpc.job_via AS job_posted_site,
    jpc.job_posted_date,
    jpc.salary_year_avg AS avg_yearly_salary
FROM
	job_postings_fact AS jpc;
    
 -- Practice Problem 2
 SELECT
 	job_title,
    job_location AS location,
    salary_year_avg AS salary
 FROM
 	job_postings_fact
WHERE
	(job_title LIKE '%Data%' OR job_title LIKE '%Business%') AND
    job_title LIKE '%Analyst%' AND
    job_title NOT LIKE '%Senior%';
/*
- Only get job titles that include either 'Data' or 'Business'
- Also include those with'Analyst' in any part of the title 
- Dont include any job titles with 'Senior' followed by any character
*/ 
