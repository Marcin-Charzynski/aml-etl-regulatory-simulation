---

layout: page
title: AML Rules & Risk Scoring
permalink: /risk-detection/
---------------------------

## 🚨 AML Rules & Risk Scoring

This section introduces the SQL-based risk detection logic used to identify suspicious activity. Each rule assigns a risk score based on patterns associated with money laundering behaviors.

### 🔍 Example Rules Implemented

1. **High-Value International Transfers**

   * Transfers > \$10,000 to offshore jurisdictions
2. **Structuring (Smurfing)**

   * Multiple small deposits just under threshold within 24h
3. **Dormant Accounts Reactivated**

   * Inactive 6+ months, then sudden activity

### 📊 Risk Score Calculation

Each triggered rule contributes points to a client’s risk score. Weighted logic helps prioritize alerts:

| Rule                         | Score Weight |
| ---------------------------- | ------------ |
| Offshore Wire > \$10k        | 40           |
| Structuring < \$10k (3x/24h) | 30           |
| Reactivated Dormant Account  | 20           |

### 💡 Example SQL Logic

```sql
SELECT client_id, COUNT(*) AS match_count
FROM transactions
WHERE amount < 10000 AND txn_type = 'deposit'
  AND txn_date >= DATE('now', '-1 day')
GROUP BY client_id
HAVING COUNT(*) >= 3;
```

All flagged clients are inserted into a `risk_alerts` table, ready for further investigation.
