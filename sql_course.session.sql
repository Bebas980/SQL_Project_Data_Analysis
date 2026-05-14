WITH company_job_count AS (
    SELECT 
        company_id,
        count(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)

SELECT
    company_dim.name AS company_name,
    company_job_count.total_jobs
 FROM 
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC 



WITH company_job_count AS (
    SELECT 
        company_id,
        count(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT
    CASE
        WHEN total_jobs > 10 THEN 'SMALL'
        WHEN total_jobs BETWEEN 10 AND 50 THEN 'MEDIUM'
        ELSE 'LARGE'
    END AS company_size,
    COUNT(*) AS number_of_companies

FROM company_job_count
GROUP BY company_size
ORDER BY number_of_companies










WITH skill_count AS (
    SELECT
        skill_id,
        count(*) AS total_skills
    FROM skills_job_dim
    GROUP BY skill_id
)

SELECT
    skills_dim.skills AS skills_name,
    skill_count.total_skills
FROM skills_dim
LEFT JOIN skill_count 
    ON skill_count.skill_id = skills_dim.skill_id
ORDER BY total_skills DESC;



