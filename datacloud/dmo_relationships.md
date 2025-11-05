# Data Cloud DMOs & Relationships

**DMOs**
- `Customer` (Profile) — PK: `customer_id`
- `Account` (Profile Object) — PK: `account_id`, FK to Customer via `customer_id`
- `Transaction` (Event) — FK to Account via `account_id`, event time: `txn_date`

**Relationships**
- Customer (1) — (*) Account
- Account (1) — (*) Transaction

**Notes**
- Ensure Data Streams map CSV fields correctly.
- Use this as source for Calculated Insights → feature table per customer.
