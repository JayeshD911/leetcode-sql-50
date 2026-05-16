# 584. Find Customer Referee

## Problem Link
https://leetcode.com/problems/find-customer-referee/

## Difficulty
Easy

---------------------

## Problem Statement

Table: `Customer`

| Column Name | Type |
|---|---|
| id | int |
| name | varchar |
| referee_id | int |

- `id` is the primary key column for this table.
- Each row indicates the ID of a customer, their name, and the ID of the customer who referred them.

Find the names of customers that are **not referred by the customer with id = 2**.

Return the result table in any order.

---------------------

## Example

### Input

| id | name | referee_id |
|---|---|---|
| 1 | Will | NULL |
| 2 | Jane | NULL |
| 3 | Alex | 2 |
| 4 | Bill | NULL |
| 5 | Zack | 1 |
| 6 | Mark | 2 |

### Output

| name |
|---|
| Will |
| Jane |
| Bill |
| Zack |

---------------------

## Approach

We need customers whose `referee_id` is:

- Not equal to `2`
- Or `NULL` (because `NULL != 2` does not evaluate to true in SQL)

So, we explicitly handle `NULL` values using the `IS NULL` condition.

---------------------

## SQL Query

```sql
SELECT name
FROM Customer
WHERE referee_id != 2
   OR referee_id IS NULL;
```

---------------------

## Explanation

- `SELECT name`
    - Returns only customer names.

- `WHERE referee_id != 2`
    - Excludes customers referred by customer `2`.

- `OR referee_id IS NULL`
    - Includes customers who were not referred by anyone.

This ensures all valid customers are included in the result.

---------------------

## Time Complexity

- **O(N)**  
  Scans all rows once.

## Space Complexity

- **O(1)**  
  No extra space is used.

---------------------

## Key SQL Concepts Used

- `SELECT`
- `WHERE`
- `!=`
- `IS NULL`
- `OR`

---------------------

## Notes

This problem highlights an important SQL concept: comparisons with `NULL` do not behave like normal values, so `IS NULL` must be used explicitly.