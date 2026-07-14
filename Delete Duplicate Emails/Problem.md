# 196. Delete Duplicate Emails

## Problem Statement

Table: `Person`

| Column Name | Type |
|------------|------|
| id | int |
| email | varchar |

- `id` is the primary key.
- Each row contains a person's email.
- The table may contain duplicate email addresses.

Write a query to **delete all duplicate emails**, keeping **only the row with the smallest `id`** for each email.

After executing the query:

- Every email should appear only once.
- The row with the **minimum `id`** should be preserved.

---

## Example

### Input

**Person**

| id | email |
|----|------------------|
| 1 | john@example.com |
| 2 | bob@example.com |
| 3 | john@example.com |

---

### Output

**Person**

| id | email |
|----|------------------|
| 1 | john@example.com |
| 2 | bob@example.com |

---

## Explanation

Original table:

| id | email |
|----|------------------|
| 1 | john@example.com |
| 2 | bob@example.com |
| 3 | john@example.com |

Duplicate email:

```text
john@example.com
```

Rows:

```text
id = 1
id = 3
```

Keep the smallest ID:

```text
1
```

Delete:

```text
3
```

Final table:

| id | email |
|----|------------------|
| 1 | john@example.com |
| 2 | bob@example.com |

---

## Approach (Most Optimal)

We compare each row with another row having the **same email**.

If another row exists with:

- the same email
- a smaller `id`

then the current row is a duplicate and should be deleted.

This can be achieved using a **self join**.

---

## Why this works

Suppose we have:

| id | email |
|----|-------|
| 1 | john |
| 3 | john |

Self join:

```text
p1.id = 3
p2.id = 1
```

Since:

```sql
3 > 1
```

Row `3` is deleted.

The smallest ID always survives because there is no smaller matching row.

---

## Optimal MySQL Solution

```sql
DELETE p1
FROM Person p1
JOIN Person p2
ON p1.email = p2.email
AND p1.id > p2.id;
```

---

## Dry Run

Input:

| id | email |
|----|-------|
| 1 | john |
| 2 | bob |
| 3 | john |
| 4 | john |

Join results:

| p1.id | p2.id |
|-------:|-------:|
| 3 | 1 |
| 4 | 1 |
| 4 | 3 |

Rows deleted:

```text
3
4
```

Remaining:

| id | email |
|----|-------|
| 1 | john |
| 2 | bob |

Exactly one row per email remains.

---

## Complexity Analysis

### Time Complexity

```text
O(n²)
```

In the worst case, the self join compares rows with matching emails.

With proper indexing on `email`, performance improves significantly in practice.

### Space Complexity

```text
O(1)
```

No additional storage is required.

---

## Key SQL Concepts Used

- `DELETE`
- Self Join
- Table Aliases
- Duplicate Removal
- Primary Key Comparison

---

## Alternative Solution (Using Subquery)

Another common solution:

```sql
DELETE
FROM Person
WHERE id NOT IN (
    SELECT id
    FROM (
        SELECT MIN(id) AS id
        FROM Person
        GROUP BY email
    ) AS temp
);
```

### Why is the extra subquery (`temp`) needed?

MySQL does not allow deleting from a table while directly selecting from the same table.

Wrapping the inner query in another subquery avoids this restriction.

---

## Interview Follow-up

### Why compare IDs?

Suppose:

| id | email |
|----|-------|
| 5 | a@gmail.com |
| 8 | a@gmail.com |
| 10 | a@gmail.com |

Requirement:

```text
Keep the smallest ID
```

Comparisons:

```text
8 > 5  → delete
10 > 5 → delete
```

Only:

```text
id = 5
```

remains.

---

### Common Mistake

Using:

```sql
DELETE
FROM Person
WHERE email IN (
    SELECT email
    FROM Person
    GROUP BY email
    HAVING COUNT(*) > 1
);
```

This deletes **all rows** for duplicated emails, including the one that should be kept.

The correct solution deletes **only rows with larger IDs**, preserving the smallest `id` for each email.