# Find Followers Count

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

# 📘 Problem Statement

Write an SQL query to report:

```text
the number of followers for each user
```

Return:

| user_id | followers_count |
|----------|----------------|

Ordered by:

```text
user_id ASC
```

---

# 🧠 Intuition

Each row in the table represents:

```text
A follower follows a user
```

To find a user's follower count:

1. group rows by `user_id`
2. count followers for each user

👉 This is a classic:

```text
GROUP BY + COUNT
```

problem.

---

# 🔍 Table

## `Followers`

| Column Name | Type |
|-------------|------|
| user_id     | int |
| follower_id | int |

---

## Example

### Followers

| user_id | follower_id |
|----------|-------------|
| 0 | 1 |
| 1 | 0 |
| 2 | 0 |
| 2 | 1 |

---

Interpretation:

```text
User 1 follows User 0
User 0 follows User 1
User 0 follows User 2
User 1 follows User 2
```

---

# 🧩 Key Observation

For every:

```text
user_id
```

we simply need:

```text
number of follower_id rows
```

---

# ✅ SQL Query

```sql
SELECT
    user_id,
    COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;
```

---------------------

# 🔍 Step-by-Step Explanation

---

# 1️⃣ Group Rows by User

```sql
GROUP BY user_id
```

Creates one group per user.

---

### Example

#### User 0

| follower_id |
|-------------|
| 1 |

Count:

```text
1
```

---

#### User 1

| follower_id |
|-------------|
| 0 |

Count:

```text
1
```

---

#### User 2

| follower_id |
|-------------|
| 0 |
| 1 |

Count:

```text
2
```

---

# 2️⃣ Count Followers

```sql
COUNT(follower_id)
```

Counts how many followers belong to each user.

---

### Result

| user_id | followers_count |
|----------|----------------|
| 0 | 1 |
| 1 | 1 |
| 2 | 2 |

---

# 3️⃣ Sort by User ID

```sql
ORDER BY user_id
```

Ensures ascending order.

---

# ✅ Final Output

| user_id | followers_count |
|----------|----------------|
| 0 | 1 |
| 1 | 1 |
| 2 | 2 |

---

# ⏱️ Complexity Analysis

## Time Complexity

```text
O(n)
```

Where:
- `n` = number of rows in Followers

---

## Space Complexity

```text
O(k)
```

Where:
- `k` = number of distinct users

Used internally for grouping.

---

# 🎯 Important SQL Concepts Used

---

# 1️⃣ GROUP BY

```sql
GROUP BY user_id
```

Groups rows user-wise.

---

# 2️⃣ COUNT()

```sql
COUNT(follower_id)
```

Counts followers in each group.

---

# 3️⃣ ORDER BY

```sql
ORDER BY user_id
```

Sorts results in ascending order.

---

# 🧪 Example Walkthrough

### Input

| user_id | follower_id |
|----------|-------------|
| 1 | 10 |
| 1 | 11 |
| 1 | 12 |
| 2 | 10 |
| 3 | 20 |
| 3 | 21 |

---

### Grouped

#### User 1

Followers:

```text
10, 11, 12
```

Count:

```text
3
```

---

#### User 2

Followers:

```text
10
```

Count:

```text
1
```

---

#### User 3

Followers:

```text
20, 21
```

Count:

```text
2
```

---

### Output

| user_id | followers_count |
|----------|----------------|
| 1 | 3 |
| 2 | 1 |
| 3 | 2 |

---

# ⚠️ Common Mistake

Wrong:

```sql
SELECT
    user_id,
    follower_id
FROM Followers
GROUP BY user_id;
```

Reason:

```text
follower_id is neither aggregated
nor part of GROUP BY
```

This is invalid (or produces unreliable results depending on SQL mode).

---

# 🚀 Alternative Solution

Since `follower_id` is never NULL in this problem:

```sql
COUNT(*)
```

also works.

```sql
SELECT
    user_id,
    COUNT(*) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;
```

---

# 🎓 COUNT(*) vs COUNT(column)

### COUNT(*)

Counts all rows.

```sql
COUNT(*)
```

---

### COUNT(column)

Counts non-null values.

```sql
COUNT(follower_id)
```

Since `follower_id` is never NULL:

```text
COUNT(*) = COUNT(follower_id)
```

for this problem.

---

# 🚀 Interview Insight

This problem is a simple aggregation question but tests a very common SQL pattern:

```sql
GROUP BY
+
COUNT()
```

Used for:

- followers count
- order count
- login count
- product count
- transaction count

---

# 🚀 Final Takeaway

This problem teaches:

- GROUP BY
- COUNT()
- ORDER BY

Core idea:

```text
Group rows by user
and count how many followers belong to each user
```