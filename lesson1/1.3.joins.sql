SELECT
    jpf.job_id,
    jpf.job_title_short,
FROM
    job_postings_fact AS jpf
FULL OUTER JOIN
    company_dim AS cd
ON jpf.company_id= cd.company_id    
LIMIT 10;
