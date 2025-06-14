-- Rule 3: High-risk countries
SELECT 
    t.*, c.country
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
WHERE c.country IN ('Iran', 'North Korea', 'Syria', 'Russia', 'Afghanistan');