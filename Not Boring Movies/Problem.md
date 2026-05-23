# 620. Not Boring Movies

## Problem Link
https://leetcode.com/problems/not-boring-movies/

## Difficulty
Easy

---------------------

## Problem Statement

Table: `Cinema`

| Column Name | Type |
|---|---|
| id | int |
| movie | varchar |
| description | varchar |
| rating | float |

- `id` is the primary key column.
- Each row contains information about a movie, its description, and rating.

Write a solution to:

- Find movies with an odd-numbered `id`
- Exclude movies where `description = 'boring'`
- Return the result ordered by `rating` in descending order

---------------------

## Example

### Input

| id | movie | description | rating |
|---|---|---|---|
| 1 | War | great 3D | 8.9 |
| 2 | Science | fiction | 8.5 |
| 3 | irish | boring | 6.2 |
| 4 | Ice song | Fantacy | 8.6 |
| 5 | House card | Interesting | 9.1 |

### Output

| id | movie | description | rating |
|---|---|---|---|
| 5 | House card | Interesting | 9.1 |
| 1 | War | great 3D | 8.9 |

---------------------

## Approach

We need movies satisfying two conditions:

1. `id` should be odd
2. `description` should not be `'boring'`

Finally, sort the result by `rating` in descending order.

We use:

- `MOD(id, 2)` to check odd IDs
- `!=` to exclude boring movies
- `ORDER BY` for sorting

---------------------

## SQL Query

```sql
SELECT *
FROM Cinema
WHERE MOD(id, 2) = 1
  AND description != 'boring'
ORDER BY rating DESC;
```

---------------------

## Explanation

- `MOD(id, 2) = 1`
    - Filters movies with odd-numbered IDs.

- `description != 'boring'`
    - Excludes boring movies.

- `ORDER BY rating DESC`
    - Sorts movies by highest rating first.

---------------------

## Time Complexity

- **O(N log N)**  
  Due to sorting operation.

## Space Complexity

- **O(1)**  
  Ignoring output storage.

---------------------

## Key SQL Concepts Used

- `WHERE`
- `MOD()`
- `AND`
- `ORDER BY`
- `DESC`

---------------------

## Notes

This problem combines filtering with sorting and introduces the use of the `MOD()` function to identify odd and even numbers.