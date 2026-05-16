# 1757. Recyclable and Low Fat Products

## Problem Link
https://leetcode.com/problems/recyclable-and-low-fat-products/

## Difficulty
Easy

---------------------

## Problem Statement

Table: `Products`

| Column Name | Type |
|---|---|
| product_id | int |
| low_fats | enum |
| recyclable | enum |

- `product_id` is the primary key.
- `low_fats` is an ENUM of type `('Y', 'N')`.
- `recyclable` is an ENUM of type `('Y', 'N')`.

Find the IDs of products that are both low fat and recyclable.

Return the result table in any order.

---------------------

## Example

### Input

| product_id | low_fats | recyclable |
|---|---|---|
| 0 | Y | N |
| 1 | Y | Y |
| 2 | N | Y |
| 3 | Y | Y |
| 4 | N | N |

### Output

| product_id |
|---|
| 1 |
| 3 |

---------------------

## Approach

We need to filter rows where:

- `low_fats = 'Y'`
- `recyclable = 'Y'`

Using the `WHERE` clause with the `AND` operator allows us to return only products satisfying both conditions.

---------------------

## SQL Query

```sql
SELECT product_id
FROM Products
WHERE low_fats = 'Y'
  AND recyclable = 'Y';
```

---------------------

## Explanation

- `SELECT product_id`
    - Returns only the product IDs.

- `WHERE low_fats = 'Y'`
    - Filters products that are low fat.

- `AND recyclable = 'Y'`
    - Ensures the product is recyclable as well.

Only rows matching both conditions are included in the final result.

---------------------

## Time Complexity

- **O(N)**  
  Scans all rows once.

## Space Complexity

- **O(1)**  
  No extra space is used.

---------------------

## Key SQL Concepts Used

- `SELECT`
- `WHERE`
- `AND`

---------------------

## Notes

A beginner-friendly SQL problem focused on filtering rows using multiple conditions in the `WHERE` clause.