/*
Question: What are the highest-paying skills for business analyst?
- Calculate the median salary for each skill required in businees analyst positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS skill_count
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Business Analyst'
    AND jpf.job_work_from_home = True 
GROUP BY
    sd.skills
HAVING
    COUNT(sd.skills) >= 100
ORDER BY
    median_salary DESC
LIMIT 10;

/*
ANSWER:
┌────────────┬───────────────┬─────────────┐
│   skills   │ median_salary │ skill_count │
│  varchar   │    double     │    int64    │
├────────────┼───────────────┼─────────────┤
│ go         │      141810.0 │         323 │
│ python     │      111450.0 │        1359 │
│ qlik       │      110175.0 │         152 │
│ r          │      110000.0 │         568 │
│ snowflake  │      109250.0 │         269 │
│ sas        │      108000.0 │         384 │
│ aws        │      107520.0 │         394 │
│ gcp        │      107520.0 │         192 │
│ databricks │       99260.0 │         143 │
│ tableau    │       95925.0 │        1661 │
├────────────┴───────────────┴─────────────┤
│ 10 rows                        3 columns │
└──────────────────────────────────────────┘
*/
