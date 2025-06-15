---
layout: page
title: Data Model & SQLite Setup
permalink: /data-model/
---

## 🗃 Data Model & SQLite Setup

This section outlines the database schema and architecture used in the AML ETL & Regulatory Simulation project.

The project simulates a real-world AML system, integrating client, account, transaction, and watchlist data. The database is generated locally using SQLite and fully populated via Python scripts that mimic realistic financial operations.

### 🔗 ERD Overview

* **Customers** (**customers**) — Identity and risk profile for each customer
* **Accounts** (**accounts**) — Bank accounts linked to each customer
* **Transactions** (**transactions**) — Financial movements across accounts
* **Watchlist Entities** (**watchlist_entities**) — External parties flagged for AML monitoring
* **Flagged Transactions** (**flagged_txns**) — Transactions identified by SQL-based AML detection rules

### 🛠 SQLite Setup

The SQLite database is created using a Python script that:

* Generates 10,000 customers (with realistic names, birthdates, and risk categories)
* Links each customer to 1–3 accounts
* Populates each account with 50–200 randomized transactions (simulating deposits, transfers, foreign exchanges, etc.)
* Adds a watchlist of 20 suspicious entities
* Prepares an empty **flagged_txns** table for rule-based AML detection

Example connection setup:

<details>
<summary>Click to view code</summary>
<pre class="overflow-x-auto bg-gray-800 text-green-400 p-4 rounded-md text-sm font-mono"><code class="language-python">
import sqlite3
conn = sqlite3.connect("aml_simulation.db")
cursor = conn.cursor()
</code></pre>
</details>

### 🧱 Table Summary

| Table                | Description                                       |
| -------------------- | ------------------------------------------------- |
| **customers**          | Customer ID, name, DOB, country, risk category    |
| **accounts**           | Account ID, customer link, type, open date        |
| **transactions**       | Timestamped financial movements between parties   |
| **watchlist_entities** | List of suspicious companies or individuals       |
| **flagged_txns**       | Output of rule triggers for further investigation |

### ⚙️ Key Features

* Designed for traceable, reproducible pipelines
* Indexed fields: **customer_id**, **txn_id**, **timestamp**
* Watchlist joins and velocity analysis powered by SQL window functions
* Future-ready for integration with Power BI and rule-based scoring logic
