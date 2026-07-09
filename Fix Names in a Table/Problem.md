# 1667. Fix Names in a Table

## Problem Statement

Table: `Users`

| Column Name | Type |
|------------|------|
| user_id | int |
| name | varchar |

- `user_id` is the primary key.
- Each row contains a user's name, but the capitalization may be incorrect.

Write a query to fix the names so that:

- The **first letter is uppercase**.
- All remaining letters are **lowercase**.

Return the result table ordered by `user_id`.

The output should contain:

| user_id | name |

---

## Example

### Input

**Users**

| user_id | name |
|---------|------|
| 1 | aLice |
| 2 | bOB |

---

### Output

| user_id | name |
|---------|------|
| 1 | Alice |
| 2 | Bob |

---

## Explanation

### User 1

Original:

```text
aLice
```

Transform:

- First letter → `A`
- Remaining letters → `lice`

Result:

```text
Alice
```

---

### User 2

Original:

```text
bOB
```

Transform:

- First letter → `B`
- Remaining letters → `ob`

Result:

```text
Bob
```

---

## Approach (Most Optimal)

We split each name into two parts:

1. First character
2. Remaining characters

Then:

- Convert the first character to uppercase using `UPPER()`.
- Convert the remaining characters to lowercase using `LOWER()`.
- Concatenate both parts using `CONCAT()`.

Finally, sort by `user_id`.

---

## Why this works

For a name like:

```text
aLice
```

### First character

```sql
LEFT(name, 1)
```

Returns:

```text
a
```

After:

```sql
UPPER(...)
```

Becomes:

```text
A
```

---

### Remaining characters

```sql
SUBSTRING(name, 2)
```

Returns:

```text
Lice
```

After:

```sql
LOWER(...)
```

Becomes:

```text
lice
```

---

### Combine

```text
A + lice
```

Result:

```text
Alice
```

---

## Optimal MySQL Solution

```sql
SELECT
    user_id,
    CONCAT(
        UPPER(LEFT(name, 1)),
        LOWER(SUBSTRING(name, 2))
    ) AS name
FROM Users
ORDER BY user_id;
```

---

## Dry Run

Input:

| user_id | name |
|---------|------|
| 1 | aLice |
| 2 | bOB |

### User 1

```text
LEFT(name,1) = a
UPPER() = A

SUBSTRING(name,2) = Lice
LOWER() = lice

Result = Alice
```

---

### User 2

```text
LEFT(name,1) = b
UPPER() = B

SUBSTRING(name,2) = OB
LOWER() = ob

Result = Bob
```

---

## Complexity Analysis

### Time Complexity

```text
O(n)
```

Each name is processed exactly once.

### Space Complexity

```text
O(1)
```

No additional storage is required apart from the output.

---

## Key SQL Concepts Used

- `UPPER()`
- `LOWER()`
- `LEFT()`
- `SUBSTRING()`
- `CONCAT()`
- `ORDER BY`

---

## Alternative Solution

Instead of `LEFT()`, you can use `SUBSTRING()` for both parts:

```sql
SELECT
    user_id,
    CONCAT(
        UPPER(SUBSTRING(name, 1, 1)),
        LOWER(SUBSTRING(name, 2))
    ) AS name
FROM Users
ORDER BY user_id;
```

This produces the same result.

---

## Interview Follow-up

### Why not use only `UPPER(name)`?

Example:

```text
aLice
```

Using:

```sql
UPPER(name)
```

Produces:

```text
ALICE
```

which is incorrect.

Similarly,

```sql
LOWER(name)
```

Produces:

```text
alice
```

also incorrect.

The correct solution requires applying **different transformations** to different parts of the string:

- First character → `UPPER()`
- Remaining characters → `LOWER()`

This ensures names follow the required format:

```text
Alice
Bob
Charlie
```