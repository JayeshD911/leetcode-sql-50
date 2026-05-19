# Average Time of Process per Machine

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

## 📘 Problem Statement

There is a table:

### `Activity`

| Column Name | Type |
|-------------|------|
| machine_id  | int  |
| process_id  | int  |
| activity_type | enum |
| timestamp   | float |

- `activity_type` is either:
    - `'start'`
    - `'end'`

Each `(machine_id, process_id)` pair has:
- one start record
- one end record

We need to find:
```text
average processing time for each machine
```

Rounded to 3 decimal places.

---

## 🧠 Approach

For every process:
```text
processing_time = end_timestamp - start_timestamp
```

Then:
```text
average_time = AVG(processing_time)
```

per machine.

---

## 🔍 Key Observation

The `start` and `end` rows are stored separately.

So we need to:
- pair them together
- using:
    - `machine_id`
    - `process_id`

👉 This is a classic:

```text
Self Join problem
```

---

## ✅ SQL Query

```sql
SELECT 
    a1.machine_id,
    ROUND(AVG(a2.timestamp - a1.timestamp), 3) AS processing_time
FROM Activity a1
JOIN Activity a2
ON a1.machine_id = a2.machine_id
AND a1.process_id = a2.process_id
WHERE a1.activity_type = 'start'
AND a2.activity_type = 'end'
GROUP BY a1.machine_id;
```

---------------------

## 🔍 Step-by-Step Explanation

---

### 1️⃣ Self Join

```sql
Activity a1
JOIN Activity a2
```

We treat:
- `a1` → start row
- `a2` → end row

---

### 2️⃣ Match Same Process

```sql
a1.machine_id = a2.machine_id
AND a1.process_id = a2.process_id
```

This ensures:
```text
start and end belong to same process
```

---

### 3️⃣ Filter Start and End Rows

```sql
a1.activity_type = 'start'
AND a2.activity_type = 'end'
```

Now we have:

| start_time | end_time |
|------------|----------|
| 0.712      | 1.520 |

---

### 4️⃣ Compute Processing Time

```sql
a2.timestamp - a1.timestamp
```

Example:

```text
1.520 - 0.712 = 0.808
```

---

### 5️⃣ Average Per Machine

```sql
AVG(...)
GROUP BY machine_id
```

---

### 6️⃣ Round to 3 Decimals

```sql
ROUND(value, 3)
```

---

## 🧪 Example

### Activity Table

| machine_id | process_id | activity_type | timestamp |
|------------|------------|---------------|-----------|
| 0 | 0 | start | 0.712 |
| 0 | 0 | end   | 1.520 |
| 0 | 1 | start | 3.140 |
| 0 | 1 | end   | 4.120 |
| 1 | 0 | start | 0.550 |
| 1 | 0 | end   | 1.550 |

---

## 🔄 Processing Times

### Machine 0

Process 0:
```text
1.520 - 0.712 = 0.808
```

Process 1:
```text
4.120 - 3.140 = 0.980
```

Average:
```text
(0.808 + 0.980) / 2 = 0.894
```

---

### Machine 1

Process 0:
```text
1.550 - 0.550 = 1.000
```

Average:
```text
1.000
```

---

## ✅ Output

| machine_id | processing_time |
|------------|----------------|
| 0          | 0.894 |
| 1          | 1.000 |

---

## ⏱️ Complexity Analysis

### Time Complexity
```text
O(n²)
```

Due to self join comparisons.

With indexing on:
```text
(machine_id, process_id)
```

performance improves significantly.

---

### Space Complexity
```text
O(1)
```

No extra space used.

---

## 🎯 Key SQL Concepts Used

### 1️⃣ Self Join

Used when related rows exist in the same table.

---

### 2️⃣ Aggregate Functions

```sql
AVG()
```

Computes average.

---

### 3️⃣ GROUP BY

```sql
GROUP BY machine_id
```

Calculates results per machine.

---

### 4️⃣ ROUND()

```sql
ROUND(value, decimals)
```

Rounds decimal numbers.

---

## 🚀 Final Takeaway

This problem teaches:
- self joins
- pairing related rows
- aggregation using `AVG`
- grouping data

Classic SQL interview pattern:

```text
Join rows from same table to compute derived values
```