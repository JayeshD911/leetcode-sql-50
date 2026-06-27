# 626. Exchange Seats

## Problem Statement

Table: `Seat`

| Column Name | Type |
|------------|------|
| id | int |
| student | varchar |

- `id` is a continuous incrementing integer starting from `1`.
- Each row represents a student sitting in a seat.

Swap the seat IDs of every **two consecutive students**.

Rules:

- Swap seat `1` with seat `2`
- Swap seat `3` with seat `4`
- Swap seat `5` with seat `6`
- ...
- If the number of students is **odd**, the last student remains unchanged.

Return the result table ordered by `id`.

---

## Example

### Input

**Seat**

| id | student |
|----|---------|
| 1 | Abbot |
| 2 | Doris |
| 3 | Emerson |
| 4 | Green |
| 5 | Jeames |

---

### Output

| id | student |
|----|---------|
| 1 | Doris |
| 2 | Abbot |
| 3 | Green |
| 4 | Emerson |
| 5 | Jeames |

---

## Explanation

We swap students in pairs.

Original order:

```text
1 → Abbot
2 → Doris
3 → Emerson
4 → Green
5 → Jeames
```

Swap:

### Pair 1

```text
1 ↔ 2
```

Result:

```text
1 → Doris
2 → Abbot
```

---

### Pair 2

```text
3 ↔ 4
```

Result:

```text
3 → Green
4 → Emerson
```

---

### Last Student

Seat 5 has no partner.

So:

```text
5 → Jeames
```

remains unchanged.

---

## Approach (Most Optimal)

Instead of physically swapping rows, we compute a **new seat ID** using `CASE`.

Rules:

### Odd ID

Normally swap with next seat:

```sql
id + 1
```

Example:

```text
1 → 2
3 → 4
```

---

### Even ID

Swap with previous seat:

```sql
id - 1
```

Example:

```text
2 → 1
4 → 3
```

---

### Special Case: Last Odd Seat

If total number of students is odd, the last seat should remain unchanged.

Example:

```text
5 stays 5
```

---

## Why this works

Each row independently determines its swapped position:

- Odd → move right
- Even → move left
- Last odd seat → unchanged

After calculating new IDs, sort by them.

---

## Optimal MySQL Solution

```sql
SELECT
    CASE
        WHEN id % 2 = 1 AND id != (SELECT COUNT(*) FROM Seat)
            THEN id + 1
        WHEN id % 2 = 0
            THEN id - 1
        ELSE id
    END AS id,
    student
FROM Seat
ORDER BY id;
```

---

## Dry Run

Input:

| id | student |
|----|---------|
| 1 | Abbot |
| 2 | Doris |
| 3 | Emerson |
| 4 | Green |
| 5 | Jeames |

Total rows:

```text
5
```

Transform IDs:

| Original ID | New ID |
|-------------|--------|
| 1 | 2 |
| 2 | 1 |
| 3 | 4 |
| 4 | 3 |
| 5 | 5 |

Sort by new ID:

| id | student |
|----|---------|
| 1 | Doris |
| 2 | Abbot |
| 3 | Green |
| 4 | Emerson |
| 5 | Jeames |

---

## Complexity Analysis

### Time Complexity

```text
O(n)
```

Each row is processed once.

### Space Complexity

```text
O(1)
```

No additional storage required.

---

## Key SQL Concepts Used

- `CASE`
- Modulus Operator (`%`)
- Conditional Transformation
- Ordering
- Scalar Subquery (`COUNT(*)`)

---

## Alternative Solution

Another elegant trick:

```sql
SELECT
    IF(
        id = (SELECT MAX(id) FROM Seat) AND id % 2 = 1,
        id,
        IF(id % 2 = 1, id + 1, id - 1)
    ) AS id,
    student
FROM Seat
ORDER BY id;
```

Same logic using nested `IF`.

---

## Interview Follow-up

Common mistake:

Using only:

```sql
IF(id % 2 = 1, id + 1, id - 1)
```

Problem:

If total seats are odd:

```text
Seat 5 → Seat 6
```

But seat 6 does not exist.

That’s why we must explicitly handle:

```sql
last odd seat remains unchanged
```