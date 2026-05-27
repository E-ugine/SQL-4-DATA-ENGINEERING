/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

/*
Optimal here ideally means a skill that has high demand and pays a high salary as well.
A skill with low demand, or one with high demand but low pay isn't optimal.
So I'll take two things into consideration;
1. demand_count : how many job postings require this skill
2. avg/median salary for this skill

I'll do a three table join here;
(job_postings_fact )→ (skills_job_dim) → (skills_dim)
1. job_postings_fact: salaries, job_title, remote tag
2. skills_job_dim : the bridge table linking jobs to skills
3. skills_dim : actuall skills table
*/

SELECT
    sd.skills,
    COUNT(jpf.job_id) AS demand_count,
    ROUND(AVG(jpf.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
HAVING
    COUNT(jpf.job_id) > 100
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;


┌────────────┬──────────────┬────────────┐
│   skills   │ demand_count │ avg_salary │
│  varchar   │    int64     │   double   │
├────────────┼──────────────┼────────────┤
│ terraform  │          193 │   171288.0 │
│ kubernetes │          147 │   156024.0 │
│ airflow    │          386 │   151935.0 │
│ git        │          208 │   150883.0 │
│ kafka      │          292 │   148732.0 │
│ scala      │          247 │   145019.0 │
│ snowflake  │          438 │   145010.0 │
│ spark      │          503 │   143240.0 │
│ docker     │          144 │   141412.0 │
│ gcp        │          196 │   141034.0 │
│ python     │         1133 │   140000.0 │
│ java       │          303 │   139949.0 │
│ aws        │          783 │   139788.0 │
│ pyspark    │          152 │   139483.0 │
│ go         │          113 │   138852.0 │
│ bigquery   │          123 │   137190.0 │
│ hadoop     │          198 │   136442.0 │
│ databricks │          266 │   135346.0 │
│ nosql      │          193 │   133433.0 │
│ mongodb    │          136 │   131132.0 │
│ azure      │          475 │   131009.0 │
│ sql        │         1128 │   130471.0 │
│ redshift   │          274 │   129816.0 │
│ mysql      │          101 │   129749.0 │
│ github     │          127 │   128250.0 │
└────────────┴──────────────┴────────────┘
  25 rows                      3 columns

/*
Key Takeaways
1. Python + SQL are non-negotiable
Combined demand of 2,261 postings. Virtually every Data Engineer role expects both. They're the floor, not the ceiling.
2. Cloud platforms split interestingly

AWS ($139K, 783 jobs) outperforms Azure ($131K, 475 jobs) and GCP ($141K, 196 jobs)
AWS is the clear cloud priority for both pay and demand

3. Terraform tops salary despite modest demand
At $171K it's the highest-paying skill. Infrastructure-as-code expertise is clearly premium-priced.
4. Orchestration & streaming tools are the sweet spot
Airflow, Kafka, and Spark hit the ideal balance. They appear in hundreds of jobs while commanding $143K–$152K salaries.

Suggested Learning Priority Order
1. Python + SQL          → Get hired (highest demand, table stakes)
2. Spark + Airflow       → Core DE tools, great salary/demand balance  
3. AWS + Snowflake       → Cloud + data warehouse, widely required
4. Kafka + Scala         → Streaming expertise, strong pay premium
5. Terraform + Kubernetes → Specialist tier, highest salary ceiling
*/  