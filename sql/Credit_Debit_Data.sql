SELECT
ROUND(SUM(amount):: numeric, 2) AS "Amount"
FROM credit_debit_data
WHERE transaction_type = 'Credit';

SELECT
ROUND(SUM(amount):: numeric, 2) AS "Amount"
FROM credit_debit_data
WHERE transaction_type = 'Debit';

SELECT 
    ROUND(
        SUM(CASE WHEN transaction_type = 'Credit' THEN amount ELSE 0 END)::numeric / 
        SUM(CASE WHEN transaction_type = 'Debit' THEN amount ELSE 0 END)::numeric, 
        2
    ) AS "Credit to Debit Ratio"
FROM credit_debit_data;

SELECT 
    ROUND(
        SUM(CASE WHEN transaction_type = 'Credit' THEN amount ELSE 0 END)::numeric - 
        SUM(CASE WHEN transaction_type = 'Debit' THEN amount ELSE 0 END)::numeric, 
        2
    ) AS "Net Transaction Amount"
FROM credit_debit_data;

SELECT 
    ROUND(
        (COUNT(*) * 100.0 / NULLIF(SUM(balance), 0))::numeric, 
        2
    ) || '%' AS account_activity_ratio
FROM credit_debit_data;

SELECT 
    TO_CHAR(transaction_date::date, 'Month') AS month_name,
    ROUND(SUM(amount)::numeric, 2) AS total_amount
FROM credit_debit_data
GROUP BY TO_CHAR(transaction_date::date, 'Month')
ORDER BY MIN(transaction_date);

SELECT
  branch,
  ROUND(SUM(amount)::numeric, 2) AS total_amount
FROM credit_debit_data
GROUP BY branch
ORDER BY ROUND(SUM(amount)::numeric, 2) DESC;

SELECT
  bank_name,
  ROUND(SUM(amount)::numeric, 2) AS total_amount
FROM credit_debit_data
GROUP BY bank_name
ORDER BY ROUND(SUM(amount)::numeric, 2) DESC;

SELECT
  transaction_method,
  ROUND(SUM(amount)::numeric, 2) AS total_amount
FROM credit_debit_data
GROUP BY transaction_method
ORDER BY ROUND(SUM(amount)::numeric, 2) DESC;

WITH MonthlyData AS (
    SELECT 
        branch,
        EXTRACT(MONTH FROM transaction_date::date) AS transaction_month,
        ROUND(SUM(amount):: numeric, 2) AS total_amount
    FROM credit_debit_data
    GROUP BY 1, 2
),
GrowthCalculation AS (
    SELECT 
        branch,
        transaction_month,
        total_amount AS current_month_amount,
        ROUND(LAG(total_amount) OVER (PARTITION BY branch ORDER BY transaction_month), 2) AS prev_month_amount
    FROM MonthlyData
)
SELECT 
    branch,
    transaction_month,
    current_month_amount,
    prev_month_amount,
    ROUND(
        ((current_month_amount - prev_month_amount)::numeric * 100.0) / NULLIF(prev_month_amount, 0)::numeric, 
        2
    ) || '%' AS branch_growth_percentage
FROM GrowthCalculation
ORDER BY branch, transaction_month;

SELECT
  SUM(CASE
        WHEN amount > 4000
		THEN 1 ELSE 0 
		END) AS "Suspicious Activity"
FROM credit_debit_data;







