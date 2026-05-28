# Immediate Food Delivery II

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

# 📘 Problem Statement

If:
```text
customer_pref_delivery_date = order_date
```

then the order is considered:

```text
immediate
```

Otherwise, it is:

```text
scheduled
```

We need to find:

```text
percentage of customers
whose first order was immediate
```

Rounded to:
```text
2 decimal places
```

---

# 🧠 Intuition

For every customer:
1. find their first order
2. check if it was immediate
3. compute percentage

---

# 🔍 Table

## `Delivery`

| Column Name | Type |
|-------------|------|
| delivery_id | int |
| customer_id | int |
| order_date  | date |
| customer_pref_delivery_date | date |

---

# 🧩 Key Observation

We only care about:
```text
the FIRST order of each customer
```

Then:
- immediate → preferred date = order date
- scheduled → otherwise

👉 This is a classic:

```text
GROUP BY + Filtering + Conditional Aggregation
```

problem.

---

# ✅ SQL Query

```sql
SELECT 
    ROUND(
        AVG(
            CASE 
                WHEN order_date = customer_pref_delivery_date 
                THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (
    SELECT 
        customer_id,
        MIN(order_date)
    FROM Delivery
    GROUP BY customer_id
);
```

---------------------

# 🔍 Step-by-Step Explanation

---

# 1️⃣ Find First Order Per Customer

```sql
SELECT 
    customer_id,
    MIN(order_date)
FROM Delivery
GROUP BY customer_id
```

This gives:

| customer_id | first_order |
|-------------|-------------|
| 1 | 2019-08-01 |
| 2 | 2019-08-02 |

---

# 2️⃣ Filter Only First Orders

```sql
WHERE (customer_id, order_date) IN (...)
```

Keeps only rows corresponding to:
```text
customer's first order
```

---

## Example

### Delivery Table

| customer_id | order_date | pref_date |
|-------------|------------|-----------|
| 1 | 2019-08-01 | 2019-08-01 |
| 1 | 2019-08-11 | 2019-08-12 |
| 2 | 2019-08-02 | 2019-08-03 |

---

### Filtered First Orders

| customer_id | order_date | pref_date |
|-------------|------------|-----------|
| 1 | 2019-08-01 | 2019-08-01 |
| 2 | 2019-08-02 | 2019-08-03 |

---

# 3️⃣ Check Immediate Orders

Condition:

```sql
order_date = customer_pref_delivery_date
```

---

## Convert to 1s and 0s

```sql
CASE 
    WHEN order_date = customer_pref_delivery_date 
    THEN 1
    ELSE 0
END
```

Result:

| customer | value |
|----------|------|
| 1 | 1 |
| 2 | 0 |

---

# 4️⃣ Compute Percentage

```sql
AVG(...) * 100
```

Why `AVG` works:

```text
Average of 1s and 0s = percentage of 1s
```

---

## Example

```text
(1 + 0) / 2 = 0.5
```

Multiply by 100:

```text
50.00%
```

---

# 5️⃣ ROUND()

```sql
ROUND(value, 2)
```

Rounds answer to:
```text
2 decimal places
```

---

# ✅ Final Output

| immediate_percentage |
|----------------------|
| 50.00 |

---

# ⏱️ Complexity Analysis

## Time Complexity

```text
O(n)
```

Where:
- `n` = rows in Delivery

(with indexing)

---

## Space Complexity

```text
O(1)
```

Ignoring output storage.

---

# 🎯 Important SQL Concepts Used

---

# 1️⃣ GROUP BY

```sql
GROUP BY customer_id
```

Finds first order per customer.

---

# 2️⃣ MIN()

```sql
MIN(order_date)
```

Gets earliest order date.

---

# 3️⃣ Tuple Comparison

```sql
(customer_id, order_date) IN (...)
```

Used to filter exact row pairs.

---

# 4️⃣ CASE WHEN

```sql
CASE 
    WHEN condition THEN 1
    ELSE 0
END
```

Used for conditional calculations.

---

# 5️⃣ Conditional Aggregation

```sql
AVG(CASE WHEN ... THEN 1 ELSE 0 END)
```

Very important SQL interview pattern.

---

# ⚠️ Important SQL Insight

Why use:

```sql
AVG(1s and 0s)
```

instead of manually counting?

Because:

```text
AVG(1,0,1,1)
=
(number of 1s / total rows)
```

Very elegant SQL technique.

---

# 🚀 Alternative Solution (Using JOIN)

Another valid solution:

```sql
SELECT 
    ROUND(
        AVG(
            CASE 
                WHEN d.order_date = d.customer_pref_delivery_date 
                THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS immediate_percentage
FROM Delivery d
JOIN (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order
    FROM Delivery
    GROUP BY customer_id
) f
ON d.customer_id = f.customer_id
AND d.order_date = f.first_order;
```

---

# 🚀 Interview Insight

This problem teaches:
- first-row-per-group pattern
- conditional aggregation
- filtering grouped results

Very common SQL interview topic.

---

# 🚀 Final Takeaway

This problem combines:
- grouping
- filtering
- conditional aggregation
- percentage calculation

Core idea:

```text
Find first record per group
then compute conditional percentage
```