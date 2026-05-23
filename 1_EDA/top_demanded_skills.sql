/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

SELECT
    jpf.job_title_short,
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM 
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id=sjd.job_id 
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id=sd.skill_id 
WHERE 
    jpf.job_title_short = 'Data Engineer' 
    AND 
    jpf.job_work_from_home = True  
GROUP BY
    jpf.job_title_short,
    sd.skills  
ORDER BY 
    demand_count DESC      
LIMIT 10;       

/*
┌─────────────────┬────────────┬──────────────┐
│ job_title_short │   skills   │ demand_count │
│     varchar     │  varchar   │    int64     │
├─────────────────┼────────────┼──────────────┤
│ Data Engineer   │ sql        │        29221 │
│ Data Engineer   │ python     │        28776 │
│ Data Engineer   │ aws        │        17823 │
│ Data Engineer   │ azure      │        14143 │
│ Data Engineer   │ spark      │        12799 │
│ Data Engineer   │ airflow    │         9996 │
│ Data Engineer   │ snowflake  │         8639 │
│ Data Engineer   │ databricks │         8183 │
│ Data Engineer   │ java       │         7267 │
│ Data Engineer   │ gcp        │         6446 │
└─────────────────┴────────────┴──────────────┘
  10 rows                           3 columns
*/

/*
My Key Takeaways

~SQL is the most in demand skill. With Python coming closely 2nd.
Cloud platforms AWS and AZURE seems to also be a fundamental skill with a very high count of data engineering skills demanding the duo as a required skill

*/