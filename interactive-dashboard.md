---
layout: page
title: Interactive Dashboard
permalink: /interactive-dashboard/
---

## 📊 Interactive Dashboard (Power BI)

This optional Power BI dashboard visualizes outputs from the AML pipeline and provides insights for compliance teams and auditors.

### 🧭 Key Pages

1. **Client Risk Overview**

   * Risk score distribution
   * Top flagged clients

2. **Transaction Monitoring**

   * High-risk transactions with filters for jurisdiction, channel, and method

3. **Case Summary**

   * Timeline of alerts
   * Rule triggers per client
   * SAR/CTR report coverage

### 🔌 Dataset Connection

* Source: `aml_simulation.db` (SQLite)
* Connection via ODBC or manual export to `.csv`

### 🎨 Design Notes

* Consistent use of color-coded risk levels
* Slicers for scenario simulation (date range, risk thresholds)
* Designed to align with real-world AML review workflows

> Note: This dashboard is not required for project completion, but adds interactivity and stakeholder value.
