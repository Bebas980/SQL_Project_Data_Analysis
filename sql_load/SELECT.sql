SELECT 
    job_title_short AS job,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date,
    EXTRACT (MONTH FROM job_posted_date) AS date_month
FROM job_postings_fact
LIMIT 100;

SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS yearly_avg,
    AVG(salary_hour_avg) AS hourly_avg
FROM job_postings_fact
WHERE 
    job_posted_date > '2023-06-01'
    AND salary_year_avg IS NOT NULL
    OR salary_hour_avg IS NOT NULL
GROUP BY job_schedule_type
ORDER BY yearly_avg DESC;


SELECT
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    COUNT(job_title_short) AS job,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EDT' AS date
FROM job_postings_fact
GROUP BY date_month
ORDER BY date_month DESC

SELECT
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    COUNT(job_title_short) AS job
FROM job_postings_fact
GROUP BY date_month
ORDER BY date_month DESC;

SELECT
    DATE_TRUNC(
        'month',
        job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York'
    ) AS month_edt,
    COUNT(job_title_short) AS job_count
FROM job_postings_fact
GROUP BY month_edt
ORDER BY month_edt DESC;

SELECT
    company_id,
    job_health_insurance
FROM job_postings_fact
WHERE EXTRACT(QUARTER FROM job_posted_date) =2
GROUP BY company_id
ORDER BY date_month DESC


CREATE TABLE january_jobs AS
    SELECT * FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;


CREATE TABLE february_jobs AS
    SELECT * FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
    SELECT * FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;



select 
    COUNT(job_id) AS number_of_job,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY location_category
ORDER BY number_of_job DESC


SELECT
    job_id,
    ROUND(AVG(salary_year_avg))::INT AS average_salary,
    CASE
        WHEN AVG(salary_year_avg) >=75000 THEN 'HIGH'
        WHEN AVG(salary_year_avg) <=75000 AND AVG(salary_year_avg) >=50000 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS category
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY job_id
ORDER BY average_salary DESC;