# 176. Second Highest Salary

## Problem Statement

Table: `Employee`

| Column Name | Type |
|------------|------|
| id | int |
| salary | int |

- `id` is the primary key.
- Each row contains an employee's salary.

Write a query to find the **second highest distinct salary**.

If there is no second highest salary, return **NULL**.

The output should be:

| SecondHighestSalary |

---

## Example 1

### Input

**Employee**

| id | salary |
|----|--------|
| 1 | 100 |
| 2 | 200 |
| 3 | 300 |

### Output

| SecondHighestSalary |
|---------------------|
| 200 |

---

## Example 2

### Input

**Employee**

| id | salary |
|----|--------|
| 1 | 100 |

### Output

| SecondHighestSalary |
|---------------------|
| NULL |

---

## Explanation

### Example 1

Distinct salaries:

```text
100
200
300
```

Sorted in descending order:

```text
300
200
100
```

The second highest salary is:

```text
200
```

---

### Example 2

Distinct salaries:

```text
100
```

There is no second highest salary.

Return:

```text
NULL
```

---

## Approach (Most Optimal)

We need the **second highest distinct salary**, not the second row.

Steps:

1. Remove duplicate salaries using `DISTINCT`.
2. Sort salaries in descending order.
3. Skip the highest salary using `OFFSET`.
4. Return the next salary.
5. If no such salary exists, return `NULL`.

---

## Why this works

Consider salaries:

```text
100
200
300
300
```

After `DISTINCT`:

```text
100
200
300
```

Descending order:

```text
300
200
100
```

Skip the first salary:

```text
300
```

Return:

```text
200
```

If only one distinct salary exists, the subquery returns no rows, and `IFNULL()` converts it to `NULL`.

---

## Optimal MySQL Solution

```sql
SELECT
    (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        LIMIT 1 OFFSET 1
    ) AS SecondHighestSalary;
```

---

## Dry Run

Input:

| salary |
|--------|
| 100 |
| 200 |
| 300 |
| 300 |

After `DISTINCT`:

```text
100
200
300
```

Sorted:

```text
300
200
100
```

Apply:

```sql
LIMIT 1 OFFSET 1
```

Skip:

```text
300
```

Return:

```text
200
```

---

### Case 2

Input:

| salary |
|--------|
| 100 |

After `DISTINCT`:

```text
100
```

Offset 1:

```text
No row
```

Output:

```text
NULL
```

---

## Complexity Analysis

### Time Complexity

```text
O(n log n)
```

- `DISTINCT` removes duplicates.
- Sorting salaries requires `ORDER BY`.

### Space Complexity

```text
O(n)
```

Used to store distinct salary values during sorting.

---

## Key SQL Concepts Used

- `DISTINCT`
- `ORDER BY`
- `LIMIT`
- `OFFSET`
- Scalar Subquery

---

## Alternative Solution (Using `MAX()`)

A common interview-friendly solution:

```sql
SELECT
    MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (
    SELECT MAX(salary)
    FROM Employee
);
```

### Why it works

1. Find the highest salary.
2. Ignore it.
3. Find the maximum among the remaining salaries.

If no salary exists below the maximum, `MAX()` automatically returns `NULL`.

---

## Alternative Solution (Using `DENSE_RANK()`)

For MySQL 8+:

```sql
WITH ranked AS (
    SELECT
        salary,
        DENSE_RANK() OVER (
            ORDER BY salary DESC
        ) AS salary_rank
    FROM Employee
)
SELECT
    MAX(salary) AS SecondHighestSalary
FROM ranked
WHERE salary_rank = 2;
```

---

## Interview Follow-up

### Why use `DISTINCT`?

Consider:

| Salary |
|--------|
| 300 |
| 300 |
| 200 |
| 100 |

Without `DISTINCT`:

```text
300
300
200
100
```

Using:

```sql
LIMIT 1 OFFSET 1
```

returns:

```text
300
```

which is incorrect.

After `DISTINCT`:

```text
300
200
100
```

Now the second highest salary is correctly:

```text
200
```

Using `DISTINCT` ensures the ranking is based on **unique salary values**, which is exactly what the problem requires.