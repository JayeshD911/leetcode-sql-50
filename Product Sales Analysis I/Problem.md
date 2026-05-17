# Product Sales Analysis I

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

## 📘 Problem Statement

Write an SQL query that reports:
- the `product_name`
- `year`
- `price`

for each `sale_id` in the `Sales` table.

Return the resulting table in any order.

---

## 🧠 Approach

We have two tables:

### `Sales`

| Column Name | Type |
|-------------|------|
| sale_id     | int  |
| product_id  | int  |
| year        | int  |
| quantity    | int  |
| price       | int  |

### `Product`

| Column Name | Type |
|-------------|------|
| product_id  | int  |
| product_name| varchar |

---

### 🔍 Key Observation

- `Sales` contains:
    - `product_id`
    - `year`
    - `price`

- `Product` contains:
    - `product_name`

To get the product name corresponding to each sale:

👉 We need a `JOIN` on `product_id`.

---

## ✅ SQL Query

```sql
SELECT 
    p.product_name,
    s.year,
    s.price
FROM Sales s
INNER JOIN Product p
ON s.product_id = p.product_id;
```

---------------------

## 🔍 Why INNER JOIN?

We only want:
- sales having valid products

`INNER JOIN` returns rows where:
```text
Sales.product_id = Product.product_id
```

---

## 🧪 Example

### Sales

| sale_id | product_id | year | quantity | price |
|---------|------------|------|----------|-------|
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |

---

### Product

| product_id | product_name |
|------------|--------------|
| 100        | Nokia |
| 200        | Apple |

---

## 🔄 Join Matching

```text
100 → Nokia
200 → Apple
```

---

## ✅ Output

| product_name | year | price |
|--------------|------|-------|
| Nokia        | 2008 | 5000  |
| Nokia        | 2009 | 5000  |
| Apple        | 2011 | 9000  |

---

## ⏱️ Complexity Analysis

### Time Complexity
```text
O(n + m)
```

Where:
- `n` = rows in Sales
- `m` = rows in Product

(assuming indexed joins)

---

### Space Complexity
```text
O(1)
```

No extra space used.

---

## 🎯 Key SQL Concepts Used

### INNER JOIN

```sql
INNER JOIN table2
ON condition
```

Returns only matching rows from both tables.

---

## 🚀 Final Takeaway

This problem is a straightforward JOIN problem.

Main learning:
- how to combine data from multiple tables
- using foreign keys (`product_id`)
- using `INNER JOIN`

Classic pattern:

```sql
SELECT columns
FROM table1
JOIN table2
ON matching_condition;
```