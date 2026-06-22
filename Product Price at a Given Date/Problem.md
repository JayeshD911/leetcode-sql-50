# 1164. Product Price at a Given Date

## Problem Statement

Table: `Products`

| Column Name | Type |
|------------|------|
| product_id | int |
| new_price | int |
| change_date | date |

`(product_id, change_date)` is the primary key.

Each row indicates that the price of a product was changed to `new_price` on `change_date`.

Initially, **all products have price = 10**.

Find the price of all products on **2019-08-16**.

Return the result table in any order.

---

## Example

### Input

**Products**

| product_id | new_price | change_date |
|------------|-----------|-------------|
| 1 | 20 | 2019-08-14 |
| 2 | 50 | 2019-08-14 |
| 1 | 30 | 2019-08-15 |
| 1 | 35 | 2019-08-16 |
| 2 | 65 | 2019-08-17 |
| 3 | 20 | 2019-08-18 |

---

### Output

| product_id | price |
|------------|-------|
| 1 | 35 |
| 2 | 50 |
| 3 | 10 |

---

## Explanation

We need the price of every product on:

```text
2019-08-16
```

Rules:

- Use the **latest price change on or before** `2019-08-16`
- If no price change happened before that date, price remains **10**

---

### Product 1

Changes:

```text
2019-08-14 → 20
2019-08-15 → 30
2019-08-16 → 35
```

Latest valid change = **35**

Result:

```text
1 → 35
```

---

### Product 2

Changes:

```text
2019-08-14 → 50
2019-08-17 → 65
```

Change on `2019-08-17` is after target date, so ignore it.

Latest valid change = **50**

Result:

```text
2 → 50
```

---

### Product 3

Changes:

```text
2019-08-18 → 20
```

This is after target date.

So product 3 never changed before `2019-08-16`.

Initial price applies:

```text
3 → 10
```

---

## Approach (Most Optimal)

We need two groups:

### 1. Products that changed on or before target date
For each product, find the **latest change_date ≤ 2019-08-16**.

### 2. Products with no valid change before target date
Assign default price:

```text
10
```

We combine both using `UNION`.

---

## Why this works

The key idea is:

For each product:

```sql
latest_change_date <= '2019-08-16'
```

That row contains the correct price.

If such a row doesn’t exist:

```sql
price = 10
```

---

## Optimal MySQL Solution

```sql
SELECT product_id, new_price AS price
FROM Products
WHERE (product_id, change_date) IN (
    SELECT product_id, MAX(change_date)
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
)

UNION

SELECT DISTINCT product_id, 10 AS price
FROM Products
WHERE product_id NOT IN (
    SELECT product_id
    FROM Products
    WHERE change_date <= '2019-08-16'
);
```

---

## Dry Run

Subquery:

```sql
SELECT product_id, MAX(change_date)
```

Returns:

| product_id | max(change_date) |
|------------|------------------|
| 1 | 2019-08-16 |
| 2 | 2019-08-14 |

These rows give:

| product_id | price |
|------------|-------|
| 1 | 35 |
| 2 | 50 |

Products not included:

```text
3
```

Assign default:

| product_id | price |
|------------|-------|
| 3 | 10 |

Final result:

| product_id | price |
|------------|-------|
| 1 | 35 |
| 2 | 50 |
| 3 | 10 |

---

## Complexity Analysis

### Time Complexity

```text
O(n log n)
```

- Grouping for `MAX(change_date)`
- Filtering rows
- `UNION`

(Practically near **O(n)** with proper indexing)

### Space Complexity

```text
O(n)
```

Used by grouping and union result.

---

## Key SQL Concepts Used

- `GROUP BY`
- `MAX()`
- Tuple comparison:
  ```sql
  (product_id, change_date) IN (...)
  ```
- `UNION`
- `NOT IN`

---

## Alternative Solution (Cleaner with Window Functions)

If MySQL 8+ is allowed:

```sql
WITH ranked AS (
    SELECT
        product_id,
        new_price,
        change_date,
        ROW_NUMBER() OVER (
            PARTITION BY product_id
            ORDER BY change_date DESC
        ) AS rn
    FROM Products
    WHERE change_date <= '2019-08-16'
)
SELECT p.product_id,
       IFNULL(r.new_price, 10) AS price
FROM (SELECT DISTINCT product_id FROM Products) p
LEFT JOIN ranked r
    ON p.product_id = r.product_id
   AND r.rn = 1;
```

---

## Interview Follow-up

A common trap is forgetting products that never changed before the target date.

Example:

```text
product_id = 5
change_date = 2019-08-20
```

Many solutions accidentally exclude this product.

But since every product starts with:

```text
price = 10
```

it **must still appear in output**.