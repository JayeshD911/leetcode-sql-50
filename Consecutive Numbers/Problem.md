# 180. Consecutive Numbers

## Problem Statement

Table: `Logs`

| Column Name | Type |
|------------|------|
| id | int |
| num | varchar |

`id` is the primary key and increments sequentially.

Find all numbers that appear **at least three times consecutively**.

Return the result table in any order.

---

## Example

### Input

**Logs**

| id | num |
|----|-----|
| 1 | 1 |
| 2 | 1 |
| 3 | 1 |
| 4 | 2 |
| 5 | 1 |
| 6 | 2 |
| 7 | 2 |

### Output

| ConsecutiveNums |
|-----------------|
| 1 |

---

## Explanation

We need numbers that occur **3 or more times in consecutive rows**.

Looking at the table:

```text
ID   NUM
1    1
2    1
3    1   ← Three consecutive 1s
4    2
5    1
6    2
7    2
```

- Number `1` appears at IDs `1, 2, 3` consecutively ✅
- Number `2` appears only twice consecutively (`6, 7`) ❌

So the answer is:

```text
1
```

---

## Approach 1 (Most Optimal) — Self Join

Since IDs are consecutive, we can compare:

- current row
- next row (`id + 1`)
- next-next row (`id + 2`)

If all three rows have the same number, that number qualifies.

---

## Why this works

For a number to appear three times consecutively:

```sql
row1.num = row2.num = row3.num
```

and rows must be adjacent:

```sql
row1.id + 1 = row2.id
row2.id + 1 = row3.id
```

A self join helps compare neighboring rows efficiently.

---

## Optimal MySQL Solution

```sql
SELECT DISTINCT l1.num AS ConsecutiveNums
FROM Logs l1
JOIN Logs l2
    ON l1.id + 1 = l2.id
JOIN Logs l3
    ON l2.id + 1 = l3.id
WHERE l1.num = l2.num
  AND l2.num = l3.num;
```

---

## Dry Run

Input:

| id | num |
|----|-----|
| 1 | 1 |
| 2 | 1 |
| 3 | 1 |

Join results:

- `l1 = id 1`
- `l2 = id 2`
- `l3 = id 3`

Check:

```sql
1 = 1 = 1
```

True → Output `1`

---

## Complexity Analysis

### Time Complexity

```text
O(n)
```

Each row participates in constant-time joins (assuming indexed `id`).

### Space Complexity

```text
O(1)
```

No additional storage needed.

---

## Key SQL Concepts Used

- Self Join
- Multiple Table Aliases
- `DISTINCT`
- Consecutive Row Matching

---

## Alternative Solution (Using Window Functions)

If MySQL 8+ is allowed, `LAG()` is cleaner:

```sql
SELECT DISTINCT num AS ConsecutiveNums
FROM (
    SELECT
        num,
        LAG(num, 1) OVER (ORDER BY id) AS prev1,
        LAG(num, 2) OVER (ORDER BY id) AS prev2
    FROM Logs
) t
WHERE num = prev1
  AND num = prev2;
```

---

## Interview Follow-up

Why use `DISTINCT`?

Example:

If a number appears 4 or 5 times consecutively:

```text
1 1 1 1
```

The self join may detect it multiple times:

- rows 1,2,3
- rows 2,3,4

Without `DISTINCT`, duplicates appear in output.

So `DISTINCT` ensures each number appears only once.