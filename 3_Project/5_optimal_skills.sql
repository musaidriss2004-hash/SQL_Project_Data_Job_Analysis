/*
Answer: What are the most optimal skills to learn (aka it's in high demand and high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Scientist roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career developent in data scientist
*/

WITH skills_demand AS (
    SELECT
       skills_dim.skill_id,
       skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Scientist' AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
), average_salary AS (
    SELECT
        skills_dim.skill_id, 
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Scientist' AND salary_year_avg IS NOT NULL
         AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
     avg_salary DESC,
    demand_count DESC
LIMIT 25

/*
Python dominates demand but not top salary
- Highest demand by far (763 postings) but comparatively lower average salary (~144k).
- Indicates Python is a baseline requirement, not a differentiator for pay.

High-paying languages with strong demand
- Go, Scala, C offer some of the highest salaries (~165k) with solid demand.
- These languages are strong differentiators and often linked to scalable, production-level 
systems.

Cloud & data engineering skills are optimal
- AWS, GCP, Snowflake, BigQuery, Redshift combine high demand and strong pay.
- Suggests Data Scientists with cloud and data platform expertise have better job 
security and compensation.

ML frameworks show excellent balance
- PyTorch, TensorFlow, Spark, scikit-learn have high demand and ~150k salaries.
- Confirms that applied ML and big data skills are core to high-value Data Scientist 
roles.

Workflow & orchestration tools stand out
- Airflow is relatively low demand but high-paying, signaling pipeline orchestration 
expertise is rewarded.

Surprising outcomes
- Go and C out-earn Python despite much lower demand.
- BI tools like Looker and Qlik pay well, showing that analytics + business-facing skills 
remain valuable.
- PowerPoint and Jira appearing at all highlights the value of communication and 
cross-team collaboration in senior roles.

Bottom line:
- The most optimal skills are not just core languages like Python, but cloud platforms, 
scalable languages (Go/Scala), and ML infrastructure tools, which together maximize both 
demand and salary for remote Data Scientist roles.