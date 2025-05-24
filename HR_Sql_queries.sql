# 1. How does marital status correlate with attrition?
SELECT 
  marital_status,
  ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM db.hr_data
GROUP BY marital_status
ORDER BY attrition_rate DESC;

#2. Are younger employees (Age < 30) more likely to leave than older ones?
SELECT 
  CASE 
    WHEN age < 30 THEN 'Under 30'
    ELSE '30 and Above'
  END AS age_group,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(SUM(CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM db.hr_data
GROUP BY age_group
ORDER BY attrition_rate DESC;

#3. What is the attrition rate by job role?
select job_role,
round((sum(case when attrition='yes' then 1 else 0 end)*100)/count(*),2)as rate_by_job_role
from db.hr_data group by job_role order by rate_by_job_role desc;


#4. What is the attrition rate by department?
select department,
round((sum(case when attrition='yes' then 1 else 0 end)*100)/count(*),2) as rate_by_dept
from db.hr_data group by department order by rate_by_dept desc;

#5. Does distance from home influence attrition?
SELECT 
CASE 
  WHEN distance_from_home BETWEEN 0 AND 5 THEN '0-5 km'
  WHEN distance_from_home BETWEEN 6 AND 10 THEN '6-10 km'
  WHEN distance_from_home BETWEEN 11 AND 20 THEN '11-20 km'
  ELSE '21+ km'
END AS distance_bucket,
COUNT(*) AS total_employees,
SUM(CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END) AS employees_left,
ROUND(SUM(CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS attrition_rate
FROM db.hr_data
GROUP BY distance_bucket
ORDER BY attrition_rate DESC;

#6. Do stock options help retain employees?
SELECT stock_option_level,
COUNT(*) AS total_employees,
SUM(CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END) AS employees_left,
ROUND(SUM(CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS attrition_rate
FROM db.hr_data
GROUP BY stock_option_level
ORDER BY attrition_rate DESC;

#7. Do employees leave more in the early years? (Tenure Buckets)
SELECT 
CASE 
  WHEN years_at_company BETWEEN 0 AND 2 THEN '0-2 years'
  WHEN years_at_company BETWEEN 3 AND 5 THEN '3-5 years'
  WHEN years_at_company BETWEEN 6 AND 10 THEN '6-10 years'
  ELSE '10+ years'
END AS tenure_bucket,
COUNT(*) AS total_employees,
SUM(CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END) AS employees_left,
ROUND(SUM(CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS attrition_rate
FROM db.hr_data
GROUP BY tenure_bucket
ORDER BY attrition_rate DESC;


#8. Overall Attrition Rate
SELECT 
  ROUND(SUM(CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS overall_attrition_rate
FROM db.hr_data;


#9. Total Employees
select count(*)from db.hr_data;

#10. Attrition
select attrition,count(*) from db.hr_data
where attrition='yes'
group by attrition;

#11. Active Employees
select attrition,count(*)as emp_count from db.hr_data
where attrition='no'
group by attrition;



