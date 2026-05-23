# 1251. Average Selling Price

## Problem Link
https://leetcode.com/problems/average-selling-price/

## Difficulty
Easy

---------------------

## Problem Statement

Table: `Prices`

| Column Name | Type |
|---|---|
| product_id | int |
| start_date | date |
| end_date | date |
| price | int |

- `(product_id, start_date, end_date)` is the primary key.
- Each row indicates the price of a product for a specific time period.

Table: `UnitsSold`

| Column Name | Type |
|---|---|
| product_id | int |
| purchase_date | date |
| units | int |

- This table may contain duplicate rows.
- Each row indicates how many units of a product were sold on a specific date.

Write a solution to find the average selling price for each product.

The average selling price is calculated as:

```text
Total Price of Product Sold / Total Units Sold
```

Round the result to `2` decimal places.

If a product has no sales, its average price should be `0`.

Return the result table in any order.

---------------------

## Example

### Input

### Prices

| product_id | start_date | end_date | price |
|---|---|---|---|
| 1 | 2019-02-17 | 2019-02-28 | 5 |
| 1 | 2019-03-01 | 2019-03-22 | 20 |
| 2 | 2019-02-01 | 2019-02-20 | 15 |
| 2 | 2019-02-21 | 2019-03-31 | 30 |

### UnitsSold

| product_id | purchase_date | units |
|---|---|---|
| 1 | 2019-02-25 | 100 |
| 1 | 2019-03-01 | 15 |
| 2 | 2019-02-10 | 200 |
| 2 | 2019-03-22 | 30 |

### Output

| product_id | average_price |
|---|---|
| 1 | 6.96 |
| 2 | 16.96 |

---------------------

## Approach

We need to:

1. Match each sale with the correct product price based on the purchase date.
2. Calculate:
    - Total revenue = `price * units`
    - Total units sold
3. Divide total revenue by total units sold.
4. Round the result to 2 decimal places.

We use:

- `JOIN` with date conditions
- `SUM()` for aggregation
- `ROUND()` for formatting

---------------------

## SQL Query

```sql
SELECT 
    p.product_id,
    ROUND(
        SUM(p.price * u.units) / SUM(u.units),
        2
    ) AS average_price
FROM Prices p
JOIN UnitsSold u
ON p.product_id = u.product_id
AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;
```

---------------------

## Explanation

- `JOIN`
    - Matches sales with the correct price period.

- `u.purchase_date BETWEEN p.start_date AND p.end_date`
    - Ensures the correct price is applied for the sale date.

- `SUM(p.price * u.units)`
    - Calculates total revenue.

- `SUM(u.units)`
    - Calculates total units sold.

- `ROUND(..., 2)`
    - Rounds the average selling price to 2 decimal places.

---------------------

## Time Complexity

- **O(N × M)**  
  In worst case during join operation.

## Space Complexity

- **O(N)**  
  Used internally for grouping.

---------------------

## Key SQL Concepts Used

- `JOIN`
- `BETWEEN`
- `SUM()`
- `GROUP BY`
- `ROUND()`

---------------------

## Notes

This problem is an excellent example of joining tables using date ranges and performing weighted average calculations using aggregation.