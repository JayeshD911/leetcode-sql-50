# Game Play Analysis IV

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

# 📘 Problem Statement

Write an SQL query to report the fraction of players that:

```text
logged in again on the day after
their first login
```

Rounded to:
```text
2 decimal places
```

---

# 🧠 Intuition

For every player:
1. find their first login date
2. check whether they logged in again:
   ```text
   first_login + 1 day
   ```
3. count such players
4. divide by total players

---

# 🔍 Table

## `Activity`

| Column Name | Type |
|-------------|------|
| player_id   | int |
| device_id   | int |
| event_date  | date |
| games_played| int |

---

# 🧩 Key Observation

We need:

```text
Players who returned exactly one day
after their first login
```

👉 This is a classic:

```text
First Row Per Group + Date Comparison
```

problem.

---

# ✅ SQL Query

```sql
SELECT 
    ROUND(
        COUNT(DISTINCT a.player_id) /
        (SELECT COUNT(DISTINCT player_id) FROM Activity),
        2
    ) AS fraction
FROM Activity a
JOIN (
    SELECT 
        player_id,
        MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
) f
ON a.player_id = f.player_id
AND DATEDIFF(a.event_date, f.first_login) = 1;
```

---------------------

# 🔍 Step-by-Step Explanation

---

# 1️⃣ Find First Login Date of Every Player

```sql
SELECT 
    player_id,
    MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id
```

This gives:

| player_id | first_login |
|------------|-------------|
| 1 | 2016-03-01 |
| 2 | 2017-06-25 |
| 3 | 2016-03-02 |

---

# 2️⃣ Join Back with Activity Table

```sql
JOIN Activity a
ON a.player_id = f.player_id
```

Now we can compare:
```text
other login dates vs first login date
```

---

# 3️⃣ Check Next-Day Login

```sql
DATEDIFF(a.event_date, f.first_login) = 1
```

This means:

```text
event_date = first_login + 1 day
```

---

## 🧪 Example

### Activity Table

| player_id | event_date |
|------------|------------|
| 1 | 2016-03-01 |
| 1 | 2016-03-02 |
| 2 | 2017-06-25 |
| 3 | 2016-03-01 |
| 3 | 2016-03-03 |

---

## First Login Dates

| player_id | first_login |
|------------|-------------|
| 1 | 2016-03-01 |
| 2 | 2017-06-25 |
| 3 | 2016-03-01 |

---

## Check Next-Day Login

### Player 1

```text
2016-03-02 - 2016-03-01 = 1 ✅
```

Returned next day.

---

### Player 2

No next-day login ❌

---

### Player 3

```text
2016-03-03 - 2016-03-01 = 2 ❌
```

Not counted.

---

# 4️⃣ Count Qualified Players

```sql
COUNT(DISTINCT a.player_id)
```

Counts players who returned next day.

Example:
```text
1
```

---

# 5️⃣ Count Total Players

```sql
SELECT COUNT(DISTINCT player_id)
FROM Activity
```

Example:
```text
3
```

---

# 6️⃣ Compute Fraction

```text
1 / 3 = 0.33
```

Rounded to:
```text
0.33
```

---

# ✅ Final Output

| fraction |
|----------|
| 0.33 |

---

# ⏱️ Complexity Analysis

## Time Complexity

```text
O(n)
```

With indexing.

Without indexes:
```text
O(n log n)
```

due to grouping.

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
GROUP BY player_id
```

Processes rows player-wise.

---

# 2️⃣ MIN()

```sql
MIN(event_date)
```

Finds first login date.

---

# 3️⃣ Self-Derived Join

Join aggregated results back to original table.

Very common SQL pattern.

---

# 4️⃣ DATEDIFF()

```sql
DATEDIFF(date1, date2)
```

Returns difference in days.

---

# 5️⃣ COUNT(DISTINCT)

```sql
COUNT(DISTINCT column)
```

Counts unique values.

---

# ⚠️ Important SQL Insight

Why use:

```sql
COUNT(DISTINCT a.player_id)
```

instead of:
```sql
COUNT(*)
```

Because:
- a player may have multiple qualifying rows
- we only want unique players

---

# 🚀 Alternative Solution (Using EXISTS)

```sql
SELECT 
    ROUND(
        COUNT(DISTINCT a1.player_id) /
        (SELECT COUNT(DISTINCT player_id) FROM Activity),
        2
    ) AS fraction
FROM Activity a1
WHERE EXISTS (
    SELECT 1
    FROM Activity a2
    WHERE a1.player_id = a2.player_id
    AND a2.event_date = DATE_ADD(a1.event_date, INTERVAL 1 DAY)
)
AND (a1.player_id, a1.event_date) IN (
    SELECT player_id, MIN(event_date)
    FROM Activity
    GROUP BY player_id
);
```

---

# 🚀 Interview Insight

This problem teaches an extremely common analytics pattern:

```text
Retention Analysis
```

Used heavily in:
- gaming analytics
- user engagement tracking
- SaaS dashboards

---

# 🚀 Final Takeaway

This problem combines:
- grouping
- date calculations
- joins
- distinct counting

Core idea:

```text
Find first event per user
then check future activity
```