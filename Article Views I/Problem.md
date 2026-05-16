# 1148. Article Views I

## Problem Link
https://leetcode.com/problems/article-views-i/

## Difficulty
Easy

---------------------

## Problem Statement

Table: `Views`

| Column Name | Type |
|---|---|
| article_id | int |
| author_id | int |
| viewer_id | int |
| view_date | date |

- There is no primary key for this table.
- Each row indicates that a viewer viewed an article on a specific date.
- If `author_id` and `viewer_id` are equal, it means the author viewed their own article.

Write a solution to find all the authors that viewed at least one of their own articles.

Return the result table sorted by `id` in ascending order.

---------------------

## Example

### Input

| article_id | author_id | viewer_id | view_date |
|---|---|---|---|
| 1 | 3 | 5 | 2019-08-01 |
| 1 | 3 | 6 | 2019-08-02 |
| 2 | 7 | 7 | 2019-08-01 |
| 2 | 7 | 6 | 2019-08-02 |
| 4 | 7 | 1 | 2019-07-22 |
| 3 | 4 | 4 | 2019-07-21 |
| 3 | 4 | 4 | 2019-07-21 |

### Output

| id |
|---|
| 4 |
| 7 |

---------------------

## Approach

We need to find rows where:

- `author_id = viewer_id`

This means the author viewed their own article.

Since the same author may appear multiple times, we use `DISTINCT` to avoid duplicates.

Finally, sort the result by `id` in ascending order.

---------------------

## SQL Query

```sql
SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id;
```

---------------------

## Explanation

- `SELECT DISTINCT`
    - Removes duplicate author IDs.

- `author_id AS id`
    - Renames the output column to `id`.

- `WHERE author_id = viewer_id`
    - Filters rows where authors viewed their own articles.

- `ORDER BY id`
    - Sorts the result in ascending order.

---------------------

## Time Complexity

- **O(N log N)**  
  Due to sorting operation.

## Space Complexity

- **O(1)**  
  Ignoring output storage.

---------------------

## Key SQL Concepts Used

- `SELECT DISTINCT`
- `WHERE`
- `ORDER BY`
- Column Aliasing using `AS`

---------------------

## Notes

This problem demonstrates filtering rows using column comparison and removing duplicates using `DISTINCT`.