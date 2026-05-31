# Product Sales Analysis III

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

# 📘 Problem Statement

Write an SQL query to report:

For each product:

- the first year the product was sold
- quantity sold in that year
- price in that year

Return:

| product_id | first_year | quantity | price |

---

# 🧠 Intuition

We need:

```text
For every product,
find its earliest sales year.
```

After finding the first year, we need the complete row containing:

- quantity
- price

for that first year.

---

# 🔍 Table

## `Sales`

| Column Name | Type |
|-------------|------|
| sale_id     | int |
| product_id  | int |
| year        | int |
| quantity    | int |
| price       | int |

---

## Example

### Sales

| product_id | year | quantity | price |
|------------|------|----------|--------|
| 100 | 2008 | 10 | 5000 |
| 100 | 2009 | 12 | 5000 |
| 200 | 2011 | 15 | 9000 |

---

For Product 100:

```text
First year = 2008
```

Return:

```text
(100, 2008, 10, 5000)
```

---

# 🧩 Key Observation

We need:

```text
minimum year per product
```

and then retrieve the corresponding row.

👉 This is a classic:

```text
First Row Per Group
```

problem.

---

# ✅ SQL Query (Using JOIN)

```sql
SELECT
    s.product_id,
    s.year AS first_year,
    s.quantity,
    s.price
FROM Sales s
JOIN (
    SELECT
        product_id,
        MIN(year) AS first_year
    FROM Sales
    GROUP BY product_id
) f
ON s.product_id = f.product_id
AND s.year = f.first_year;
```

---------------------

# 🔍 Step-by-Step Explanation

---

# 1️⃣ Find Earliest Year Per Product

```sql
SELECT
    product_id,
    MIN(year) AS first_year
FROM Sales
GROUP BY product_id;
```

---

### Example Output

| product_id | first_year |
|------------|-----------|
| 100 | 2008 |
| 200 | 2011 |

---

# 2️⃣ Join Back to Original Table

```sql
JOIN Sales s
```

Why?

Because:

```text
MIN(year)
```

only gives:

- product_id
- first year

But we also need:

- quantity
- price

---

# 3️⃣ Match Product + Year

```sql
ON s.product_id = f.product_id
AND s.year = f.first_year
```

This identifies the exact row corresponding to the first sale year.

---

### Example

Sales:

| product_id | year | quantity | price |
|------------|------|----------|--------|
| 100 | 2008 | 10 | 5000 |
| 100 | 2009 | 12 | 5000 |

First year:

| product_id | first_year |
|------------|-----------|
| 100 | 2008 |

Join result:

| product_id | year | quantity | price |
|------------|------|----------|--------|
| 100 | 2008 | 10 | 5000 |

---

# ✅ Final Output

| product_id | first_year | quantity | price |
|------------|-----------|----------|--------|
| 100 | 2008 | 10 | 5000 |
| 200 | 2011 | 15 | 9000 |

---

# ⏱️ Complexity Analysis

## Time Complexity

```text
O(n)
```

Where:
- `n` = rows in Sales

Grouping and joining are linear with indexing.

---

## Space Complexity

```text
O(k)
```

Where:
- `k` = number of products

Used by the grouped subquery.

---

# 🎯 Important SQL Concepts Used

---

# 1️⃣ GROUP BY

```sql
GROUP BY product_id
```

Creates one group per product.

---

# 2️⃣ MIN()

```sql
MIN(year)
```

Finds earliest year.

---

# 3️⃣ Derived Table

```sql
(
   SELECT ...
)
```

Creates a temporary result set.

---

# 4️⃣ JOIN

```sql
JOIN ...
ON ...
```

Used to recover additional columns after aggregation.

---

# ⚠️ Common Mistake

Wrong:

```sql
SELECT
    product_id,
    MIN(year),
    quantity,
    price
FROM Sales
GROUP BY product_id;
```

Why wrong?

Because:

```text
quantity and price
do not necessarily belong
to the row having MIN(year)
```

SQL may reject this query (or return incorrect results depending on DB settings).

---

# 🚀 Alternative Solution (Using Window Function)

```sql
SELECT
    product_id,
    year AS first_year,
    quantity,
    price
FROM (
    SELECT *,
           RANK() OVER(
               PARTITION BY product_id
               ORDER BY year
           ) AS rnk
    FROM Sales
) s
WHERE rnk = 1;
```

---

# 🔍 Why RANK Works

For each product:

```sql
PARTITION BY product_id
ORDER BY year
```

Example:

| product_id | year | rank |
|------------|------|------|
| 100 | 2008 | 1 |
| 100 | 2009 | 2 |
| 100 | 2010 | 3 |

Keeping:

```sql
WHERE rank = 1
```

returns the first sales year.

---

# 🚀 Interview Insight

This is one of the most common SQL interview patterns:

```text
Find row associated with MIN/MAX value
```

Examples:

- First order per customer
- Earliest login per user
- Highest salary per department
- First sale per product

---

# 🚀 Final Takeaway

This problem teaches:

- GROUP BY
- MIN()
- JOIN with aggregated results
- First-row-per-group pattern

Core idea:

```text
Find the minimum year per product
then join back to retrieve the complete row
```