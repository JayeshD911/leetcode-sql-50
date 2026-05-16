# 595. Big Countries

## Problem Link
https://leetcode.com/problems/big-countries/

## Difficulty
Easy

---------------------

## Problem Statement

Table: `World`

| Column Name | Type |
|---|---|
| name | varchar |
| continent | varchar |
| area | int |
| population | int |
| gdp | bigint |

- `name` is the primary key column.
- Each row of this table contains information about the name of a country, continent, area, population, and GDP.

A country is considered **big** if:

- it has an area of at least `3000000`, or
- it has a population of at least `25000000`.

Write a solution to find the name, population, and area of the big countries.

Return the result table in any order.

---------------------

## Example

### Input

| name | continent | area | population | gdp |
|---|---|---|---|---|
| Afghanistan | Asia | 652230 | 25500100 | 20343000000 |
| Albania | Europe | 28748 | 2831741 | 12960000000 |
| Algeria | Africa | 2381741 | 37100000 | 188681000000 |

### Output

| name | population | area |
|---|---|---|
| Afghanistan | 25500100 | 652230 |
| Algeria | 37100000 | 2381741 |

---------------------

## Approach

We need to identify countries satisfying at least one of these conditions:

- `area >= 3000000`
- `population >= 25000000`

Since either condition is enough, we use the `OR` operator.

---------------------

## SQL Query

```sql
SELECT name, population, area
FROM World
WHERE area >= 3000000
   OR population >= 25000000;
```

---------------------

## Explanation

- `SELECT name, population, area`
    - Returns only the required columns.

- `WHERE area >= 3000000`
    - Includes countries with large area.

- `OR population >= 25000000`
    - Includes countries with large population.

Any country matching at least one condition is included in the result.

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
- `OR`

---------------------

## Notes

This problem is a simple filtering problem that demonstrates how to combine multiple conditions using the `OR` operator.