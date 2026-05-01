# 🏦 Banking Data Analysis Project

An end-to-end data analyst portfolio project — from raw flat file to normalized star schema, SQL analysis, Python data pipeline, and interactive dashboards in Tableau and Power BI.

---

## 🛠️ Tools & Technologies

| Layer | Tools Used |
| Data Cleaning & Modelling | Excel (Power Query, Power Pivot) |
| Database | PostgreSQL |
| Python Pipeline | Python 3.12, pandas, SQLAlchemy, psycopg2 |
| Dashboards | Tableau, Power BI |

---

## 📌 Project Overview

This project simulates a real-world banking data workflow using a dataset of **65,000+ loan transactions** across multiple branches, clients, products, and loan officers.

The project covers:
- **Data Cleaning** — Handled missing values, column typos, duplicate columns, and non-uniform formats using Excel Power Query
- **Data Modelling** — Normalized a 52-column flat file into a **star schema** with 1 fact table and 4 dimension tables
- **SQL Analysis** — Wrote analytical queries using window functions, CTEs, and multi-table joins in PostgreSQL
- **Python Pipeline** — Automated loading of Excel star schema tables into PostgreSQL using SQLAlchemy
- **Dashboards** — Built interactive dashboards in Tableau and Power BI to visualize key banking KPIs

---

## 🗂️ Star Schema Design

The flat file was normalized into the following structure:

```
fact_Loan
├── dim_Client
├── dim_Location
├── dim_Product
└── dim_Officer
```

| Table | Description |
|---|---|
| `fact_Loan` | Core transaction data — loan amounts, dates, status, balances |
| `dim_Client` | Client demographics — age group, segment, join date |
| `dim_Location` | Branch and region details |
| `dim_Product` | Loan product types and categories |
| `dim_Officer` | Loan officer information |

> 📄 See the full ERD diagram in 

---

## 📁 Repository Structure

```
banking-data-project/
│
├── README.md
│
├── data/
│   ├── raw/                  # Original Excel flat file
│   └── processed/            # Cleaned CSVs exported from Power Query
│
├── sql/
│   ├── 01_schema.sql         # CREATE TABLE statements (star schema DDL)
│   ├── 02_load_data.sql      # Data loading scripts (COPY / INSERT)
│   ├── 03_analysis.sql       # Analytical queries — window functions, CTEs
│   └── 04_views.sql          # Reusable SQL views
│
├── python/
│   ├── import_excel.py       # Loads Excel star schema tables into PostgreSQL
│   └── requirements.txt      # Python dependencies
│
├── reports/
│   ├── charts/               # Dashboard screenshots (Tableau & Power BI)
│   └── summary.md            # Key findings and insights
│
└── docs/
    ├── erd.png               # Star schema ERD diagram
    └── data_dictionary.md    # Column descriptions for all tables
```

---

## 🔍 SQL Analysis Highlights

Key queries written in PostgreSQL (`sql/03_analysis.sql`):

- **Branch Growth Analysis** — Used `LAG()` window function to calculate year-over-year transaction growth per branch
- **Loan Officer Rankings** — Used `RANK()` to rank officers by loan volume within each region
- **Product Concentration** — Identified top products by total disbursed loan amount using CTEs
- **Overdue Loan Segmentation** — Segmented overdue loans by client tier and location using multi-table JOINs
- **Cross-database Queries** — Queried across `banking_db` and `project2` databases in PostgreSQL

---

## 📊 Key Findings

- Top 3 high-growth branches identified using YoY LAG analysis
- 2 loan products account for the majority of total disbursed loan value — indicating concentration risk
- Loan officer performance varies significantly by region, visible in the Power BI dashboard
- Client segments differ considerably by location, highlighted in the Tableau dashboard

> 📸 Dashboard screenshots available in [`reports/charts/`](reports/charts/)

---

## ⚙️ Setup & How to Run

### Prerequisites
- PostgreSQL installed and running locally
- Python 3.12
- `psycopg2-binary` (not `psycopg2`) — required for Python 3.12 compatibility

### Steps

**1. Clone the repository**
```bash
git clone https://github.com/your-username/banking-data-project.git
cd banking-data-project
```

**2. Set up the PostgreSQL database**
```sql
-- Run in pgAdmin or DBeaver
\i sql/01_schema.sql
```

**3. Install Python dependencies**
```bash
pip install -r python/requirements.txt
```

**4. Load data into PostgreSQL**
```bash
python python/import_excel.py
```
> ⚠️ Update the database connection string in `import_excel.py` before running. If your password contains special characters (e.g. `@`), encode them using `urllib.parse.quote_plus()`.

**5. Run SQL analysis**

Open `sql/03_analysis.sql` in pgAdmin, DBeaver, or VS Code (SQLTools extension) and run queries.

**6. Open dashboards**

- Tableau: Open `.twbx` file from `reports/` and connect to your local PostgreSQL instance
- Power BI: Open `.pbix` file from `reports/` and update the data source to your local PostgreSQL

---

## 📦 Python Dependencies

```
pandas
sqlalchemy
psycopg2-binary
openpyxl
```

Install with:
```bash
pip install -r python/requirements.txt
```

---

## 👤 Author

**Sanskar**
Data Analyst | Banking & Financial Services Domain
📍 India

---

## 📝 Notes

- Raw data file is not included in the repository due to size. A sample anonymized version is available in `data/raw/`.
- Dashboard `.twbx` and `.pbix` files connect to a local PostgreSQL instance — update the server/credentials after cloning.
