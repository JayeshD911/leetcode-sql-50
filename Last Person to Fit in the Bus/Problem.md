# 1204. Last Person to Fit in the Bus

## Problem Statement

Table: `Queue`

| Column Name | Type |
|------------|------|
| person_id | int |
| person_name | varchar |
| weight | int |
| turn | int |

- `person_id` is unique.
- `turn` contains values from `1` to `n`.
- People board the bus in increasing order of `turn`.

A bus has a **maximum weight limit of 1000 kg**.

Find the **name of the last person that can board the bus without exceeding the weight limit**.

Return the result table with one column:

| person_name |

---

## Example

### Input

**Queue**

| person_id | person_name | weight | turn |
|-----------|-------------|--------|------|
| 5 | Alice | 250 | 1 |
| 4 | Bob | 175 | 5 |
| 3 | Alex | 350 | 2 |
| 6 | John Cena | 400 | 3 |
| 1 | Winston | 500 | 6 |
| 2 | Marie | 200 | 4 |

---

### Boarding Order (sorted by turn)

| Turn | Person | Weight |
|------|--------|--------|
| 1 | Alice | 250 |
| 2 | Alex | 350 |
| 3 | John Cena | 400 |
| 4 | Marie | 200 |
| 5 | Bob | 175 |
| 6 | Winston | 500 |

---

## Explanation

Track cumulative weight while boarding:

### Turn 1 — Alice

```text
250
```

≤ 1000 ✅ Boards

---

### Turn 2 — Alex

```text
250 + 350 = 600
```

≤ 1000 ✅ Boards

---

### Turn 3 — John Cena

```text
600 + 400 = 1000
```

≤ 1000 ✅ Boards

---

### Turn 4 — Marie

```text
1000 + 200 = 1200
```

> 1000 ❌ Cannot board

Since Marie exceeds the limit, boarding stops.

The last person who successfully boarded is:

```text
John Cena
```

---

## Approach (Most Optimal)

We need a **running total (prefix sum)** of weights ordered by `turn`.

For each person:

```text
current_weight = sum of all previous weights + current weight
```

If cumulative weight is:

```text
<= 1000
```

they can board.

The answer is the person with the **highest turn among valid rows**.

---

## Why this works

The boarding order matters.

Even if a lighter person comes later, they cannot skip the queue.

So we must:

1. Sort by `turn`
2. Compute cumulative weight
3. Keep rows where cumulative weight ≤ 1000
4. Return the latest valid person

---

## Optimal MySQL Solution (MySQL 8+)

```sql
WITH cumulative AS (
    SELECT
        person_name,
        turn,
        SUM(weight) OVER (
            ORDER BY turn
        ) AS total_weight
    FROM Queue
)
SELECT person_name
FROM cumulative
WHERE total_weight <= 1000
ORDER BY turn DESC
LIMIT 1;
```

---

## Dry Run

After cumulative sum:

| person_name | turn | total_weight |
|-------------|------|--------------|
| Alice | 1 | 250 |
| Alex | 2 | 600 |
| John Cena | 3 | 1000 |
| Marie | 4 | 1200 |
| Bob | 5 | 1375 |
| Winston | 6 | 1875 |

Filter:

```sql
total_weight <= 1000
```

Remaining rows:

| person_name | turn |
|-------------|------|
| Alice | 1 |
| Alex | 2 |
| John Cena | 3 |

Largest turn:

```text
3
```

Answer:

```text
John Cena
```

---

## Complexity Analysis

### Time Complexity

```text
O(n log n)
```

Due to sorting by `turn` for window function.

### Space Complexity

```text
O(n)
```

Window computation stores cumulative rows.

---

## Key SQL Concepts Used

- Window Functions
- `SUM() OVER`
- Running Total / Prefix Sum
- CTE (`WITH`)
- Ordering + Filtering

---

## Alternative Solution (Without Window Functions)

For older MySQL versions:

```sql
SELECT q1.person_name
FROM Queue q1
WHERE (
    SELECT SUM(q2.weight)
    FROM Queue q2
    WHERE q2.turn <= q1.turn
) <= 1000
ORDER BY q1.turn DESC
LIMIT 1;
```

This uses a correlated subquery to compute running totals.

---

## Interview Follow-up

Why not simply use:

```sql
SUM(weight)
```

without ordering?

Because total weight alone doesn’t matter.

Example:

```text
Turn 1: 900
Turn 2: 50
Turn 3: 100
```

Total:

```text
1050
```

The bus exceeds capacity at Turn 3, so answer is **Turn 2**, not based on overall sum.

That’s why **running cumulative sum in order** is essential.