---
layout: page
title: Regulatory Reporting
permalink: /regulatory-reporting/
---

## 📄 Regulatory Reporting

This section outlines how outputs from the ETL and AML pipeline are converted into structured mock regulatory reports — inspired by requirements from institutions like FinCEN, FCA, or EBA.

### 🧾 Report Types Simulated

#### 1. **SAR – Suspicious Activity Report**

- Generated for customers with risk score ≥ 60
- Includes:

  - Customer ID, triggered rules, total risk score
  - Summary of behavior and last activity date
- Output Format: CSV & mock PDF

#### 2. **CTR – Currency Transaction Report**

- Triggered for individual cash transactions > \$10,000
- Includes:

  - Transaction ID, type, origin/destination countries, amount
  - Entity and time details

#### 3. **SPID-style Filing Summary**

- **regulatory_report table** simulates institutional reporting with the following fields:

  - **report_id** (int)
  - **report_date** (datetime)
  - **flagged_txn_count** (int)
  - **reporting_entity** (text)
  - **submission_time** (datetime)
  - **status** (text: On Time, Late, Missing)

<details>
<summary>Click to view code</summary>
<pre class="overflow-x-auto bg-gray-800 text-green-400 p-4 rounded-md text-sm font-mono"><code class="SQL">
CREATE TABLE regulatory_report AS
SELECT 
    ROW_NUMBER() OVER () AS report_id,
    DATE(triggered_at) AS report_date,
    COUNT(*) AS flagged_txn_count,
    'ACME AML Engine' AS reporting_entity,
    DATETIME(triggered_at, '+' || ROUND(RANDOM() % 48) || ' hours') AS submission_time,
    CASE
        WHEN submission_time <= DATETIME(report_date, '+24 hours') THEN 'On Time'
        WHEN submission_time IS NULL THEN 'Missing'
        ELSE 'Late'
    END AS status
FROM flagged_txns
GROUP BY report_date;
</code></pre>
</details>

> ❗ Submission time delays are simulated to model compliance tracking, and NULLs are introduced to represent missing/incomplete filings.

---

### 📂 Output Formats & Storage

- All generated reports are saved in **/output/reports/**
- Formats include **.csv**, mock **.pdf**, and **.json** stubs for further automation
- Each report batch is versioned and timestamped

---

### 📌 Example Output: SPID Filing Table

| report_id | report_date | flagged_txn_count | reporting_entity | submission_time    | status  |
| ---------- | ------------ | ------------------- | ----------------- | ------------------- | ------- |
| 1          | 2025-06-10   | 37,122              | ACME AML Engine   | 2025-06-10 13:45:00 | On Time |
| 2          | 2025-06-11   | 41,988              | ACME AML Engine   | 2025-06-12 17:20:00 | Late    |
| 3          | 2025-06-12   | 43,500              | ACME AML Engine   | *(NULL)*            | Missing |

---
