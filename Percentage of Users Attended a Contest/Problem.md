# Percentage of Users Attended a Contest

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

# 📘 Problem Statement

Write an SQL query to find:
- the percentage of users registered in each contest

The percentage should be:
- rounded to 2 decimal places
- ordered by:
    1. percentage descending
    2. contest_id ascending

---

# 🧠 Intuition

For each contest:

```text
percentage =
(users registered in contest / total users) × 100
```

So we need:
1. total number of users
2. users registered per contest
3. compute percentage

---

# 🔍 Tables

## `Users`

| Column Name | Type |
|-------------|------|
| user_id     | int |

Contains all platform users.

---

## `Register`

| Column Name | Type |
|-------------|------|
| contest_id  | int |
| user_id     | int |

Contains:
```text
which user registered for which contest
```

---

# 🧩 Key Observation

For each contest:
- count registered users
- divide by total users
- multiply by 100

👉 This is a classic:

```text
GROUP BY + COUNT + Aggregate Calculation
```

problem.

---

# ✅ SQL Query

```sql
SELECT 
    r.contest_id,
    ROUND(
        COUNT(r.user_id) * 100.0 /
        (SELECT COUNT(*) FROM Users),
        2
    ) AS percentage
FROM Register r
GROUP BY r.contest_id
ORDER BY percentage DESC, r.contest_id ASC;
```

---------------------

# 🔍 Step-by-Step Explanation

---

## 1️⃣ Count Users Per Contest

```sql
COUNT(r.user_id)
```

Counts:
```text
number of registrations in each contest
```

---

## 🧪 Example

### Register Table

| contest_id | user_id |
|------------|---------|
| 215 | 6 |
| 209 | 2 |
| 208 | 2 |
| 210 | 6 |
| 208 | 6 |
| 209 | 7 |
| 209 | 6 |
| 215 | 7 |
| 208 | 7 |
| 210 | 2 |
| 207 | 2 |
| 210 | 7 |

---

### Contest Counts

| contest_id | registered_users |
|------------|------------------|
| 207 | 1 |
| 208 | 3 |
| 209 | 3 |
| 210 | 3 |
| 215 | 2 |

---

## 2️⃣ Total Users

```sql
(SELECT COUNT(*) FROM Users)
```

Suppose:
```text
Total users = 7
```

---

## 3️⃣ Compute Percentage

Formula:

```sql
COUNT(user_id) * 100.0 / total_users
```

Example:

### Contest 208

```text
(3 / 7) × 100 = 42.857...
```

Rounded:

```text
42.86
```

---

## 4️⃣ ROUND()

```sql
ROUND(value, 2)
```

Rounds to:
```text
2 decimal places
```

---

## 5️⃣ ORDER BY

```sql
ORDER BY percentage DESC, contest_id ASC
```

Sorts:
1. highest percentage first
2. smaller contest_id first if tied

---

# ✅ Final Output

| contest_id | percentage |
|------------|------------|
| 208 | 42.86 |
| 209 | 42.86 |
| 210 | 42.86 |
| 215 | 28.57 |
| 207 | 14.29 |

---

# ⏱️ Complexity Analysis

## Time Complexity

```text
O(n)
```

Where:
- `n` = rows in Register

---

## Space Complexity

```text
O(1)
```

No extra space used.

---

# 🎯 Important SQL Concepts Used

---

## 1️⃣ COUNT()

```sql
COUNT(column)
```

Counts rows.

---

## 2️⃣ GROUP BY

```sql
GROUP BY contest_id
```

Creates separate groups per contest.

---

## 3️⃣ Subquery

```sql
(SELECT COUNT(*) FROM Users)
```

Gets total number of users.

---

## 4️⃣ ROUND()

```sql
ROUND(value, decimals)
```

Rounds decimal values.

---

## 5️⃣ ORDER BY Multiple Columns

```sql
ORDER BY percentage DESC, contest_id ASC
```

Sorting by multiple conditions.

---

# ⚠️ Important SQL Insight

Why use:

```sql
100.0
```

instead of:

```sql
100
```

Because:
- `100` may cause integer division
- `100.0` forces decimal calculation

Very important interview detail.

---

# 🚀 Interview Insight

This is a very common analytics-style SQL problem.

Pattern:

```text
GROUP BY + percentage calculation
```

Used heavily in:
- dashboards
- reporting
- business analytics

---

# 🚀 Final Takeaway

This problem teaches:
- aggregation
- percentages
- subqueries
- sorting results

Core idea:

```text
Count grouped data
then compute ratios/percentages
```