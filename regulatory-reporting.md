---

layout: page
title: Regulatory Reporting
permalink: /regulatory-reporting/
---------------------------------

## 📄 Regulatory Reporting

This section explains how outputs from the ETL + AML pipeline are formatted into mock regulatory reports. These reports simulate requirements from institutions like FinCEN or EBA.

### 📋 Report Types Simulated

* **SAR (Suspicious Activity Report)**

  * Auto-generated for high-risk clients
  * Includes risk rule triggers, timestamps, and summary notes

* **CTR (Currency Transaction Report)**

  * Triggered for cash transactions > \$10,000
  * Includes structured data: transaction type, originator, recipient

* **Audit Log / Trace File**

  * Tracks every ETL load, rule trigger, and reporting batch

### 🛠 Report Generation Logic

Reports are exported from SQLite views:

```sql
CREATE VIEW sar_view AS
SELECT client_id, risk_score, reason_summary, MAX(triggered_at) as last_seen
FROM risk_alerts
GROUP BY client_id
HAVING risk_score >= 60;
```

All reports are timestamped, versioned, and stored in `/output/reports/` with mock PDF/CSV formats.
