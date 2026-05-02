SELECT 
  SUM (loan_amount) AS "Total Loan Amount"
FROM fact_loan;

SELECT
  COUNT(account_id) AS "Total Loans"
FROM fact_loan;

SELECT
  ROUND(SUM(total_payment)::numeric, 2) AS "Total Collection"
FROM fact_loan;

SELECT
  ROUND(SUM(total_rec_int)::numeric, 2) AS "Total Interest"
FROM fact_loan;

SELECT
  branch_name,
  ROUND(SUM(total_rec_int)::numeric, 2) AS "Interest",
  ROUND(SUM("total_fees ")::numeric, 2) AS "Fees",
  ROUND(SUM(total_payment)::numeric, 2) AS "Total Revenue"
FROM fact_loan
 LEFT JOIN dim_officer
  ON fact_loan.officer_id= dim_officer.officer_id
GROUP BY branch_name
ORDER BY SUM(total_payment) DESC
LIMIT 5;

SELECT 
  state_name,
  SUM (loan_amount) AS "Total Loan Amount"
FROM fact_loan
 LEFT JOIN dim_location
  ON fact_loan.location_id = dim_location.location_id
GROUP BY state_name
ORDER BY SUM (loan_amount) DESC
LIMIT 10;

SELECT 
  c.religion,
  SUM(f.loan_amount) AS "Total Loan",
  ROUND((SUM(f.loan_amount)::numeric / SUM(SUM(f.loan_amount)) OVER()::numeric) * 100,
  2) 
  AS "Pct of Total"
FROM fact_loan AS f
 LEFT JOIN dim_client AS c 
  ON f.client_id = c.client_id
GROUP BY c.religion
ORDER BY SUM(f.loan_amount) DESC;

SELECT
  product_code AS products,
  SUM(f.funded_amount) AS "Total Loan"
FROM fact_loan AS f
 LEFT JOIN dim_product AS p
  ON f.product_id = p.product_id
GROUP BY product_code
ORDER BY SUM(f.funded_amount) DESC;

SELECT
  EXTRACT(YEAR FROM disbursement_date::date) AS year,
  SUM(funded_amount) AS "Total Loan"
FROM fact_loan
GROUP BY EXTRACT(YEAR FROM disbursement_date::date)
ORDER BY EXTRACT(YEAR FROM disbursement_date::date) ASC;

SELECT
  grade,
  SUM(funded_amount) AS "Total Loan"
FROM fact_loan
GROUP BY grade
ORDER BY grade;

SELECT
  SUM(CASE 
  WHEN is_default_loan = 'Y' 
  THEN 1 ELSE 0 
  END) AS "Default_loan_count"
FROM fact_loan;

SELECT
  SUM(CASE 
  WHEN is_delinquent_loan = 'Y' 
  THEN 1 ELSE 0 
  END) AS "Delinquent_client_count"
FROM fact_loan;

SELECT
ROUND(
  (SUM(CASE 
  WHEN is_delinquent_loan = 'Y' THEN 1 ELSE 0 
  END)::numeric / COUNT(account_id)) * 100, 
  2
  ) || '%' AS "Default_loan_rate"
FROM fact_loan;

SELECT
  ROUND(
  (SUM(CASE 
  WHEN is_default_loan = 'Y' THEN 1 ELSE 0 END)::numeric / COUNT(account_id)) * 100, 
  2
  ) || '%' AS "Default_loan_rate"
FROM fact_loan;

SELECT
  loan_status,
  COUNT(account_id) AS "Total Loan"
FROM fact_loan
GROUP BY loan_status;

SELECT
  age,
  SUM(funded_amount) AS "Total Loan"
FROM fact_loan
LEFT JOIN dim_client
ON fact_loan.client_id = dim_client.client_id
GROUP BY age
ORDER BY SUM(funded_amount) DESC;

SELECT
  SUM(CASE 
      WHEN verification_status = 'Not Verified' 
      OR verification_status = 'Data Missing' 
      THEN 1 ELSE 0 
      END) AS "No_verified_loans"
FROM fact_loan;

SELECT 
  term,
  COUNT(account_id) AS "Total Loan",
  ROUND(
  (COUNT(account_id)::numeric / SUM(COUNT(account_id)) OVER()::numeric) * 100, 
  2
  ) AS "Pct of Total"
FROM fact_loan
GROUP BY term;

  


  


