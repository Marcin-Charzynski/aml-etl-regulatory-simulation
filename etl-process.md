---
layout: page
title: ETL Pipeline
permalink: /etl-process/
---

## 🔄 ETL Pipeline

This section outlines the end-to-end ETL pipeline that powers the AML ETL & Regulatory Simulation project.

The pipeline is implemented in Python using Pandas and SQLAlchemy to populate a local SQLite database. The goal is to simulate real-time ingestion, transformation, and loading of transactional data to support AML rule enforcement and compliance reporting.

### 🧪 ETL Workflow Overview

The ETL flow mimics how financial data moves from operational systems into regulatory reporting environments. The pipeline includes the following stages:

1. **Extract**  
   - Generate synthetic customer, account, and transaction data using realistic patterns  
   - Load directly into staging tables (no external files required)

2. **Transform**  
   - Normalize field formats (e.g., timestamp, country codes)  
   - Remove duplicates and apply sanity checks  
   - Create derived fields like transaction velocity and account dormancy  
   - Join accounts to customers for downstream linkage

3. **Load**  
   - Insert curated data into final tables used for analysis and rule evaluation  
   - Populate metadata in the **audit_etl_runs** table to log execution time, row counts, and pipeline status  
   - Prepare empty containers for **flagged_txns** and **risk_alerts**

### 🧰 Python Example Snippet

<details>
<summary>Click to view code</summary>
<pre class="overflow-x-auto bg-gray-800 text-green-400 p-4 rounded-md text-sm font-mono"><code class="language-python">
# Sample transformation: clean and normalize descriptions
import pandas as pd

transactions["clean_description"] = (
    transactions["description"]
    .str.lower()
    .str.replace(r"[^a-z0-9 ]", "", regex=True)
    .str.strip()
)
</code></pre>
</details>

### 🧱 Table Structure: Staging vs Final

| Layer         | Tables                             | Purpose                                |
|---------------|-------------------------------------|----------------------------------------|
| **Staging**     | `stg_customers`, `stg_accounts`, `stg_transactions` | Raw or intermediate tables              |
| **Core**        | `customers`, `accounts`, `transactions`              | Final normalized tables used in analysis |
| **Audit**       | `audit_etl_runs`                                    | Metadata logs for ETL diagnostics        |
| **Output**      | `flagged_txns`, `risk_alerts`                        | Result of rule-based detection           |

The staging layer allows for validation and rollback before final insertion. Only after all checks pass are the records moved into the core schema.

### 🧾 Audit Logging & Quality Control

Each ETL run updates the **audit_etl_runs** table with:

- Timestamp of the batch  
- Number of records inserted per table  
- Runtime duration  
- Success/failure flag and exception handling

This ensures that the pipeline is fully traceable and suitable for regulated environments.

### ⚙️ Key Features

- Built entirely in Python using Pandas, Faker, and SQLite  
- Stateless architecture allows reruns without data conflicts  
- Supports expansion to cloud SQL or external APIs  
- Connects seamlessly with AML rule engine defined in `/risk-detection/`

---
