/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Scientist positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Scientist and
    help identify the most financially rewarding skills to acquire or improve
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist' AND salary_year_avg IS NOT NULL
    -- AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
     avg_salary DESC
LIMIT 25


/*

Project management / collaboration tools at the top:

- Asana (215k), Airtable (201k), Slack (168k), Notion (165k), Zoom (151k)**
- Surprising: These non-technical tools appear higher than many coding languages.

Enterprise / AI platforms pay well:

- RedHat (189k), Watson (187k), Neo4j (163k), Airflow (155k), BigQuery (149k)
- Highlights value of enterprise and cloud experience.

Niche programming languages / frameworks:

- Elixir (171k), Lua (170k), Solidity (167k), Ruby on Rails (166k), Objective-C (164k)
- Shows rare or specialized technical skills command premium salaries.

ML / AI frameworks:

- Hugging Face (161k), Theano (153k)
- AI/ML expertise is financially rewarding, especially specialized libraries.

Game / creative engines:

- Unity (157k), Unreal (153k)
- Suggests Data Scientists in gaming or simulation can earn high salaries.

Surprising observations:

- Tools like **Asana and Airtable topping coding languages.
- Niche languages like Elixir, Lua, Solidity out-earning mainstream ones like 
Python or R in this dataset.

*/