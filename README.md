# Financial Services 360 — Churn Analytics with Salesforce Data Cloud & Einstein Discovery

## Purpose
Enablement-style demo showing how to model customer churn using **Salesforce Data Cloud (DMOs + Calculated Insights)**, explain predictions with **Einstein Discovery**, and tell the story in **CRM Analytics (Tableau CRM)**. Data is fully **synthetic**.

---

## Architecture
```
flowchart LR
  A[Data Sources (CSV)] --> B[Data Cloud DLOs]
  B --> C[DMOs: Customer, Account, Transaction]
  C --> D[Calculated Insights (features per customer)]
  D --> E[Einstein Discovery Model (churn + drivers)]
  E --> F[CRM Analytics Dashboard (FS 360)]
  F --> G[Action Plan (Next-Best Action)]
```
See: `assets/architecture.mmd`

---

## Repository Layout
```
financial-services-360-data-cloud-ai/
├── README.md
├── requirements.txt
├── .gitignore
├── data/                      # synthetic CSVs
├── notebooks/
│   ├── 01_generate_synthetic_data.ipynb
│   └── 02_feature_engineering.ipynb
├── datacloud/
│   ├── calculated_insights.sql
│   └── dmo_relationships.md
├── ed/
│   ├── training_dataset.csv
│   ├── scoring_dataset.csv
│   └── model_readme.md
├── crm_analytics/
│   ├── dashboard_spec.md
│   └── screenshots/
└── assets/
    └── architecture.mmd
```

---

## Quickstart

### 1) Local setup
```bash
python -m venv .venv
# Windows: .venv\Scripts\activate
source .venv/bin/activate
pip install -r requirements.txt
jupyter notebook
```

### 2) Generate synthetic data
Open `notebooks/01_generate_synthetic_data.ipynb` and run all cells.  
CSV outputs land in `/data`.

### 3) Configure Data Cloud
1. Create **Data Streams** from `/data/*.csv`  
2. Define **DMOs**: `Customer` (Profile), `Account` (Profile Object), `Transaction` (Event)  
3. Relationships: Customer 1-* Account 1-* Transaction  
4. Run **Calculated Insights** (`datacloud/calculated_insights.sql`) → produces feature table per customer

### 4) Einstein Discovery
- Train model with target `churn_90d` using `/ed/training_dataset.csv`
- Capture **top drivers** and **reason codes**; add notes in `ed/model_readme.md`

### 5) CRM Analytics
- Build an exec dashboard per `crm_analytics/dashboard_spec.md`
- Add screenshots to `crm_analytics/screenshots/`

### 6) Summary
> *High-fee, low-tenure, low-balance customers are 2.3× more likely to churn. Prioritize fee reversal outreach and savings cross-sell for retention.*

---


---


### Databricks (PySpark)
See `/databricks/` for a PySpark notebook that computes the same features at scale in **Databricks Community Edition**.

### Tableau
See `/tableau/` for steps to create a lightweight executive dashboard using a sample CSV.

### Data Wrangling
Primary wrangling is done in **Python** (`pandas` notebooks). The Databricks path demonstrates **PySpark** for scale.
