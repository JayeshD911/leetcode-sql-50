# 610. Triangle Judgement

## Problem Statement

Table: `Triangle`

| Column Name | Type |
|------------|------|
| x | int |
| y | int |
| z | int |

Each row of this table contains the lengths of three line segments.

For each row, determine whether the three segments can form a valid triangle.

Return the result table in any order.

---

## Triangle Rule

Three sides can form a triangle **if and only if**:

- `x + y > z`
- `x + z > y`
- `y + z > x`

If all three conditions are true, return **"Yes"**, otherwise return **"No"**.

---

## Example

### Input

**Triangle**

| x | y | z |
|---|---|---|
| 13 | 15 | 30 |
| 10 | 20 | 15 |

### Output

| x | y | z | triangle |
|---|---|---|----------|
| 13 | 15 | 30 | No |
| 10 | 20 | 15 | Yes |

---

## Explanation

### Row 1

Sides = `(13, 15, 30)`

Check:

- 13 + 15 = 28 ≤ 30 ❌

Since one condition fails, these sides **cannot** form a triangle.

Result: **No**

---

### Row 2

Sides = `(10, 20, 15)`

Check:

- 10 + 20 = 30 > 15 ✅
- 10 + 15 = 25 > 20 ✅
- 20 + 15 = 35 > 10 ✅

All conditions are satisfied.

Result: **Yes**

---

## Approach

Use a `CASE` statement to verify the Triangle Inequality Theorem.

If all three inequalities hold:

```sql
x + y > z
AND x + z > y
AND y + z > x
```

then return `"Yes"`.

Otherwise return `"No"`.

### Why this works

A triangle can only exist when the sum of any two sides is strictly greater than the third side.

If even one condition fails, the three segments cannot enclose an area, meaning no valid triangle can be formed.

---

## Optimal MySQL Solution

```sql
SELECT
    x,
    y,
    z,
    CASE
        WHEN x + y > z
         AND x + z > y
         AND y + z > x
        THEN 'Yes'
        ELSE 'No'
    END AS triangle
FROM Triangle;
```

---

## Complexity Analysis

### Time Complexity

```text
O(n)
```

We process each row exactly once.

### Space Complexity

```text
O(1)
```

No extra space is used apart from the output.

---

## Key SQL Concepts Used

- `CASE WHEN`
- Conditional Logic
- Triangle Inequality Theorem
- Row-wise Evaluation

---

## Interview Follow-up

A common optimization observation:

Instead of checking all three conditions, we can use:

```sql
x + y + z - MAX(x, y, z) > MAX(x, y, z)
```

because a triangle exists if the sum of the two smaller sides is greater than the largest side.

However, MySQL's straightforward three-condition solution is clearer, easier to understand, and is the preferred interview answer.