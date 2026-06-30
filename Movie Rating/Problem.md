# 1341. Movie Rating

## Problem Statement

Table: `Movies`

| Column Name | Type |
|------------|------|
| movie_id | int |
| title | varchar |

`movie_id` is the primary key.

---

Table: `Users`

| Column Name | Type |
|------------|------|
| user_id | int |
| name | varchar |

`user_id` is the primary key.

---

Table: `MovieRating`

| Column Name | Type |
|------------|------|
| movie_id | int |
| user_id | int |
| rating | int |
| created_at | date |

- `(movie_id, user_id)` is unique.
- Each row stores a user's rating for a movie.

Find:

1. The **name of the user** who rated the greatest number of movies.
    - If multiple users tie, return the **lexicographically smallest name**.

2. The **movie name** with the highest average rating in **February 2020**.
    - If multiple movies tie, return the **lexicographically smallest title**.

Return the result as:

| results |
|---------|
| user_name |
| movie_title |

---

## Example

### Input

### Movies

| movie_id | title |
|----------|-------|
| 1 | Avengers |
| 2 | Frozen 2 |
| 3 | Joker |

### Users

| user_id | name |
|---------|------|
| 1 | Daniel |
| 2 | Monica |
| 3 | Maria |
| 4 | James |

### MovieRating

| movie_id | user_id | rating | created_at |
|----------|---------|--------|------------|
| 1 | 1 | 3 | 2020-01-12 |
| 1 | 2 | 4 | 2020-02-11 |
| 1 | 3 | 2 | 2020-02-12 |
| 1 | 4 | 1 | 2020-01-01 |
| 2 | 1 | 5 | 2020-02-17 |
| 2 | 2 | 2 | 2020-02-01 |
| 2 | 3 | 2 | 2020-03-01 |
| 3 | 1 | 3 | 2020-02-22 |
| 3 | 2 | 4 | 2020-02-25 |

---

### Output

| results |
|---------|
| Daniel |
| Frozen 2 |

---

## Explanation

We need **two independent answers**.

---

## Part 1 — User who rated most movies

Count ratings per user.

| User | Number of Ratings |
|------|-------------------|
| Daniel | 3 |
| Monica | 3 |
| Maria | 2 |
| James | 1 |

Top count = **3**

Tie between:

- Daniel
- Monica

Lexicographically smaller:

```text
Daniel
```

---

## Part 2 — Highest Rated Movie in Feb 2020

Only ratings in:

```text
2020-02-01 to 2020-02-29
```

Relevant rows:

| Movie | Ratings |
|-------|---------|
| Avengers | 4, 2 |
| Frozen 2 | 5, 2 |
| Joker | 3, 4 |

Average ratings:

### Avengers

```text
(4 + 2) / 2 = 3.0
```

### Frozen 2

```text
(5 + 2) / 2 = 3.5
```

### Joker

```text
(3 + 4) / 2 = 3.5
```

Tie between:

- Frozen 2
- Joker

Lexicographically smaller:

```text
Frozen 2
```

---

## Approach (Most Optimal)

Since we need two separate results:

### Query 1
- Join `Users` and `MovieRating`
- Count ratings per user
- Sort by:
    1. Count descending
    2. Name ascending

---

### Query 2
- Filter ratings for February 2020
- Join `Movies`
- Compute average rating per movie
- Sort by:
    1. Average descending
    2. Title ascending

Finally combine both using:

```sql
UNION ALL
```

---

## Why this works

Sorting ensures tie-breaking automatically.

For user query:

```sql
ORDER BY COUNT(*) DESC, name ASC
```

For movie query:

```sql
ORDER BY AVG(rating) DESC, title ASC
```

Then take only top row with:

```sql
LIMIT 1
```

---

## Optimal MySQL Solution

```sql
(
    SELECT u.name AS results
    FROM Users u
    JOIN MovieRating mr
        ON u.user_id = mr.user_id
    GROUP BY u.user_id, u.name
    ORDER BY COUNT(*) DESC, u.name ASC
    LIMIT 1
)

UNION ALL

(
    SELECT m.title AS results
    FROM Movies m
    JOIN MovieRating mr
        ON m.movie_id = mr.movie_id
    WHERE mr.created_at BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY m.movie_id, m.title
    ORDER BY AVG(mr.rating) DESC, m.title ASC
    LIMIT 1
);
```

---

## Dry Run

### Query 1 Result

```text
Daniel
```

---

### Query 2 Result

Average ratings in Feb:

| Movie | Avg |
|-------|-----|
| Avengers | 3.0 |
| Frozen 2 | 3.5 |
| Joker | 3.5 |

Tie:

- Frozen 2
- Joker

Lexicographically smaller:

```text
Frozen 2
```

---

## Final Output

| results |
|---------|
| Daniel |
| Frozen 2 |

---

## Complexity Analysis

### Time Complexity

```text
O(n log n)
```

- Grouping users
- Grouping movies
- Sorting for ranking

Where `n` = number of ratings.

### Space Complexity

```text
O(n)
```

Used for aggregation.

---

## Key SQL Concepts Used

- `JOIN`
- `GROUP BY`
- `COUNT`
- `AVG`
- `ORDER BY`
- `LIMIT`
- `UNION ALL`

---

## Alternative Solution

Using CTEs for readability:

```sql
WITH user_rank AS (
    ...
),
movie_rank AS (
    ...
)
```

This makes the query easier to read but does not improve performance.

---

## Interview Follow-up

Common mistake:

Using:

```sql
ORDER BY COUNT(*) DESC
```

only.

Problem:

Ties are unresolved.

The problem explicitly requires:

```text
Lexicographically smallest name/title on ties
```

That’s why secondary sorting is necessary:

```sql
ORDER BY metric DESC, name/title ASC
```