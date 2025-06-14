-- Rule 5: Dormant accounts suddenly active (no txn for 90+ days then spike)
WITH last_tx AS (
    SELECT 
        account_id,
        MAX(timestamp) AS last_tx_before
    FROM transactions
    WHERE DATE(timestamp) < DATE('now', '-90 days')
    GROUP BY account_id
),
recent_tx AS (
    SELECT account_id, COUNT(*) AS recent_txns
    FROM transactions
    WHERE DATE(timestamp) >= DATE('now', '-7 days')
    GROUP BY account_id
)
SELECT r.account_id, r.recent_txns, l.last_tx_before
FROM recent_tx r
JOIN last_tx l ON r.account_id = l.account_id
WHERE r.recent_txns >= 2;