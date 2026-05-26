# Queries Quality and Percentage

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

# 📘 Problem Statement

We define:

## Query Quality

```text
quality = AVG(rating / position)
```

---

## Poor Query Percentage

A query is considered:
```text
poor
```

if:
```text
rating < 3
```

Poor query percentage:

```text
(poor queries / total queries) × 100
```

We need to return:
- `query_name`
- `quality`
- `poor_query_percentage`

Rounded to:
```text
2 decimal places
```

---

# 🧠 Intuition

For each `query_name`:
1. calculate average of:
   ```text
   rating / position
   ```
2. calculate percentage of rows where:
   ```text
   rating < 3
   ```

👉 This is a classic:

```text
GROUP BY + Aggregate Calculations
```

problem.

---

# 🔍 Table

## `Queries`

| Column Name | Type |
|-------------|------|
| query_name  | varchar |
| result      | varchar |
| position    | int |
| rating      | int |

---

# ✅ SQL Query

```sql
SELECT 
    query_name,
    
    ROUND(AVG(rating * 1.0 / position), 2) AS quality,
    
    ROUND(
        AVG(
            CASE 
                WHEN rating < 3 THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS poor_query_percentage

FROM Queries
GROUP BY query_name;
```

---------------------

# 🔍 Step-by-Step Explanation

---

# 1️⃣ GROUP BY Query Name

```sql
GROUP BY query_name
```

Creates separate groups for each query.

---

## Example

### Queries Table

| query_name | rating | position |
|------------|--------|----------|
| Dog | 5 | 1 |
| Dog | 4 | 2 |
| Dog | 1 | 200 |
| Cat | 2 | 5 |
| Cat | 3 | 3 |

---

### Groups

#### Dog
```text
(5,1), (4,2), (1,200)
```

#### Cat
```text
(2,5), (3,3)
```

---

# 2️⃣ Compute Query Quality

Formula:

```text
AVG(rating / position)
```

---

## Dog Example

### Calculations

```text
5/1   = 5
4/2   = 2
1/200 = 0.005
```

Average:

```text
(5 + 2 + 0.005) / 3
= 2.335
```

Rounded:

```text
2.34
```

---

# 3️⃣ Find Poor Queries

Condition:

```sql
rating < 3
```

We use:

```sql
CASE WHEN rating < 3 THEN 1 ELSE 0 END
```

This converts rows into:

| rating | value |
|--------|------|
| 5 | 0 |
| 4 | 0 |
| 1 | 1 |

---

# 4️⃣ Compute Poor Query Percentage

```sql
AVG(CASE ...) * 100
```

Why `AVG` works:

```text
Average of 0s and 1s = percentage of 1s
```

---

## Dog Example

Values:

```text
0, 0, 1
```

Average:

```text
1/3 = 0.3333
```

Multiply by 100:

```text
33.33%
```

---

# 5️⃣ ROUND()

```sql
ROUND(value, 2)
```

Rounds answers to:
```text
2 decimal places
```

---

# ✅ Final Output

| query_name | quality | poor_query_percentage |
|------------|---------|------------------------|
| Dog | 2.34 | 33.33 |
| Cat | 0.70 | 50.00 |

---

# ⏱️ Complexity Analysis

## Time Complexity

```text
O(n)
```

Where:
- `n` = number of rows in Queries

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
GROUP BY query_name
```

Groups rows per query.

---

# 2️⃣ AVG()

```sql
AVG(expression)
```

Calculates averages.

---

# 3️⃣ CASE WHEN

```sql
CASE 
    WHEN condition THEN value
    ELSE value
END
```

Used for conditional calculations.

---

# 4️⃣ Conditional Aggregation

```sql
AVG(CASE WHEN ... THEN 1 ELSE 0 END)
```

Very important SQL interview pattern.

Used for:
- percentages
- ratios
- conditional counting

---

# ⚠️ Important SQL Insight

Why use:

```sql
rating * 1.0 / position
```

instead of:

```sql
rating / position
```

Because:
- integer division may truncate decimals
- `1.0` forces floating-point calculation

---

# 🚀 Interview Insight

This problem teaches one of the most important SQL techniques:

```text
Conditional Aggregation
```

Pattern:

```sql
AVG(CASE WHEN condition THEN 1 ELSE 0 END)
```

Used heavily in:
- analytics
- dashboards
- reporting

---

# 🚀 Final Takeaway

This problem combines:
- grouping
- averages
- percentages
- CASE expressions

Core idea:

```text
Use conditional aggregation
to compute percentages efficiently
```