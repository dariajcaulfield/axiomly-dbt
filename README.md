Axiomly dbt Project
This repo contains a dbt project modeling data for Axiomly, a mock B2B SaaS platform. It demonstrates analytics engineering practices including staging, core modeling, snapshots, and marts.
---
📊 Domain Coverage
Axiomly simulates a SaaS company with the following data areas:

- CRM: Accounts, contacts
- Product: Accounts, users, events, usage
- Billing: Subscriptions, invoices, invoice lines, payments
- Support: Tickets and SLA metrics
- Marketing: Email campaign events
- Finance / Admin: FX rates, plan catalog

In total, the project seeds 14 raw tables, staged and transformed through dbt.
---
🏗️ Project Structure
models/
  staging/    # Raw → cleaned sources
  core/       # Conformed dimensions & fact tables
  marts/      # Business-ready models (revenue, product, support)
snapshots/    # Slowly changing dimensions (e.g., account plan history)
seeds/        # Synthetic raw data
macros/       # Utility SQL (keys, cohorts, funnels)
---
📈 Analytics Examples
The marts layer produces common SaaS metrics:

- Revenue: MRR, ARR, Net Revenue Retention (NRR), Gross Revenue Retention (GRR)
- Customer Lifecycle: churn, expansions, reactivations
- Product: activation funnels, DAU/WAU/MAU, usage cohorts
- Support: SLA compliance, backlog analysis
- Marketing: email campaign engagement
---
🚀 Getting Started
1. Clone this repo:
   git clone https://github.com/<your-username>/axiomly-dbt.git
   cd axiomly-dbt

2. Install dbt (Core or via dbt Cloud). Example with pip:
   pip install dbt-core dbt-snowflake  # or dbt-postgres, dbt-bigquery

3. Configure your profiles.yml to connect to your warehouse.

4. Seed the mock data:
   dbt seed

5. Run the models:
   dbt run

6. Explore the docs:
   dbt docs generate
   dbt docs serve
---
🧑‍💻 Why This Repo?
This project was built as a portfolio showcase for analytics engineering roles. It emphasizes:

- Clean, tested dbt models
- Incremental pipelines and SCD2 snapshots
- Realistic SaaS-style metrics and business logic
- A professional project layout and documentation
---
📜 License
All data is synthetic and for demonstration purposes only.