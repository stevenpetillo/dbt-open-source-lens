# dbt-open-lens

An end-to-end analytics engineering project that extracts data from the GitHub API for the dbt open source repository and loads it into a database using a custom Python ingestion pipeline, transforms the data using dbt, and surfaces insights through a BI dashboard layer.

The project analyzes community and member contributions to the dbt open source ecosystem, delivering analytics-ready datasets for downstream reporting and visualization.

This project is actively under development. Core ingestion and dbt models are implemented, with ongoing enhancements to testing, documentation, and the BI layer.

---

## Project Goals

This project simulates a production-style analytics pipeline spanning ingestion, transformation, and visualization:

- Extract GitHub API data for dbt open source repositories, issues, and contributors
- Build a reproducible ingestion pipeline using Python
- Model structured analytical datasets using dbt
- Implement data quality testing and documentation
- Deliver insights through a BI dashboard layer

---

## Architecture Overview

```
GitHub API (dbt open source: issues, repos, users)
    ↓
Python Ingestion Layer (custom ETL script)
    ↓
Raw Database Layer (Postgres or similar)
    ↓
dbt Staging Models (stg_*)
    ↓
dbt Intermediate Models (int_*)
    ↓
dbt Mart Models (fct_*, dim_*)
    ↓
BI Layer (Power BI / Tableau / similar dashboards)
```

---

## Tech Stack

- **Python** — Custom ingestion scripts
- **GitHub REST API** — Data source
- **PostgreSQL** — Relational database
- **dbt Core** — Data transformations
- **SQL** — Modeling and analytics logic
- **BI Tool** — Power BI / Tableau / equivalent
- **Git** — Version control

---

## Data Flow

### Data Ingestion (Python)

Connects to GitHub REST API and extracts:
- Issues from dbt open source repositories
- Repository metadata
- Contributor and user information
- Related activity signals

Key features:
- Handles pagination and rate limiting
- Normalizes nested JSON structures (e.g., user objects)
- Loads raw data into relational database
- Supports incremental ingestion strategy

### Data Modeling (dbt)

**Staging Layer (stg_*)**
- Cleans and standardizes raw tables
- Flattens nested structures
- Ensures consistent typing and naming conventions

**Intermediate Layer (int_*)**
- Applies transformation logic and business rules
- Any joins would start here core entities (issues, users, repositories)

**Mart Layer (fct_*, dim_*, rpt_*)**
- Fact table: issues with activity metrics
- Dimension tables: users, repositories
- Optimized for analytics and BI consumption

**Data Quality Tests**
- Not null constraints
- Uniqueness constraints
- Referential integrity checks
- More custom tests to be added

### BI / Analytics Layer

The final layer exposes curated datasets to a BI tool for visualization and business insight generation.

**Dashboards include:**
- Issue volume trends over time
- Issues by repository
- User contribution activity

**Key metrics:**
- Open vs closed issue rate
- Average issue resolution time
- Contributor activity distribution

---

## Current Features

- Python-based GitHub API ingestion pipeline
- Raw data persistence layer in database
- dbt-based multi-layer transformation model
- Fact and dimension modeling for GitHub activity
- Basic data quality testing framework
- Initial BI layer design and dashboard implementation

---

## Work in Progress

- Expanded dbt test coverage (relationships, custom tests)
- Full BI dashboard implementation (Power BI / Tableau)
- Improved contributor and activity modeling
- Incremental dbt models for scalability
- Logging and observability for ingestion pipeline
- CI checks for dbt build and tests

---

## Key Design Decisions

- **Separation of concerns**: Ingestion, transformation, and BI layers are cleanly separated
- **dbt layered architecture**: Staging → Intermediate → Marts for maintainability
- **Contribution-focused modeling**: Optimized for analyzing open source participation
- **Raw data retention**: Preserved for reproducibility and auditing
- **Analytics-first design**: Optimized for dashboard consumption and insight generation

---

## How to Run

```bash
# Install dependencies
source installs.sh

# Run ingestion
source raw/master.sh

# Run and test dbt resources in DAG order
dbt build

# Generate docs
dbt docs generate

# Docs will be exposed in GitHub
```


## What This Project Demonstrates

- End-to-end data pipeline design (ingestion → BI)
- API-based data extraction using Python
- Data modeling using dbt
- SQL transformation and analytics engineering patterns
- Data quality testing and validation
- BI dashboard development for insight delivery

---

## Tech Stack Composition

| Layer | Technology | Percentage |
|-------|-----------|-----------|
| Ingestion & Scripts | Python | 92.9% |
| Infrastructure & Config | Shell | 7.1% |

---

## Status

Actively being developed as a full-stack analytics engineering portfolio project covering ingestion, modeling, and visualization layers.

---

## License

This project is open source and available under the MIT License.

---

## Author

Steven Petillo  
[GitHub](https://github.com/stevenpetillo)

---