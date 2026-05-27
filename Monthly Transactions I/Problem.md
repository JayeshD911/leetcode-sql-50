# Monthly Transactions I

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

# 📘 Problem Statement

Write an SQL query to find for each:
- month
- country

the following:

1. total number of transactions
2. total amount of transactions
3. total number of approved transactions
4. total amount of approved transactions

Return the result table in any order.

---

# 🧠 Intuition

We need to group transactions by:

```text
(month, country)
```

Then compute:
- total transactions
- total amounts
- approved transaction counts
- approved transaction amounts

👉 This is a classic:

```text
GROUP BY + Conditional Aggregation
```

problem.

---

# 🔍 Table

## `Transactions`

| Column Name | Type |
|-------------|------|
| id          | int |
| country     | varchar |
| state       | enum |
| amount      | int |
| trans_date  | date |

Where:
```text
state = 'approved' or 'declined'
```

---

# ✅ SQL Query

```sql
SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    
    COUNT(*) AS trans_count,
    
    SUM(amount) AS trans_total_amount,
    
    SUM(CASE 
            WHEN state = 'approved' THEN 1
            ELSE 0
        END) AS approved_count,
    
    SUM(CASE 
            WHEN state = 'approved' THEN amount
            ELSE 0
        END) AS approved_total_amount

FROM Transactions

GROUP BY 
    month,
    country;
```

---------------------

# 🔍 Step-by-Step Explanation

---

# 1️⃣ Extract Month

```sql
DATE_FORMAT(trans_date, '%Y-%m')
```

Converts:

```text
2019-01-15 → 2019-01
```

This groups transactions monthly.

---

# 2️⃣ GROUP BY Month and Country

```sql
GROUP BY month, country
```

Creates groups like:

```text
(2019-01, US)
(2019-01, IN)
(2019-02, US)
```

---

# 🧪 Example

### Transactions Table

| id | country | state | amount | trans_date |
|----|---------|-------|--------|------------|
| 1 | US | approved | 1000 | 2019-01-01 |
| 2 | US | declined | 2000 | 2019-01-02 |
| 3 | US | approved | 3000 | 2019-01-10 |
| 4 | IN | approved | 4000 | 2019-01-15 |

---

# 3️⃣ Total Transactions

```sql
COUNT(*)
```

Counts all rows in the group.

---

## Example

For:
```text
(2019-01, US)
```

Rows:
```text
3
```

So:

```text
trans_count = 3
```

---

# 4️⃣ Total Transaction Amount

```sql
SUM(amount)
```

Example:

```text
1000 + 2000 + 3000 = 6000
```

---

# 5️⃣ Approved Transaction Count

```sql
SUM(
    CASE 
        WHEN state = 'approved' THEN 1
        ELSE 0
    END
)
```

Converts rows into:

| state | value |
|------|------|
| approved | 1 |
| declined | 0 |

Then sums them.

---

## Example

```text
1 + 0 + 1 = 2
```

So:

```text
approved_count = 2
```

---

# 6️⃣ Approved Transaction Amount

```sql
SUM(
    CASE 
        WHEN state = 'approved' THEN amount
        ELSE 0
    END
)
```

Adds only approved amounts.

---

## Example

```text
1000 + 3000 = 4000
```

So:

```text
approved_total_amount = 4000
```

---

# ✅ Final Output

| month | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
|------|---------|-------------|----------------|-------------------|----------------------|
| 2019-01 | US | 3 | 2 | 6000 | 4000 |
| 2019-01 | IN | 1 | 1 | 4000 | 4000 |

---

# ⏱️ Complexity Analysis

## Time Complexity

```text
O(n)
```

Where:
- `n` = number of transactions

---

## Space Complexity

```text
O(1)
```

Ignoring output storage.

---

# 🎯 Important SQL Concepts Used

---

# 1️⃣ GROUP BY Multiple Columns

```sql
GROUP BY month, country
```

Groups by combined keys.

---

# 2️⃣ DATE_FORMAT()

```sql
DATE_FORMAT(date, '%Y-%m')
```

Extracts year-month format.

---

# 3️⃣ Conditional Aggregation

```sql
SUM(CASE WHEN condition THEN value ELSE 0 END)
```

Very important SQL pattern.

---

# 4️⃣ Aggregate Functions

- `COUNT()`
- `SUM()`

Used for analytics calculations.

---

# ⚠️ Important SQL Insight

This pattern:

```sql
SUM(CASE WHEN condition THEN 1 ELSE 0 END)
```

is widely used to:
- count conditional rows
- compute metrics
- build dashboards

---

# 🚀 Interview Insight

This problem is extremely common in:
- analytics engineering
- reporting systems
- business intelligence

Core pattern:

```text
GROUP BY + Conditional Aggregation
```

---

# 🚀 Final Takeaway

This problem teaches:
- grouping data
- monthly aggregation
- conditional counting
- conditional sums

Core idea:

```text
Aggregate grouped data
while selectively counting/summing rows
```