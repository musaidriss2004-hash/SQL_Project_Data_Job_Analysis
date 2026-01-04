/*
Question: What are the top-paying data scientist job?
- Identify the top 10 highest-paying Data Scientist roles that are available remotely.
- Focuses on job postings with specifies salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Scientists, offering insights into
employment opportunities
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id= company_dim.company_id
WHERE
    job_title_short = 'Data Scientist' AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

/*
Very high salary ceiling: Remote Data Scientist roles can pay exceptionally well, with top
 salaries reaching $550,000 per year, far above typical market averages.

Seniority matters: The highest-paying roles are predominantly senior or leadership positions
 (e.g. Staff, Head of Data Science, Director, Distinguished Data Scientist), indicating 
 that experience and strategic responsibility drive compensation.

Strong finance & analytics presence: Firms like Selby Jennings and Algo Capital Group 
suggest that quantitative finance and advanced analytics roles offer some of the highest 
pay.

Remote flexibility at the top end: All roles are listed as “Anywhere”, showing that fully 
remote work is common even for top-paying positions.

Industry diversity: High salaries span multiple sectors, including finance, tech 
(Reddit, Walmart), product analytics, and energy, highlighting broad demand for advanced 
data science skills.

Leadership premium: Multiple listings for Head/Director-level roles confirm a clear pay 
premium for managing teams and shaping data strategy.

Overall, my results show that remote Data Scientist roles at senior and leadership 
levels offer extremely competitive compensation, especially in finance-driven and 
analytics-heavy organizations.
*/