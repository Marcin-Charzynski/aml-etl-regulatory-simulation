-- Rule 2: Velocity - 5+ transactions within 30 minutes
WITH tx_ranked AS (
    SELECT 
        t.*,
        COUNT(*) OVER (
            PARTITION BY t.account_id 
            ORDER BY t.timestamp 
            RANGE BETWEEN INTERVAL 30 MINUTE PRECEDING AND CURRENT ROW
        ) AS txn_count_30min
    FROM transactions t
)
SELECT * FROM tx_ranked
WHERE txn_count_30min >= 5;