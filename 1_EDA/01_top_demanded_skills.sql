/*
Question: What are the most in-demand skills for Business analyst?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for business analyst
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for business analyst seeking remote work
*/

SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Business Analyst' 
    AND jpf.job_work_from_home = True 
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 10;

/*
Answer:
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │         2788 │
│ excel      │         2085 │
│ tableau    │         1661 │
│ python     │         1359 │
│ power bi   │         1309 │
│ r          │          568 │
│ powerpoint │          498 │
│ azure      │          458 │
│ looker     │          427 │
│ word       │          398 │
├────────────┴──────────────┤
│ 10 rows         2 columns │
└───────────────────────────┘
*/
