# 1327. List the Products Ordered in a Period

## Problem Statement

Table: `Products`

| Column Name | Type |
|------------|------|
| product_id | int |
| product_name | varchar |

- `product_id` is the primary key.
- Each row represents a product.

---

Table: `Orders`

| Column Name | Type |
|------------|------|
| product_id | int |
| order_date | date |
| unit | int |

- There may be multiple orders for the same product.
- `product_id` is a foreign key referencing `Products.product_id`.

---

## Task

Find the products that satisfy **both** conditions:

1. The orders were placed in **February 2020**.
2. The total units ordered during that month are **at least 100**.

Return the result table containing:

| product_name | unit |

where:

- `unit` is the total number of units ordered in February 2020.

Return the result in any order.

---

## Example

### Input

### Products

| product_id | product_name |
|------------|--------------|
| 1 | Leetcode Solutions |
| 2 | Jewels of Stringology |
| 3 | HP |

### Orders

| product_id | order_date | unit |
|------------|------------|-----:|
| 1 | 2020-02-05 | 60 |
| 1 | 2020-02-10 | 70 |
| 2 | 2020-02-15 | 80 |
| 2 | 2020-03-01 | 40 |
| 3 | 2020-02-20 | 50 |
| 3 | 2020-02-25 | 40 |

---

### Output

| product_name | unit |
|--------------|-----:|
| Leetcode Solutions | 130 |

---

## Explanation

We only consider orders from:

```text
2020-02-01 to 2020-02-29
```

### Product 1

February orders:

```text
60
70
```

Total:

```text
130
```

Since:

```text
130 ≥ 100
```

Include.

---

### Product 2

February orders:

```text
80
```

March order is ignored.

Total:

```text
80
```

Less than 100.

Exclude.

---

### Product 3

February orders:

```text
50
40
```

Total:

```text
90
```

Less than 100.

Exclude.

---

## Approach (Most Optimal)

We need to:

1. Filter orders placed in February 2020.
2. Join with the `Products` table to get product names.
3. Group by product.
4. Calculate the total units sold.
5. Keep only products whose total units are at least 100.

---

## Why this works

### Step 1

Filter dates:

```sql
WHERE order_date BETWEEN
'2020-02-01'
AND '2020-02-29'
```

Only February orders remain.

---

### Step 2

Join products:

```sql
Products
JOIN Orders
```

This allows us to display product names.

---

### Step 3

Aggregate:

```sql
SUM(unit)
```

to compute the total units sold for each product.

---

### Step 4

Use:

```sql
HAVING SUM(unit) >= 100
```

to keep only qualifying products.

---

## Optimal MySQL Solution

```sql
SELECT
    p.product_name,
    SUM(o.unit) AS unit
FROM Products p
JOIN Orders o
    ON p.product_id = o.product_id
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY
    p.product_id,
    p.product_name
HAVING SUM(o.unit) >= 100;
```

---

## Dry Run

Filtered February orders:

| Product | Units |
|---------|------:|
| Product 1 | 60 |
| Product 1 | 70 |
| Product 2 | 80 |
| Product 3 | 50 |
| Product 3 | 40 |

Grouped totals:

| Product | Total Units |
|---------|------------:|
| Product 1 | 130 |
| Product 2 | 80 |
| Product 3 | 90 |

Apply:

```sql
HAVING SUM(unit) >= 100
```

Remaining:

| Product | Units |
|---------|------:|
| Product 1 | 130 |

---

## Complexity Analysis

### Time Complexity

```text
O(n)
```

- Scan the `Orders` table once.
- Join with `Products`.
- Group by product.

### Space Complexity

```text
O(k)
```

Where `k` is the number of distinct products in February, used for grouping.

---

## Key SQL Concepts Used

- `JOIN`
- `GROUP BY`
- `SUM()`
- `HAVING`
- `BETWEEN`
- Date Filtering
- Aggregate Functions

---

## Alternative Solution

Instead of using `BETWEEN`, you can filter by year and month:

```sql
SELECT
    p.product_name,
    SUM(o.unit) AS unit
FROM Products p
JOIN Orders o
    ON p.product_id = o.product_id
WHERE YEAR(o.order_date) = 2020
  AND MONTH(o.order_date) = 2
GROUP BY
    p.product_id,
    p.product_name
HAVING SUM(o.unit) >= 100;
```

While correct, using:

```sql
BETWEEN '2020-02-01' AND '2020-02-29'
```

is generally preferred because it is simpler and often allows better use of indexes on the `order_date` column.

---

## Interview Follow-up

### Why use `HAVING` instead of `WHERE`?

Incorrect:

```sql
WHERE SUM(unit) >= 100
```

This causes an error because `WHERE` is evaluated **before** grouping.

The correct order of execution is:

1. `WHERE` → Filter rows
2. `GROUP BY` → Create groups
3. `SUM()` → Calculate totals
4. `HAVING` → Filter groups

Therefore, aggregate conditions must always be placed in:

```sql
HAVING SUM(unit) >= 100
```

This is a very common SQL interview question.