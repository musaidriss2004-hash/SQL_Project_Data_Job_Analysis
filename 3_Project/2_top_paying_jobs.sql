/*
Question: What skills are required for the top-paying Data Scientist jobs?
- Use the top 10 highest-paying Data Scientist jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
    helping job seekers understand which skills to develop that allign with top salaries
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id= company_dim.company_id
    WHERE
        job_title_short = 'Data Scientist' AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC


/*
An analysis of the top 10 highest-paying Data Scientist roles shows that certain technical
 skills are strongly linked to higher salaries. Python and SQL stand out as the most 
 commonly required skills across these top positions, highlighting their importance for 
 advanced data science work.

Beyond these core skills, cloud technologies like AWS and GCP are often mentioned, 
especially in senior and leadership roles. This suggests that high-paying positions 
frequently involve deploying, scaling, and managing data solutions in cloud environments.

Many of the top-paying roles also require experience with big data tools such as Spark, 
Hadoop, and Cassandra. This indicates that the ability to work with large-scale data 
systems is a key factor for higher salaries.

While machine learning frameworks like PyTorch, TensorFlow, and scikit-learn are mentioned
less often, their presence in some top roles shows a need for specialized modeling skills
rather than general use across all positions.

Overall, the data shows that the highest-paying Data Scientist jobs value strong 
programming and data-querying skills, combined with cloud and big data expertise. 
These roles typically carry more technical responsibility and have a greater impact on 
overall systems, which is reflected in their higher pay.

*/