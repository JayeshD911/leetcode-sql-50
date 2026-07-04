# 602. Friend Requests II: Who Has the Most Friends

## Problem Statement

Table: `RequestAccepted`

| Column Name | Type |
|------------|------|
| requester_id | int |
| accepter_id | int |
| accept_date | date |

- `(requester_id, accepter_id)` is the primary key.
- Each row represents a **friend request that has been accepted**.
- Friendship is **bidirectional**, meaning if user A and user B are friends, both users gain one friend.

Find the person who has the **largest number of friends**.

Return the result table with:

| id | num |

where:

- `id` is the person's ID.
- `num` is the number of friends they have.

The test cases guarantee that **exactly one person has the most friends**.

---

## Example

### Input

**RequestAccepted**

| requester_id | accepter_id | accept_date |
|--------------|-------------|-------------|
| 1 | 2 | 2016-06-03 |
| 1 | 3 | 2016-06-08 |
| 2 | 3 | 2016-06-08 |
| 3 | 4 | 2016-06-09 |

---

### Output

| id | num |
|----|-----|
| 3 | 3 |

---

## Explanation

Each accepted request creates **one friendship** for both users.

Friend counts:

### User 1

Friends:

```text
2, 3
```

Count:

```text
2
```

---

### User 2

Friends:

```text
1, 3
```

Count:

```text
2
```

---

### User 3

Friends:

```text
1, 2, 4
```

Count:

```text
3
```

---

### User 4

Friends:

```text
3
```

Count:

```text
1
```

The maximum is:

```text
User 3 → 3 friends
```

---

## Approach (Most Optimal)

Each row contributes **one friend** to **both** people involved.

So:

1. Extract all `requester_id`s.
2. Extract all `accepter_id`s.
3. Combine them using `UNION ALL`.
4. Count occurrences of each ID.
5. Return the user with the highest count.

---

## Why this works

A friendship is mutual.

For a row:

```text
1 accepted 2
```

Both users gain one friend.

Using:

```sql
UNION ALL
```

produces:

```text
1
2
```

Now every friendship contributes exactly one count to each user.

Grouping these IDs gives the total number of friends.

---

## Optimal MySQL Solution

```sql
SELECT
    id,
    COUNT(*) AS num
FROM (
    SELECT requester_id AS id
    FROM RequestAccepted

    UNION ALL

    SELECT accepter_id AS id
    FROM RequestAccepted
) AS friendships
GROUP BY id
ORDER BY num DESC
LIMIT 1;
```

---

## Dry Run

Input:

| requester | accepter |
|-----------|----------|
| 1 | 2 |
| 1 | 3 |
| 2 | 3 |
| 3 | 4 |

After `UNION ALL`:

| id |
|----|
| 1 |
| 1 |
| 2 |
| 3 |
| 2 |
| 3 |
| 3 |
| 4 |

Count:

| id | Friends |
|----|---------|
| 1 | 2 |
| 2 | 2 |
| 3 | 3 |
| 4 | 1 |

Maximum:

```text
3 → 3
```

---

## Complexity Analysis

### Time Complexity

```text
O(n)
```

- Read each friendship twice.
- Group once.

### Space Complexity

```text
O(n)
```

For the temporary union result.

---

## Key SQL Concepts Used

- `UNION ALL`
- `GROUP BY`
- `COUNT`
- Derived Tables
- `ORDER BY`
- `LIMIT`

---

## Alternative Solution

Instead of sorting, we can first compute friend counts in a CTE:

```sql
WITH friend_count AS (
    SELECT
        id,
        COUNT(*) AS num
    FROM (
        SELECT requester_id AS id FROM RequestAccepted
        UNION ALL
        SELECT accepter_id FROM RequestAccepted
    ) t
    GROUP BY id
)
SELECT *
FROM friend_count
WHERE num = (
    SELECT MAX(num)
    FROM friend_count
);
```

This approach is useful if multiple users could share the maximum count.

---

## Interview Follow-up

Common mistake:

Using:

```sql
UNION
```

instead of:

```sql
UNION ALL
```

Problem:

`UNION` removes duplicate rows.

Suppose a user has multiple friendships:

```text
1 → 2
1 → 3
1 → 4
```

Using `UNION` may eliminate repeated IDs and undercount friendships.

Since **every accepted friendship contributes one friend**, we must preserve all occurrences.

Therefore:

```sql
UNION ALL
```

is the correct choice.