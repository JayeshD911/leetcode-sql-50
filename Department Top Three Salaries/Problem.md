# 185. Department Top Three Salaries

## Problem Statement

Table: `Employee`

| Column Name | Type |
|------------|------|
| id | int |
| name | varchar |
| salary | int |
| departmentId | int |

- `id` is the primary key.
- `departmentId` is a foreign key referencing `Department.id`.
- Each row represents an employee.

---

Table: `Department`

| Column Name | Type |
|------------|------|
| id | int |
| name | varchar |

- `id` is the primary key.
- Each row represents a department.

---

## Task

Find the employees who have one of the **top three unique salaries** in each department.

Return the result table with:

| Department | Employee | Salary |

Return the result in any order.

> **Note:** If multiple employees have the same salary, they should all be included if that salary is among the top three **distinct** salaries in their department.

---

## Example

### Input

### Employee

| id | name | salary | departmentId |
|----|------|--------|--------------|
| 1 | Joe | 85000 | 1 |
| 2 | Henry | 80000 | 2 |
| 3 | Sam | 60000 | 2 |
| 4 | Max | 90000 | 1 |
| 5 | Janet | 69000 | 1 |
| 6 | Randy | 85000 | 1 |
| 7 | Will | 70000 | 1 |

### Department

| id | name |
|----|------|
| 1 | IT |
| 2 | Sales |

---

### Output

| Department | Employee | Salary |
|------------|----------|--------|
| IT | Max | 90000 |
| IT | Joe | 85000 |
| IT | Randy | 85000 |
| IT | Will | 70000 |
| Sales | Henry | 80000 |
| Sales | Sam | 60000 |

---

## Explanation

### IT Department

Employee salaries:

| Employee | Salary |
|----------|-------:|
| Max | 90000 |
| Joe | 85000 |
| Randy | 85000 |
| Will | 70000 |
| Janet | 69000 |

Distinct salaries:

```text
90000
85000
70000
69000
```

Top three distinct salaries:

```text
90000
85000
70000
```

Employees included:

- Max
- Joe
- Randy
- Will

Janet is excluded because **69000** is the fourth highest distinct salary.

---

### Sales Department

Distinct salaries:

```text
80000
60000
```

There are fewer than three distinct salaries, so both employees are included.

---

## Approach (Most Optimal)

The key observation is:

We need the **top three distinct salaries** within each department.

Using `DENSE_RANK()`:

- Employees with the same salary receive the same rank.
- Ranking restarts for every department.
- Keep only employees whose rank is **≤ 3**.

---

## Why `DENSE_RANK()`?

Consider salaries:

```text
90000
85000
85000
70000
69000
```

### `DENSE_RANK()`

| Salary | Rank |
|--------|-----:|
| 90000 | 1 |
| 85000 | 2 |
| 85000 | 2 |
| 70000 | 3 |
| 69000 | 4 |

Exactly what the problem requires.

Using `ROW_NUMBER()` would incorrectly assign different ranks to equal salaries.

---

## Optimal MySQL Solution (MySQL 8+)

```sql
WITH ranked AS (
    SELECT
        e.name AS Employee,
        e.salary AS Salary,
        d.name AS Department,
        DENSE_RANK() OVER (
            PARTITION BY e.departmentId
            ORDER BY e.salary DESC
        ) AS salary_rank
    FROM Employee e
    JOIN Department d
        ON e.departmentId = d.id
)
SELECT
    Department,
    Employee,
    Salary
FROM ranked
WHERE salary_rank <= 3;
```

---

## Dry Run

### IT Department

| Employee | Salary | Rank |
|----------|-------:|-----:|
| Max | 90000 | 1 |
| Joe | 85000 | 2 |
| Randy | 85000 | 2 |
| Will | 70000 | 3 |
| Janet | 69000 | 4 |

Keep:

```text
Rank ≤ 3
```

Result:

- Max
- Joe
- Randy
- Will

---

### Sales Department

| Employee | Salary | Rank |
|----------|-------:|-----:|
| Henry | 80000 | 1 |
| Sam | 60000 | 2 |

Both qualify.

---

## Complexity Analysis

### Time Complexity

```text
O(n log n)
```

- Sorting salaries within each department for ranking.

### Space Complexity

```text
O(n)
```

For storing ranked rows.

---

## Key SQL Concepts Used

- `JOIN`
- `DENSE_RANK()`
- `PARTITION BY`
- Window Functions
- CTE (`WITH`)

---

## Alternative Solution (Without Window Functions)

For MySQL 5.7 and earlier:

```sql
SELECT
    d.name AS Department,
    e1.name AS Employee,
    e1.salary AS Salary
FROM Employee e1
JOIN Department d
    ON e1.departmentId = d.id
WHERE (
    SELECT COUNT(DISTINCT e2.salary)
    FROM Employee e2
    WHERE e2.departmentId = e1.departmentId
      AND e2.salary > e1.salary
) < 3;
```

### Why it works

For each employee:

- Count how many **distinct salaries are greater** within the same department.
- If fewer than **3** salaries are greater, then the employee's salary is among the top three distinct salaries.

---

## Interview Follow-up

### Why not use `ROW_NUMBER()`?

Consider:

| Employee | Salary |
|----------|-------:|
| Max | 90000 |
| Joe | 85000 |
| Randy | 85000 |
| Will | 70000 |

Using `ROW_NUMBER()`:

| Salary | Row Number |
|--------|-----------:|
| 90000 | 1 |
| 85000 | 2 |
| 85000 | 3 |
| 70000 | 4 ❌ |

Will would incorrectly be excluded.

Using `DENSE_RANK()`:

| Salary | Rank |
|--------|-----:|
| 90000 | 1 |
| 85000 | 2 |
| 85000 | 2 |
| 70000 | 3 ✅ |

This is exactly what the problem requires because rankings are based on **distinct salaries**, not individual employees.