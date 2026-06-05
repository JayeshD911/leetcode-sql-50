# Customers Who Bought All Products

🔗 Problem Link: https://leetcode.com/problems/customers-who-bought-all-products/

---

# 📘 Problem Statement

Write an SQL query to find:

```text
customers who bought every product
```

Return:

| customer_id |
|-------------|

The result can be returned in any order.

---

# 🧠 Intuition

A customer qualifies if:

```text
Number of distinct products purchased by the customer
=
Total number of products available
```

So we need:

1. Total number of products.
2. Distinct products purchased by each customer.
3. Compare the two counts.

👉 This is a classic:

```text
GROUP BY + COUNT(DISTINCT) + HAVING
```

problem.

---

# 🔍 Tables

## `Customer`

| Column Name | Type |
|-------------|------|
| customer_id | int |
| product_key | int |

---

## `Product`

| Column Name | Type |
|-------------|------|
| product_key | int |

---

# 🧩 Key Observation

Suppose:

### Product Table

| product_key |
|------------|
| 5 |
| 6 |

Total products:

```text
2
```

---

### Customer Table

| customer_id | product_key |
|-------------|------------|
| 1 | 5 |
| 1 | 6 |
| 2 | 5 |

Customer 1 purchased:

```text
{5, 6}
```

Count:

```text
2
```

Customer 1 bought all products ✅

---

Customer 2 purchased:

```text
{5}
```

Count:

```text
1
```

Customer 2 did not buy all products ❌

---

# ✅ SQL Query

```sql
SELECT
    customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (
    SELECT COUNT(*)
    FROM Product
);
```

---------------------

# 🔍 Step-by-Step Explanation

---

## 1️⃣ Count Total Products

```sql
SELECT COUNT(*)
FROM Product;
```

Example:

### Product

| product_key |
|------------|
| 5 |
| 6 |
| 7 |

Result:

```text
3
```

---

## 2️⃣ Group Purchases by Customer

```sql
GROUP BY customer_id
```

Creates groups:

### Customer 1

```text
5, 6, 7
```

---

### Customer 2

```text
5, 6
```

---

### Customer 3

```text
5, 6, 7
```

---

## 3️⃣ Count Distinct Products Bought

```sql
COUNT(DISTINCT product_key)
```

Results:

| customer_id | distinct_products |
|-------------|-------------------|
| 1 | 3 |
| 2 | 2 |
| 3 | 3 |

---

## 4️⃣ Keep Customers Who Bought All Products

```sql
HAVING COUNT(DISTINCT product_key) = (
    SELECT COUNT(*)
    FROM Product
)
```

Comparison:

| customer_id | bought | total products |
|-------------|---------|----------------|
| 1 | 3 | 3 ✅ |
| 2 | 2 | 3 ❌ |
| 3 | 3 | 3 ✅ |

---

# ✅ Final Output

| customer_id |
|-------------|
| 1 |
| 3 |

---

# 🧪 Example Walkthrough

### Product

| product_key |
|------------|
| 1 |
| 2 |
| 3 |

---

### Customer

| customer_id | product_key |
|-------------|------------|
| 1 | 1 |
| 1 | 2 |
| 1 | 3 |
| 2 | 1 |
| 2 | 2 |
| 3 | 1 |
| 3 | 2 |
| 3 | 3 |

---

### Distinct Product Count

| customer_id | count |
|-------------|--------|
| 1 | 3 |
| 2 | 2 |
| 3 | 3 |

Total products:

```text
3
```

Qualified customers:

```text
1, 3
```

---

# 🎯 Important SQL Concepts Used

---

## 1️⃣ GROUP BY

```sql
GROUP BY customer_id
```

Creates one group per customer.

---

## 2️⃣ COUNT(DISTINCT)

```sql
COUNT(DISTINCT product_key)
```

Counts unique products purchased.

---

### Why DISTINCT?

Suppose:

| customer_id | product_key |
|-------------|------------|
| 1 | 5 |
| 1 | 5 |
| 1 | 6 |

Without DISTINCT:

```sql
COUNT(product_key)
```

Result:

```text
3
```

Wrong.

With DISTINCT:

```sql
COUNT(DISTINCT product_key)
```

Result:

```text
2
```

Correct.

---

## 3️⃣ HAVING

```sql
HAVING aggregate_condition
```

Filters groups after aggregation.

---

# ⚠️ Common Mistake

Wrong:

```sql
HAVING COUNT(product_key) = (
    SELECT COUNT(*)
    FROM Product
)
```

Reason:

```text
Duplicate purchases may inflate the count.
```

Always use:

```sql
COUNT(DISTINCT product_key)
```

---

# 🚀 Alternative Solution (Using JOIN)

```sql
SELECT
    c.customer_id
FROM Customer c
GROUP BY c.customer_id
HAVING COUNT(DISTINCT c.product_key) =
(
    SELECT COUNT(DISTINCT product_key)
    FROM Product
);
```

---

# ⏱️ Complexity Analysis

### Time Complexity

```text
O(n)
```

Where:

- `n` = rows in Customer

---

### Space Complexity

```text
O(k)
```

Where:

- `k` = number of customers

Used internally for grouping.

---

# 🚀 Interview Pattern

This is a famous SQL pattern:

```text
Entity has ALL items from another table
```

Common variations:

- Customers who bought all products
- Students who attended all courses
- Users who completed all tasks
- Employees who worked on all projects

---

# 🚀 Final Takeaway

Core idea:

```text
Count distinct products purchased
and compare it with
the total number of products.
```

Pattern:

```sql
GROUP BY entity
HAVING COUNT(DISTINCT item)
     = total_items
```