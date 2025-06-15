---
layout: page
title: AML Rules & Risk Scoring
permalink: /risk-detection/
---

## 🚨 AML Rules & Risk Scoring

This section outlines the rule-based detection engine used to identify suspicious financial activity in the AML ETL & Regulatory Simulation project.

Each rule mimics a behavior commonly associated with money laundering and assigns a score to help prioritize investigative alerts. The system is designed to simulate functionality similar to enterprise tools like Oracle OFSAA and Sygnity SPID.

### ⚖️ Rule Set Overview

The following SQL-based rules are implemented and populate the **flagged_txns** table:

1. **Structuring (Smurfing)**  
   - Multiple deposits just under reporting thresholds  
   - 3+ deposits under \$10,000 within a 24-hour period

2. **Velocity (High Transaction Frequency)**  
   - 5 or more transactions from the same account within 30 minutes

3. **High-Risk Geographies**  
   - Transfers involving countries on an internal high-risk list (e.g., Panama, Cayman Islands)

4. **Watchlist Counterparty Match**  
   - Any transaction involving a name that appears on the watchlist_entities table

5. **Dormant Account Reactivation**  
   - Account inactive for over 6 months, then suddenly initiates a transaction

### 📊 Risk Score Calculation

Each rule contributes to an aggregated client risk score. Scores can be weighted to reflect the severity or regulatory importance of each risk type.

| Rule                                 | Score Weight |
| ------------------------------------ | ------------ |
| Structuring (3x < \$10k / 24h)        | 30           |
| Velocity (5+ txns / 30 min)           | 25           |
| High-Risk Country Transfer            | 20           |
| Counterparty Match (Watchlist)        | 15           |
| Reactivated Dormant Account           | 10           |

*Thresholds can be adjusted as per AML policy configuration.*

### 🧠 Detection Logic Example

<details>
<summary>Click to view SQL</summary>
<pre class="overflow-x-auto bg-gray-800 text-green-400 p-4 rounded-md text-sm font-mono"><code class="language-sql">
WITH recent_deposits AS (
  SELECT 
    account_id,
    timestamp,
    amount
  FROM transactions
  WHERE amount BETWEEN 9000 AND 9999
    AND timestamp >= DATETIME('now', '-1 day')
)
SELECT 
  account_id,
  COUNT(*) AS txn_count
FROM recent_deposits
GROUP BY account_id
HAVING txn_count >= 3;
</code></pre>
</details>

This rule checks for deposit structuring — an attempt to avoid reporting thresholds by splitting transactions.

### 🧾 Output: flagged_txns Table

All triggered alerts are inserted into the **flagged_txns** table with the following structure:

| Column          | Description                                |
|-----------------|--------------------------------------------|
| **flagged_id**    | Unique identifier (autoincrement)          |
| **txn_id**        | ID of the suspicious transaction           |
| **rule_triggered**| Label of the AML rule that was triggered   |
| **reason**        | SQL-generated reasoning for investigation  |

These alerts are used downstream to simulate risk scoring, reporting (CTR/SAR), or case management escalation.

### 🔍 What's Next?

In the next step, this logic integrates with Power BI to produce dashboards highlighting risk concentration, rule distribution, and geographic exposure. You can also extend the framework to build client-level aggregation or behavioral profiling.

---
