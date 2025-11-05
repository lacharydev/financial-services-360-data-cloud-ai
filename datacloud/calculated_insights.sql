-- Calculated Insights (template) — one row per customer
-- Adjust function/date syntax to match Data Cloud/engine
SELECT
  c.customer_id,
  COUNT(DISTINCT a.account_id) AS product_count,
  SUM(CASE WHEN t.fee_flag = 1 THEN 1 ELSE 0 END) AS fees_90d,
  SUM(CASE WHEN t.txn_date >= CURRENT_DATE - INTERVAL '90 DAY' THEN ABS(t.amount) ELSE 0 END) AS spend_90d,
  AVG(a.balance) AS avg_balance,
  c.tenure_months,
  c.segment,
  c.region,
  c.churn_90d
FROM customers c
LEFT JOIN accounts a ON a.customer_id = c.customer_id
LEFT JOIN transactions t ON t.account_id = a.account_id
GROUP BY 1,6,7,8,9;
