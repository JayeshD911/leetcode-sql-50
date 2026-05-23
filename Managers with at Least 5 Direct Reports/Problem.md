# 570. Managers with at Least 5 Direct Reports

## Problem Link
https://leetcode.com/problems/managers-with-at-least-5-direct-reports/

## Difficulty
Medium

---------------------

## Problem Statement

Table: `Employee`

| Column Name | Type |
|---|---|
| id | int |
| name | varchar |
| department | varchar |
| managerId | int |

- `id` is the primary key column.
- Each row of this table indicates the ID of an employee, their name, department, and the ID of their manager.
- If `managerId` is `NULL`, then the employee does not have a manager.

Write a solution to find managers with at least `5` direct reports.

Return the result table in any order.

---------------------

## Example

### Input

| id | name | department | managerId |
|---|---|---|---|
| 101 | John | A | NULL |
| 102 | Dan | A | 101 |
| 103 | James | A | 101 |
| 104 | Amy | A | 101 |
| 105 | Anne | A | 101 |
| 106 | Ron | B | 101 |

### Output

| name |
|---|
| John |

---------------------

## Approach

We need to:

1. Group employees by their `managerId`
2. Count how many employees report to each manager
3. Keep only managers with at least `5` direct reports
4. Retrieve the manager names using a self join

We use:

- `GROUP BY` for grouping
- `COUNT()` for counting reports
- `HAVING` for filtering grouped data
- Self `JOIN` to get manager names

---------------------

## SQL Query

```sql
SELECT e1.name
FROM Employee e1
JOIN Employee e2
ON e1.id = e2.managerId
GROUP BY e1.id, e1.name
HAVING COUNT(e2.managerId) >= 5;
```

---------------------

## Explanation

- `Employee e1`
    - Represents managers.

- `Employee e2`
    - Represents employees reporting to managers.

- `ON e1.id = e2.managerId`
    - Matches managers with their direct reports.

- `GROUP BY e1.id, e1.name`
    - Groups all employees under each manager.

- `HAVING COUNT(e2.managerId) >= 5`
    - Keeps only managers with at least 5 direct reports.

---------------------

## Time Complexity

- **O(N)**  
  Single pass grouping and counting.

## Space Complexity

- **O(N)**  
  Used internally for grouping.

---------------------

## Key SQL Concepts Used

- `JOIN`
- Self Join
- `GROUP BY`
- `COUNT()`
- `HAVING`

---------------------

## Notes

This is a classic aggregation problem that demonstrates how to use self joins along with grouping and filtering aggregated results.