# 1484. Group Sold Products By The Date

## Problem Statement

Table: `Activities`

| Column Name | Type |
|------------|------|
| sell_date | date |
| product | varchar |

- There may be multiple rows for the same date.
- The same product may be sold multiple times on the same date.

For each `sell_date`, report:

- `sell_date`
- `num_sold` → Number of **distinct** products sold.
- `products` → Comma-separated list of **distinct** product names sorted in **lexicographical order**.

Return the result table ordered by `sell_date`.

---

## Example

### Input

**Activities**

| sell_date | product |
|-----------|---------|
| 2020-05-30 | Headphone |
| 2020-06-01 | Pencil |
| 2020-06-02 | Mask |
| 2020-05-30 | Basketball |
| 2020-06-01 | Bible |
| 2020-06-02 | Mask |
| 2020-05-30 | T-Shirt |

---

### Output

| sell_date | num_sold | products |
|-----------|----------|----------|
| 2020-05-30 | 3 | Basketball,Headphone,T-Shirt |
| 2020-06-01 | 2 | Bible,Pencil |
| 2020-06-02 | 1 | Mask |

---

## Explanation

### 2020-05-30

Products sold:

```text
Headphone
Basketball
T-Shirt
```

Distinct products:

```text
Basketball
Headphone
T-Shirt
```

Count:

```text
3
```

Sorted alphabetically:

```text
Basketball,Headphone,T-Shirt
```

---

### 2020-06-01

Products:

```text
Pencil
Bible
```

Sorted:

```text
Bible,Pencil
```

Count:

```text
2
```

---

### 2020-06-02

Products:

```text
Mask
Mask
```

Distinct products:

```text
Mask
```

Count:

```text
1
```

---

## Approach (Most Optimal)

For each date, we need to:

1. Group all records by `sell_date`.
2. Count **distinct** products.
3. Concatenate **distinct** product names.
4. Sort product names alphabetically inside the concatenated string.

MySQL provides the perfect function for this:

```sql
GROUP_CONCAT()
```

---

## Why this works

### Step 1

Group rows:

```sql
GROUP BY sell_date
```

Now each group contains all products sold on that date.

---

### Step 2

Count unique products:

```sql
COUNT(DISTINCT product)
```

This ignores duplicate sales of the same product.

---

### Step 3

Create the product list:

```sql
GROUP_CONCAT(
    DISTINCT product
    ORDER BY product
    SEPARATOR ','
)
```

This:

- Removes duplicates
- Sorts alphabetically
- Joins products with commas

---

## Optimal MySQL Solution

```sql
SELECT
    sell_date,
    COUNT(DISTINCT product) AS num_sold,
    GROUP_CONCAT(
        DISTINCT product
        ORDER BY product
        SEPARATOR ','
    ) AS products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date;
```

---

## Dry Run

Input:

| sell_date | product |
|-----------|---------|
| 2020-06-02 | Mask |
| 2020-06-02 | Mask |

After grouping:

```text
2020-06-02
```

Distinct products:

```text
Mask
```

Count:

```text
1
```

`GROUP_CONCAT` result:

```text
Mask
```

---

For:

```text
2020-05-30
```

Products:

```text
Headphone
Basketball
T-Shirt
```

After sorting:

```text
Basketball
Headphone
T-Shirt
```

Concatenated:

```text
Basketball,Headphone,T-Shirt
```

---

## Complexity Analysis

### Time Complexity

```text
O(n log n)
```

- `GROUP BY` processes all rows.
- Sorting inside `GROUP_CONCAT` is performed for each date.

### Space Complexity

```text
O(n)
```

Used for grouping and building the concatenated product strings.

---

## Key SQL Concepts Used

- `GROUP BY`
- `COUNT(DISTINCT ...)`
- `GROUP_CONCAT()`
- `DISTINCT`
- `ORDER BY`
- String Aggregation

---

## Alternative Solution

There is no cleaner alternative in MySQL than `GROUP_CONCAT()`.

Without it, you'd have to concatenate strings manually using stored procedures or application code, which is significantly more complex and less efficient.

---

## Interview Follow-up

### Why use `DISTINCT` inside `GROUP_CONCAT()`?

Consider:

| sell_date | product |
|-----------|---------|
| 2020-06-02 | Mask |
| 2020-06-02 | Mask |

Without `DISTINCT`:

```sql
GROUP_CONCAT(product)
```

Produces:

```text
Mask,Mask
```

which is incorrect.

Using:

```sql
GROUP_CONCAT(DISTINCT product)
```

Produces:

```text
Mask
```

which matches the problem requirement.

---

### Why specify `ORDER BY` inside `GROUP_CONCAT()`?

Without:

```sql
ORDER BY product
```

the concatenated order is not guaranteed.

Example:

```text
Headphone,T-Shirt,Basketball
```

The expected output is:

```text
Basketball,Headphone,T-Shirt
```

Therefore, always use:

```sql
GROUP_CONCAT(
    DISTINCT product
    ORDER BY product
)
```

to produce a deterministic, lexicographically sorted list.