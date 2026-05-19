# Rising Temperature

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

## 📘 Problem Statement

Write an SQL query to find all dates' IDs with temperatures higher than their previous dates (yesterday).

Return the result table in any order.

---

## 🧠 Approach

We need to compare:
- today's temperature
- yesterday's temperature

This means:
- comparing rows within the same table

👉 Classic **Self Join** problem.

---

## 🔍 Key Observation

For a row:

| id | recordDate | temperature |
|----|------------|-------------|
| 2  | 2015-01-02 | 25 |

We must compare with:

| id | recordDate | temperature |
|----|------------|-------------|
| 1  | 2015-01-01 | 10 |

Condition:
```text
today.temperature > yesterday.temperature
```

AND

```text
today.recordDate = yesterday.recordDate + 1 day
```

---

## ✅ SQL Query

```sql
SELECT w1.id
FROM Weather w1
JOIN Weather w2
ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE w1.temperature > w2.temperature;
```

---------------------

## 🔍 Why Self Join?

We use the same table twice:

```sql
Weather w1
Weather w2
```

Think of:
- `w1` → today
- `w2` → yesterday

We compare rows from the same table.

---

## 🔍 Understanding `DATEDIFF`

```sql
DATEDIFF(date1, date2)
```

returns:

```text
date1 - date2
```

in days.

Example:

```sql
DATEDIFF('2015-01-02', '2015-01-01')
```

returns:

```text
1
```

---

## 🧪 Example

### Weather Table

| id | recordDate | temperature |
|----|------------|-------------|
| 1  | 2015-01-01 | 10 |
| 2  | 2015-01-02 | 25 |
| 3  | 2015-01-03 | 20 |
| 4  | 2015-01-04 | 30 |

---

## 🔄 Comparison

### Day 2 vs Day 1
```text
25 > 10 ✅
```

Include:
```text
id = 2
```

---

### Day 3 vs Day 2
```text
20 > 25 ❌
```

Do not include.

---

### Day 4 vs Day 3
```text
30 > 20 ✅
```

Include:
```text
id = 4
```

---

## ✅ Output

| id |
|----|
| 2  |
| 4  |

---

## ⏱️ Complexity Analysis

### Time Complexity
```text
O(n²)
```

(Self join comparisons)

With indexing on `recordDate`, performance improves significantly.

---

### Space Complexity
```text
O(1)
```

No extra space used.

---

## 🎯 Key SQL Concepts Used

### Self Join

Joining a table with itself.

Pattern:

```sql
FROM table t1
JOIN table t2
ON condition
```

---

### Date Functions

```sql
DATEDIFF(date1, date2)
```

Used for comparing dates.

---

## 🚀 Alternative Solution (Using LAG)

Modern SQL solution:

```sql
SELECT id
FROM (
    SELECT 
        id,
        temperature,
        recordDate,
        LAG(temperature) OVER (ORDER BY recordDate) AS prev_temp,
        LAG(recordDate) OVER (ORDER BY recordDate) AS prev_date
    FROM Weather
) t
WHERE temperature > prev_temp
AND DATEDIFF(recordDate, prev_date) = 1;
```

But the self join solution is:
- simpler
- more commonly expected for this problem

---

## 🚀 Final Takeaway

This problem teaches:
- self joins
- date comparison
- comparing current row with previous row

Classic SQL interview pattern:

```sql
Compare rows within the same table
```