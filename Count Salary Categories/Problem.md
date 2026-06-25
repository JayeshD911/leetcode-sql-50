# 1907. Count Salary Categories

## Problem Statement

Table: `Accounts`

| Column Name | Type |
|------------|------|
| account_id | int |
| income | int |

`account_id` is unique.

Write a query to count how many accounts belong to each salary category:

- **Low Salary** → income **< 20000**
- **Average Salary** → income **between 20000 and 50000 inclusive**
- **High Salary** → income **> 50000**

Return the result table with:

| category | accounts_count |

The output **must always contain all three categories**, even if one or more categories have zero accounts.

Return the result table in any order.

---

## Example

### Input

**Accounts**

| account_id | income |
|------------|--------|
| 3 | 108939 |
| 2 | 12747 |
| 8 | 87709 |
| 6 | 91796 |

---

### Output

| category | accounts_count |
|----------|----------------|
| Low Salary | 1 |
| Average Salary | 0 |
| High Salary | 3 |

---

## Explanation

Categorize each account:

### Account 3

```text
108939 > 50000
```

→ High Salary

### Account 2

```text
12747 < 20000
```

→ Low Salary

### Account 8

```text
87709 > 50000
```

→ High Salary

### Account 6

```text
91796 > 50000
```

→ High Salary

Final counts:

- Low Salary → 1
- Average Salary → 0
- High Salary → 3

---

## Approach (Most Optimal)

The challenge is not just counting categories.

We must also ensure:

```text
All 3 categories appear in output
```

Even if a category count is zero.

A clean way:

1. Create the three categories manually using `UNION`
2. Count matching accounts with conditional logic

---

## Why this works

Using conditional aggregation:

```sql
SUM(condition)
```

MySQL treats:

- `TRUE` as `1`
- `FALSE` as `0`

So:

```sql
SUM(income < 20000)
```

counts low-salary accounts.

Similarly for other ranges.

To ensure missing categories still appear, we explicitly generate all category rows.

---

## Optimal MySQL Solution

```sql
SELECT 'Low Salary' AS category,
       SUM(income < 20000) AS accounts_count
FROM Accounts

UNION

SELECT 'Average Salary',
       SUM(income BETWEEN 20000 AND 50000)
FROM Accounts

UNION

SELECT 'High Salary',
       SUM(income > 50000)
FROM Accounts;
```

---

## Dry Run

Input:

| account_id | income |
|------------|--------|
| 3 | 108939 |
| 2 | 12747 |
| 8 | 87709 |
| 6 | 91796 |

### Query 1

```sql
SUM(income < 20000)
```

Only `12747` qualifies.

Result:

```text
1
```

---

### Query 2

```sql
SUM(income BETWEEN 20000 AND 50000)
```

No rows qualify.

Result:

```text
0
```

---

### Query 3

```sql
SUM(income > 50000)
```

Three rows qualify.

Result:

```text
3
```

---

## Complexity Analysis

### Time Complexity

```text
O(n)
```

Each union branch scans the table once.

(Still linear overall because there are only 3 fixed branches.)

### Space Complexity

```text
O(1)
```

Only three output rows.

---

## Key SQL Concepts Used

- Conditional Aggregation
- `SUM(boolean_expression)`
- `UNION`
- Range Checks using `BETWEEN`

---

## Alternative Solution (Using CASE)

Another readable approach:

```sql
WITH categories AS (
    SELECT 'Low Salary' AS category
    UNION
    SELECT 'Average Salary'
    UNION
    SELECT 'High Salary'
)
SELECT
    c.category,
    CASE
        WHEN c.category = 'Low Salary'
            THEN (SELECT COUNT(*) FROM Accounts WHERE income < 20000)
        WHEN c.category = 'Average Salary'
            THEN (SELECT COUNT(*) FROM Accounts
                  WHERE income BETWEEN 20000 AND 50000)
        ELSE
            (SELECT COUNT(*) FROM Accounts WHERE income > 50000)
    END AS accounts_count
FROM categories c;
```

---

## Interview Follow-up

Common mistake:

Using:

```sql
GROUP BY category
```

after assigning categories.

Problem:

If no rows belong to a category, that category disappears.

Example:

```text
No Average Salary accounts
```

Then output becomes only:

- Low Salary
- High Salary

Which fails the problem.

That’s why explicitly generating all 3 categories is important.