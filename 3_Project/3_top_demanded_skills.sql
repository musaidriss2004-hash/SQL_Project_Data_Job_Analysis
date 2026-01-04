/*
Question: What are the most in-demand skills for data scientist?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for data scientist.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist' 
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5

/*
The query identifies the top 5 most in-demand skills for Data Scientists working 
from home. Python leads by a large margin with 10,390 postings, followed by SQL 
(7,488) and R (4,674), showing that strong programming and data-handling abilities 
are highly valued. Cloud skills like AWS (2,593) and data visualization tools like 
Tableau (2,458) also appear in the top 5, indicating that employers increasingly expect 
familiarity with cloud platforms and the ability to communicate insights visually. Overall,
 the results suggest that combining core programming skills with cloud and visualization 
 expertise is key for Data Scientists in today’s job market.
 */