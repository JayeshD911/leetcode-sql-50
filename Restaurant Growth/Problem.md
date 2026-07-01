# 1321. Restaurant Growth

## Problem Statement

Table: `Customer`

| Column Name | Type |
|------------|------|
| visited_on | date |
| amount | int |

- `(visited_on, amount)` is **not unique**.
- The table may contain multiple customer payments for the same date.
- Each row represents how much one customer spent on a particular day.

You need to compute the **7-day moving revenue** and the **7-day average revenue**.

For each day starting from the 7th day:

- `amount` = total revenue of the current day + previous 6 days
- `average_amount` = 7-day average revenue, rounded to 2 decimal places

Return the result ordered by `visited_on`.

---

## Example

### Input

**Customer**

| visited_on | amount |
|------------|--------|
| 2019-01-01 | 100 |
| 2019-01-02 | 110 |
| 2019-01-03 | 120 |
| 2019-01-04 | 130 |
| 2019-01-05 | 110 |
| 2019-01-06 | 140 |
| 2019-01-07 | 150 |
| 2019-01-08 | 80 |
| 2019-01-09 | 110 |
| 2019-01-10 | 130 |

---

### Output

| visited_on | amount | average_amount |
|------------|--------|----------------|
| 2019-01-07 | 860 | 122.86 |
| 2019-01-08 | 840 | 120.00 |
| 2019-01-09 | 840 | 120.00 |
| 2019-01-10 | 850 | 121.43 |

---

## Explanation

We first aggregate daily revenue.

Example first 7 days:

| Date | Revenue |
|------|---------|
| Jan 1 | 100 |
| Jan 2 | 110 |
| Jan 3 | 120 |
| Jan 4 | 130 |
| Jan 5 | 110 |
| Jan 6 | 140 |
| Jan 7 | 150 |

7-day total:

```text
100 + 110 + 120 + 130 + 110 + 140 + 150 = 860
```

Average:

```text
860 / 7 = 122.857...
```

Rounded:

```text
122.86
```

---

## Approach (Most Optimal)

There are two steps:

### Step 1 — Aggregate daily revenue

Since multiple rows may exist for the same date:

```sql
GROUP BY visited_on
```

to get total daily revenue.

---

### Step 2 — Compute 7-day moving window

For each date:

- Include current day
- Include previous 6 days

Compute:

- Rolling sum
- Rolling average

Window functions make this very efficient.

---

## Why this works

A **sliding window** of 7 rows allows us to compute:

```text
sum(last 7 days)
```

Instead of recalculating from scratch each time.

Window frame:

```sql
ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
```

means:

- Current row
- Previous 6 rows

Exactly 7 days.

---

## Optimal MySQL Solution (MySQL 8+)

```sql
WITH daily_sales AS (
    SELECT
        visited_on,
        SUM(amount) AS daily_amount
    FROM Customer
    GROUP BY visited_on
),
rolling AS (
    SELECT
        visited_on,
        SUM(daily_amount) OVER (
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS amount,
        ROUND(
            AVG(daily_amount) OVER (
                ORDER BY visited_on
                ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
            ),
            2
        ) AS average_amount,
        ROW_NUMBER() OVER (ORDER BY visited_on) AS rn
    FROM daily_sales
)
SELECT
    visited_on,
    amount,
    average_amount
FROM rolling
WHERE rn >= 7
ORDER BY visited_on;
```

---

## Dry Run

Daily revenue:

| Day | Revenue |
|-----|---------|
| 1 | 100 |
| 2 | 110 |
| 3 | 120 |
| 4 | 130 |
| 5 | 110 |
| 6 | 140 |
| 7 | 150 |

Window at Day 7:

Sum:

```text
860
```

Average:

```text
860 / 7 = 122.86
```

At Day 8:

Window:

```text
110 + 120 + 130 + 110 + 140 + 150 + 80
```

Sum:

```text
840
```

Average:

```text
120.00
```

---

## Complexity Analysis

### Time Complexity

```text
O(n log n)
```

Due to sorting for window functions.

### Space Complexity

```text
O(n)
```

For aggregated and windowed rows.

---

## Key SQL Concepts Used

- `GROUP BY`
- Window Functions
- `SUM() OVER`
- `AVG() OVER`
- Rolling Window
- CTEs

---

## Alternative Solution (Without Window Functions)

Older MySQL approach using self-join:

```sql
SELECT
    c1.visited_on,
    SUM(c2.amount) AS amount,
    ROUND(SUM(c2.amount) / 7, 2) AS average_amount
FROM
(
    SELECT visited_on, SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on
) c1
JOIN
(
    SELECT visited_on, SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on
) c2
ON c2.visited_on BETWEEN DATE_SUB(c1.visited_on, INTERVAL 6 DAY)
                    AND c1.visited_on
GROUP BY c1.visited_on
HAVING COUNT(*) = 7
ORDER BY c1.visited_on;
```

---

## Interview Follow-up

Common mistake:

Applying window function directly on `Customer`.

Problem:

There may be multiple rows for the same day.

Example:

```text
2019-01-01 → 50
2019-01-01 → 70
```

If not aggregated first, window calculations become incorrect.

That’s why Step 1 is essential:

```sql
GROUP BY visited_on
```

before applying the rolling window.