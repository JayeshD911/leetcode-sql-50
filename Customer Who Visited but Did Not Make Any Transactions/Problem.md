# Customer Who Visited but Did Not Make Any Transactions

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

## 📘 Problem Statement

Write an SQL query to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

Return the result table sorted in any order.

---

## 🧠 Approach

We have two tables:

### `Visits`

| Column Name | Type |
|-------------|------|
| visit_id    | int  |
| customer_id | int  |

### `Transactions`

| Column Name    | Type |
|----------------|------|
| transaction_id | int  |
| visit_id       | int  |
| amount         | int  |

---

## 🔍 Key Observation

- Every transaction is linked to a `visit_id`
- If a visit does NOT appear in `Transactions`
  → then that visit had no transaction

👉 We need:
1. visits with no matching transaction
2. count such visits per customer

---

## ✅ SQL Query

```sql
SELECT
    v.customer_id,
    COUNT(*) AS count_no_trans
FROM Visits v
         LEFT JOIN Transactions t
                   ON v.visit_id = t.visit_id
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id;
```

---------------------

## 🔍 Why LEFT JOIN?

We must keep:
- all visits ✅
- even visits without transactions ✅

`LEFT JOIN` preserves all rows from `Visits`.

If no match exists:
```text
Transactions columns → NULL
```

---

## 🔍 Why `WHERE t.transaction_id IS NULL`?

After LEFT JOIN:

### Matched Visit

| visit_id | transaction_id |
|----------|----------------|
| 1        | 100 |

### Unmatched Visit

| visit_id | transaction_id |
|----------|----------------|
| 2        | NULL |

👉 `NULL` means:
```text
No transaction exists
```

So:

```sql
WHERE t.transaction_id IS NULL
```

filters visits with no transactions.

---

## 🧪 Example

### Visits

| visit_id | customer_id |
|----------|-------------|
| 1        | 23 |
| 2        | 9 |
| 4        | 30 |
| 5        | 54 |
| 6        | 96 |

---

### Transactions

| transaction_id | visit_id | amount |
|----------------|----------|--------|
| 2              | 5        | 310 |
| 3              | 5        | 300 |
| 9              | 1        | 910 |

---

## 🔄 Matching

- visit 1 → has transaction ✅
- visit 5 → has transactions ✅
- visit 2 → no transaction ❌
- visit 4 → no transaction ❌
- visit 6 → no transaction ❌

---

## ✅ Filtered Rows

| customer_id |
|-------------|
| 9 |
| 30 |
| 96 |

---

## ✅ Final Output

| customer_id | count_no_trans |
|-------------|----------------|
| 9           | 1 |
| 30          | 1 |
| 96          | 1 |

---

## ⏱️ Complexity Analysis

### Time Complexity
```text
O(n + m)
```

Where:
- `n` = Visits rows
- `m` = Transactions rows

(assuming indexed joins)

---

### Space Complexity
```text
O(1)
```

No extra space used.

---

## 🎯 Key SQL Concepts Used

### LEFT JOIN + NULL Filtering

Classic pattern:

```sql
LEFT JOIN ...
WHERE right_table.column IS NULL
```

Used to find:
- missing relationships
- unmatched rows
- records without mappings

---

## 🚀 Final Takeaway

This is one of the most important SQL interview patterns.

Core idea:

```text
Find rows in Table A
that do NOT exist in Table B
```

Using:

```sql
LEFT JOIN + IS NULL
```