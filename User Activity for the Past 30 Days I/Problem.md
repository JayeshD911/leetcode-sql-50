# User Activity for the Past 30 Days I

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

# 📘 Problem Statement

Write an SQL query to find:

```text
the number of active users for each day
during the 30-day period ending on 2019-07-27
```

A user is considered active if they performed at least one activity on that day.

Return:

- `day`
- `active_users`

---

# 🧠 Intuition

We need to count:

```text
unique users active on each day
```

within the date range:

```text
2019-06-28 to 2019-07-27
```

Since a user can perform multiple activities on the same day, we must count:

```text
DISTINCT user_id
```

---

# 🔍 Table

## `Activity`

| Column Name | Type |
|-------------|------|
| user_id     | int |
| session_id  | int |
| activity_date | date |
| activity_type | enum |

---

## Example

| user_id | activity_date |
|----------|--------------|
| 1 | 2019-07-20 |
| 1 | 2019-07-20 |
| 2 | 2019-07-20 |
| 3 | 2019-07-21 |

For:

```text
2019-07-20
```

Active users are:

```text
1, 2
```

Count:

```text
2
```

Not 3, because user 1 appeared twice.

---

# 🧩 Key Observation

We need:

1. activities in the last 30 days
2. group by date
3. count unique users

👉 This is a classic:

```text
WHERE + GROUP BY + COUNT(DISTINCT)
```

problem.

---

# ✅ SQL Query

```sql
SELECT
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date;
```

---------------------

# 🔍 Step-by-Step Explanation

---

# 1️⃣ Filter Last 30 Days

```sql
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
```

Keeps only activities in the required window.

---

## Example

Suppose:

| activity_date |
|--------------|
| 2019-06-15 |
| 2019-07-10 |
| 2019-07-25 |

After filtering:

| activity_date |
|--------------|
| 2019-07-10 |
| 2019-07-25 |

The June 15 record is removed.

---

# 2️⃣ Group by Day

```sql
GROUP BY activity_date
```

Creates one group per date.

Example:

### 2019-07-20

```text
user 1
user 1
user 2
```

### 2019-07-21

```text
user 3
user 4
```

---

# 3️⃣ Count Unique Users

```sql
COUNT(DISTINCT user_id)
```

For:

### 2019-07-20

Users:

```text
1, 1, 2
```

Distinct users:

```text
1, 2
```

Count:

```text
2
```

---

### 2019-07-21

Users:

```text
3, 4
```

Count:

```text
2
```

---

# ✅ Final Output

| day | active_users |
|------|-------------|
| 2019-07-20 | 2 |
| 2019-07-21 | 2 |

---

# ⏱️ Complexity Analysis

## Time Complexity

```text
O(n)
```

Where:
- `n` = number of rows in Activity

---

## Space Complexity

```text
O(k)
```

Where:
- `k` = distinct users per day

(used internally by DISTINCT)

---

# 🎯 Important SQL Concepts Used

---

# 1️⃣ BETWEEN

```sql
WHERE date BETWEEN start_date AND end_date
```

Inclusive range filter.

Equivalent to:

```sql
WHERE date >= start_date
AND date <= end_date
```

---

# 2️⃣ GROUP BY

```sql
GROUP BY activity_date
```

Creates groups per day.

---

# 3️⃣ COUNT(DISTINCT)

```sql
COUNT(DISTINCT user_id)
```

Counts unique users only.

---

## Difference

### COUNT(user_id)

```text
1,1,2
```

Result:

```text
3
```

---

### COUNT(DISTINCT user_id)

```text
1,2
```

Result:

```text
2
```

---

# ⚠️ Common Mistake

Wrong:

```sql
SELECT
    activity_date,
    COUNT(user_id)
FROM Activity
GROUP BY activity_date;
```

This counts activities, not users.

The question asks for:

```text
active users
```

So we must use:

```sql
COUNT(DISTINCT user_id)
```

---

# 🚀 Interview Insight

This is one of the most common analytics SQL patterns.

Pattern:

```sql
GROUP BY date
COUNT(DISTINCT user_id)
```

Used in:

- Daily Active Users (DAU)
- Monthly Active Users (MAU)
- User engagement dashboards
- Product analytics

---

# 🚀 Final Takeaway

This problem teaches:

- date filtering
- grouping by date
- counting unique users

Core idea:

```text
Filter the required date range
then count distinct users per day
```