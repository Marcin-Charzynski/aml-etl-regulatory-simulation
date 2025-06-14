---
layout: page
title: Data Model & SQLite Setup
permalink: /data-model/
---

## 🗃 Data Model & SQLite Setup

This section outlines the project’s database schema and entity-relationship diagram (ERD) used for analysis and reporting.

The project runs on a local SQLite database and includes staging, dimension, fact, and audit tables.

### 🔗 ERD Overview

* **Clients** (`dim_clients`)
* **Accounts** (`dim_accounts`)
* **Transactions** (`fact_transactions`)
* **ETL Audit** (`audit_etl_runs`)
* **Alerts** (`risk_alerts`, `risk_rules_triggered`)

### 🛠 SQLite Setup

```python
import sqlite3
conn = sqlite3.connect("aml_simulation.db")
cursor = conn.cursor()
```

### 📂 Folder Structure

```
/data/
  ├── raw/
  ├── staging/
  └── final/
/output/
  └── reports/
```

### 📌 Notes

* Indexes are created on `client_id`, `txn_date`, and `rule_id`
* Views are used for downstream reporting (`sar_view`, `ctr_view`)
* Test coverage built-in via `pytest-sqlite` for reproducibility
