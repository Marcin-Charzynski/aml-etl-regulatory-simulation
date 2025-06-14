-- Rule 4: Counterparty on watchlist
SELECT 
    t.*, w.name AS watchlist_name
FROM transactions t
JOIN watchlist w ON t.counterparty_name = w.name;