---
layout: page
title: ETL Pipeline
permalink: /etl-process/
---

## 🔄 ETL Process

This section outlines how transactional data is simulated and processed through a Python + SQLite-based ETL pipeline.

The ETL workflow supports compliance and reporting by ensuring consistent data formatting, deduplication, and audit-ready staging tables.

### ⚙️ Steps in the ETL Pipeline

1. **Extract**

   * Raw data generated from simulated sources (e.g. banking transactions, account info, alerts)
   * Loaded as CSVs or directly inserted into SQLite

2. **Transform**

   * Normalization of transaction formats
   * Removal of duplicates
   * Flagging of edge cases (e.g. international wires, dormant accounts)

3. **Load**

   * Transformed data inserted into core reporting tables
   * Audit tables updated to track ETL batch metadata

### 🧪 Sample Python Snippet

```python
# Normalize transaction descriptions
transactions["clean_description"] = transactions["description"].str.lower().str.replace(r"[^a-z0-9 ]", "")
```

### 🧱 Staging vs Final Tables

* `stg_transactions`, `stg_accounts` → Temporary
* `dim_accounts`, `fact_transactions`, `audit_etl_runs` → Final

ETL scripts include validation checkpoints to log mismatches and flag anomalies for review before loading completes.
