/*
Question: What are the most optimal skills
for business analysts — balancing both demand and salary?
- Create a ranking column that combines demand
  count and median salary to identify the most valuable skills.
- Focus only on remote business analyst positions
  with specified annual salaries.
- Why?
 - This approach highlights skills that balance market
      demand and financial reward. It weights core skills
      appropriately instead of letting rare, outlier skills 
      distort the results.
 - The natural log transformation ensures that both high-salary 
     and widely in-demand skills surface as the most practical 
     and valuable to learn for business analyst careers.
*/

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 1) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((LN(COUNT(jpf.*)) * MEDIAN(jpf.salary_year_avg))/1_000_000, 2) AS optimal_score
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Business Analyst'
    AND jpf.salary_year_avg IS NOT NULL
    AND jpf.job_work_from_home = True 
GROUP BY
    sd.skills
HAVING 
    COUNT(sjd.job_id) >= 50
ORDER BY
    optimal_score DESC
LIMIT 5;

/*
ANSWER:
┌──────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│  skills  │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│ varchar  │    double     │    int64     │     double      │    double     │
├──────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ python   │      111450.0 │           64 │             4.2 │          0.46 │
│ sql      │       92250.0 │          132 │             4.9 │          0.45 │
│ tableau  │       95925.0 │          102 │             4.6 │          0.44 │
│ power bi │       90000.0 │           71 │             4.3 │          0.38 │
│ excel    │       80000.0 │           89 │             4.5 │          0.36 │
└──────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
/*
