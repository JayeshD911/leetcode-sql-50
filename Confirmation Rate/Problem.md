# 1934. Confirmation Rate

## Problem Link
https://leetcode.com/problems/confirmation-rate/

## Difficulty
Medium

---------------------

## Problem Statement

Table: `Signups`

| Column Name | Type |
|---|---|
| user_id | int |
| time_stamp | datetime |

- `user_id` is the primary key for this table.
- Each row contains information about the signup time for a user.

Table: `Confirmations`

| Column Name | Type |
|---|---|
| user_id | int |
| time_stamp | datetime |
| action | ENUM |

- `(user_id, time_stamp)` is the primary key.
- `action` is an ENUM of type `('confirmed', 'timeout')`.
- Each row indicates whether the user confirmed their signup or the confirmation timed out.

The confirmation rate of a user is:

- Number of `'confirmed'` messages divided by total confirmation requests.
- If a user did not request any confirmation messages, the rate is `0`.

Write a solution to find the confirmation rate of each user.

Round the confirmation rate to `2` decimal places.

Return the result table in any order.

---------------------

## Example

### Input

### Signups

| user_id | time_stamp |
|---|---|
| 3 | 2020-03-21 10:16:13 |
| 7 | 2020-01-04 13:57:59 |
| 2 | 2020-07-29 23:09:44 |
| 6 | 2020-12-09 10:39:37 |

### Confirmations

| user_id | time_stamp | action |
|---|---|---|
| 3 | 2021-01-06 03:30:46 | timeout |
| 3 | 2021-07-14 14:00:00 | timeout |
| 7 | 2021-06-12 11:57:29 | confirmed |
| 7 | 2021-06-13 12:58:28 | confirmed |
| 7 | 2021-06-14 13:59:27 | confirmed |
| 2 | 2021-01-22 00:00:00 | confirmed |
| 2 | 2021-02-28 23:59:59 | timeout |

### Output

| user_id | confirmation_rate |
|---|---|
| 6 | 0.00 |
| 3 | 0.00 |
| 7 | 1.00 |
| 2 | 0.50 |

---------------------

## Approach

We need to calculate:

```text
confirmed_count / total_requests
```

for every user.

Steps:

1. Use `LEFT JOIN` to include users with no confirmations.
2. Count confirmed actions using `CASE WHEN`.
3. Divide by total confirmation requests.
4. Use `ROUND(..., 2)` for formatting.
5. Handle users with no requests using `IFNULL()`.

---------------------

## SQL Query

```sql
SELECT 
    s.user_id,
    ROUND(
        IFNULL(
            SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END)
            / COUNT(c.action),
            0
        ),
        2
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
ON s.user_id = c.user_id
GROUP BY s.user_id;
```

---------------------

## Explanation

- `LEFT JOIN`
    - Includes all users even if they have no confirmation requests.

- `CASE WHEN c.action = 'confirmed'`
    - Counts only confirmed requests.

- `SUM(...)`
    - Total confirmed requests.

- `COUNT(c.action)`
    - Total confirmation attempts.

- `IFNULL(..., 0)`
    - Returns `0` when a user has no confirmation requests.

- `ROUND(..., 2)`
    - Rounds the result to 2 decimal places.

---------------------

## Time Complexity

- **O(N + M)**  
  Where:
    - `N` = rows in `Signups`
    - `M` = rows in `Confirmations`

## Space Complexity

- **O(N)**  
  Used internally for grouping.

---------------------

## Key SQL Concepts Used

- `LEFT JOIN`
- `GROUP BY`
- `CASE WHEN`
- `SUM()`
- `COUNT()`
- `IFNULL()`
- `ROUND()`

---------------------

## Notes

This problem is a great example of conditional aggregation and handling `NULL` values during division operations.