# Biggest Single Number

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

# 📘 Problem Statement

A **single number** is a number that appears:

```text
exactly once
```

in the table.

We need to return:

```text
the largest single number
```

If no single number exists, return:

```text
NULL
```

---

# 🧠 Intuition

To find the biggest single number:

1. Group rows by number.
2. Keep only numbers appearing exactly once.
3. Among those numbers, return the largest one.

👉 This is a classic:

```text
GROUP BY + HAVING + MAX
```

problem.

---

# 🔍 Table

## `MyNumbers`

| Column Name | Type |
|-------------|------|
| num         | int |

---

## Example

### MyNumbers

| num |
|-----|
| 8 |
| 8 |
| 3 |
| 3 |
| 1 |
| 4 |
| 5 |
| 6 |
| 6 |

---

### Frequency Count

| num | count |
|-----|--------|
| 1 | 1 |
| 3 | 2 |
| 4 | 1 |
| 5 | 1 |
| 6 | 2 |
| 8 | 2 |

---

Single numbers:

```text
1, 4, 5
```

Largest:

```text
5
```

---

# ✅ SQL Query

```sql
SELECT
    MAX(num) AS num
FROM (
    SELECT
        num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
) t;
```

---------------------

# 🔍 Step-by-Step Explanation

---

# 1️⃣ Group Numbers

```sql
GROUP BY num
```

Creates one group per distinct number.

---

### Example

| num |
|-----|
| 8 |
| 8 |
| 3 |
| 3 |
| 1 |
| 4 |
| 5 |

Groups become:

```text
8 → 2 rows
3 → 2 rows
1 → 1 row
4 → 1 row
5 → 1 row
```

---

# 2️⃣ Keep Only Single Numbers

```sql
HAVING COUNT(*) = 1
```

Filters groups whose frequency is exactly one.

---

### Result

| num |
|-----|
| 1 |
| 4 |
| 5 |

---

# 3️⃣ Find the Largest Single Number

```sql
MAX(num)
```

From:

```text
1, 4, 5
```

returns:

```text
5
```

---

# ✅ Final Output

| num |
|-----|
| 5 |

---

# 🧪 Example Walkthrough

### Input

| num |
|-----|
| 2 |
| 2 |
| 5 |
| 7 |
| 7 |
| 10 |

---

### Frequency

| num | count |
|-----|--------|
| 2 | 2 |
| 5 | 1 |
| 7 | 2 |
| 10 | 1 |

---

### Single Numbers

```text
5
10
```

---

### Largest

```text
10
```

---

### Output

| num |
|-----|
| 10 |

---

# ⚠️ Edge Case

### Input

| num |
|-----|
| 1 |
| 1 |
| 2 |
| 2 |

---

Frequency:

| num | count |
|-----|--------|
| 1 | 2 |
| 2 | 2 |

No number appears exactly once.

---

Subquery returns:

```text
(empty set)
```

Then:

```sql
MAX(num)
```

returns:

```text
NULL
```

which is exactly what the problem expects.

---

# ⏱️ Complexity Analysis

## Time Complexity

```text
O(n)
```

Where:
- `n` = rows in MyNumbers

---

## Space Complexity

```text
O(k)
```

Where:
- `k` = number of distinct values

Used internally for grouping.

---

# 🎯 Important SQL Concepts Used

---

# 1️⃣ GROUP BY

```sql
GROUP BY num
```

Groups identical numbers together.

---

# 2️⃣ COUNT(*)

```sql
COUNT(*)
```

Counts occurrences of each number.

---

# 3️⃣ HAVING

```sql
HAVING COUNT(*) = 1
```

Filters groups after aggregation.

---

# 4️⃣ MAX()

```sql
MAX(num)
```

Finds the largest value.

---

# ⚠️ WHERE vs HAVING

Wrong:

```sql
WHERE COUNT(*) = 1
```

Reason:

```text
COUNT() is an aggregate function.
Aggregates cannot be used in WHERE.
```

Correct:

```sql
HAVING COUNT(*) = 1
```

---

# 🚀 Alternative Solution

You can also solve it using a Common Table Expression (CTE):

```sql
WITH singles AS (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
)
SELECT MAX(num) AS num
FROM singles;
```

---

# 🚀 Interview Insight

This problem tests a very common SQL pattern:

```sql
GROUP BY
+
HAVING
+
Aggregate Function
```

Similar questions include:

- Customers with exactly one order
- Products sold only once
- Users with a single login
- Unique values in a dataset

---

# 🚀 Final Takeaway

This problem teaches:

- `GROUP BY`
- `COUNT(*)`
- `HAVING`
- `MAX()`

Core idea:

```text
Find numbers occurring exactly once,
then return the largest among them.
```