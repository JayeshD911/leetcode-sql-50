# 585. Investments in 2016

## Problem Statement

Table: `Insurance`

| Column Name | Type |
|------------|------|
| pid | int |
| tiv_2015 | decimal |
| tiv_2016 | decimal |
| lat | decimal |
| lon | decimal |

- `pid` is the primary key.
- Each row represents an insurance policy.

Find the **sum of `tiv_2016`** for all policyholders who satisfy **both** conditions:

1. They have the **same `tiv_2015` value as at least one other policyholder**.
2. Their **location (`lat`, `lon`) is unique** (no other policyholder shares the same coordinates).

Return the sum rounded to **2 decimal places**.

---

## Example

### Input

**Insurance**

| pid | tiv_2015 | tiv_2016 | lat | lon |
|-----|----------|----------|-----|-----|
| 1 | 10 | 5 | 10 | 10 |
| 2 | 20 | 20 | 20 | 20 |
| 3 | 10 | 30 | 20 | 20 |
| 4 | 10 | 40 | 40 | 40 |

---

### Output

| tiv_2016 |
|-----------|
| 45.00 |

---

## Explanation

We need policies satisfying **both** conditions.

### Condition 1: Duplicate `tiv_2015`

Group by `tiv_2015`:

| tiv_2015 | Count |
|----------|------:|
| 10 | 3 ✅ |
| 20 | 1 ❌ |

Eligible policies:

```text
pid = 1
pid = 3
pid = 4
```

---

### Condition 2: Unique Location

Group by `(lat, lon)`:

| Location | Count |
|----------|------:|
| (10,10) | 1 ✅ |
| (20,20) | 2 ❌ |
| (40,40) | 1 ✅ |

Eligible policies:

```text
pid = 1
pid = 4
```

---

### Final Eligible Policies

| pid | tiv_2016 |
|-----|----------|
| 1 | 5 |
| 4 | 40 |

Sum:

```text
5 + 40 = 45
```

Output:

```text
45.00
```

---

## Approach (Most Optimal)

The problem requires checking **two independent conditions**:

1. `tiv_2015` appears more than once.
2. `(lat, lon)` appears exactly once.

We can solve this using two subqueries:

- One finds duplicated `tiv_2015` values.
- Another finds unique locations.

Finally, sum the `tiv_2016` values of rows satisfying both.

---

## Why this works

### Step 1

Find duplicated investment values:

```sql
GROUP BY tiv_2015
HAVING COUNT(*) > 1
```

---

### Step 2

Find unique locations:

```sql
GROUP BY lat, lon
HAVING COUNT(*) = 1
```

---

### Step 3

Keep only rows satisfying both conditions and compute:

```sql
SUM(tiv_2016)
```

---

## Optimal MySQL Solution

```sql
SELECT
    ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
)
AND (lat, lon) IN (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
);
```

---

## Dry Run

Duplicate `tiv_2015` values:

```text
10
```

Unique locations:

```text
(10,10)
(40,40)
```

Matching rows:

| pid | tiv_2016 |
|-----|----------|
| 1 | 5 |
| 4 | 40 |

Final answer:

```text
45.00
```

---

## Complexity Analysis

### Time Complexity

```text
O(n)
```

- One scan for duplicated `tiv_2015`
- One scan for unique locations
- One scan for final aggregation

### Space Complexity

```text
O(n)
```

Used for grouping results.

---

## Key SQL Concepts Used

- `GROUP BY`
- `HAVING`
- `COUNT`
- Tuple Comparison
- `IN`
- `SUM`
- `ROUND`

---

## Alternative Solution (Using CTEs)

A cleaner MySQL 8+ approach:

```sql
WITH duplicate_tiv AS (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
),
unique_location AS (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
)
SELECT
    ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
    SELECT tiv_2015
    FROM duplicate_tiv
)
AND (lat, lon) IN (
    SELECT lat, lon
    FROM unique_location
);
```

---

## Interview Follow-up

A common mistake is checking only one condition.

For example, selecting policies with duplicated `tiv_2015` without verifying unique locations would incorrectly include:

```text
pid = 3
```

Similarly, checking only unique locations would incorrectly include policies whose `tiv_2015` is unique.

Both conditions must be satisfied simultaneously:

```sql
Duplicate tiv_2015
AND
Unique (lat, lon)
```

Only then should `tiv_2016` be included in the final sum.