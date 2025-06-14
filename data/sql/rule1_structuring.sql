-- Rule 1: Structuring - multiple transactions just under threshold within 24h
WITH tx_grouped AS (
    SELECT 
        t.customer_id,
        t.account_id,
        DATE(t.timestamp) AS tx_date,
        COUNT(*) AS tx_count,
        SUM(t.amount) AS total_amount
    FROM transactions t
    WHERE t.amount BETWEEN 9000 AND 9999  -- just under $10,000 threshold
    GROUP BY t.customer_id, t.account_id, DATE(t.timestamp)
)
SELECT * FROM tx_grouped
WHERE tx_count >= 2 AND total_amount > 10000;