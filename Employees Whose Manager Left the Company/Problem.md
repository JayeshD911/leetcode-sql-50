# 1978. Employees Whose Manager Left the Company

## Problem Statement

Table: `Employees`

| Column Name | Type |
|------------|------|
| employee_id | int |
| name | varchar |
| manager_id | int |
| salary | int |

- `employee_id` is unique.
- `manager_id` references another employee’s `employee_id`.
- If `manager_id` is `NULL`, the employee has no manager.

Find employees who satisfy **both** conditions:

1. Their salary is **strictly less than 30000**
2. Their manager **left the company**

A manager is considered to have left if their `manager_id` does **not exist as an `employee_id`** in the table.

Return the result table containing:

| employee_id |

ordered by `employee_id`.

---

## Example

### Input

**Employees**

| employee_id | name | manager_id | salary |
|-------------|------|------------|--------|
| 3 | Mila | 9 | 60301 |
| 12 | Antonella | NULL | 31000 |
| 13 | Emery | NULL | 67084 |
| 1 | Kalel | 11 | 21241 |
| 9 | Mikaela | NULL | 50937 |
| 11 | Joziah | 6 | 28485 |

---

### Output

| employee_id |
|-------------|
| 11 |

---

## Explanation

We need employees with:

```text
salary < 30000
AND manager no longer exists
```

---

### Employee 3

- Salary = 60301 ❌ (too high)

Ignore.

---

### Employee 12

- Salary = 31000 ❌

Ignore.

---

### Employee 13

- Salary = 67084 ❌

Ignore.

---

### Employee 1

- Salary = 21241 ✅
- Manager = 11
- Employee 11 exists in company ✅

Manager has **not** left.

Ignore.

---

### Employee 9

- Salary = 50937 ❌

Ignore.

---

### Employee 11

- Salary = 28485 ✅
- Manager = 6
- Employee 6 does **not exist** ❌

Manager left company ✅

Include:

```text
11
```

---

## Approach (Most Optimal)

We need to identify employees whose:

1. Salary is below 30000
2. `manager_id` does not appear in employee list

We can do this using:

```sql
manager_id NOT IN (
    SELECT employee_id FROM Employees
)
```

Then sort by employee ID.

---

## Why this works

Every valid manager should appear as an employee.

If:

```sql
manager_id NOT IN employee_ids
```

that means the manager record is missing.

Combined with:

```sql
salary < 30000
```

we get the required employees.

---

## Optimal MySQL Solution

```sql
SELECT employee_id
FROM Employees
WHERE salary < 30000
  AND manager_id IS NOT NULL
  AND manager_id NOT IN (
      SELECT employee_id
      FROM Employees
  )
ORDER BY employee_id;
```

---

## Dry Run

Employee IDs in company:

```text
{1, 3, 9, 11, 12, 13}
```

Check low salary employees:

### Employee 1

```text
manager_id = 11
```

11 exists → Exclude

---

### Employee 11

```text
manager_id = 6
```

6 missing → Include

Final output:

| employee_id |
|-------------|
| 11 |

---

## Complexity Analysis

### Time Complexity

```text
O(n)
```

With proper indexing on `employee_id`, lookup is efficient.

### Space Complexity

```text
O(1)
```

Ignoring query engine internals.

---

## Key SQL Concepts Used

- Subqueries
- `NOT IN`
- Filtering with `WHERE`
- Handling `NULL`
- Sorting with `ORDER BY`

---

## Alternative Solution (Using LEFT JOIN)

A self-join version:

```sql
SELECT e.employee_id
FROM Employees e
LEFT JOIN Employees m
    ON e.manager_id = m.employee_id
WHERE e.salary < 30000
  AND e.manager_id IS NOT NULL
  AND m.employee_id IS NULL
ORDER BY e.employee_id;
```

This explicitly checks for missing manager rows.

---

## Interview Follow-up

Common mistake:

Writing:

```sql
manager_id NOT IN (...)
```

without handling `NULL`.

Problem:

Employees with:

```text
manager_id = NULL
```

have no manager — this **does not mean manager left**.

That’s why we must include:

```sql
manager_id IS NOT NULL
```

before checking missing managers.