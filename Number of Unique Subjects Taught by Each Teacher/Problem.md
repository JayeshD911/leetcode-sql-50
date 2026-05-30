# Number of Unique Subjects Taught by Each Teacher

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

# 📘 Problem Statement

Write an SQL query to calculate:

```text
the number of unique subjects taught by each teacher
```

Return:
- `teacher_id`
- `cnt` (number of unique subjects)

Return the result table in any order.

---

# 🧠 Intuition

A teacher may teach:

- the same subject in multiple departments
- multiple different subjects

We only need:

```text
unique subjects per teacher
```

So:

- group by teacher
- count distinct subjects

👉 This is a classic:

```text
GROUP BY + COUNT(DISTINCT)
```

problem.

---

# 🔍 Table

## `Teacher`

| Column Name | Type |
|-------------|------|
| teacher_id  | int |
| subject_id  | int |
| dept_id     | int |

---

## Example

| teacher_id | subject_id | dept_id |
|------------|------------|----------|
| 1 | 2 | 3 |
| 1 | 2 | 4 |
| 1 | 3 | 3 |
| 2 | 1 | 1 |
| 2 | 2 | 1 |
| 2 | 3 | 1 |

---

Notice:

Teacher 1 teaches:

```text
subject 2
subject 2
subject 3
```

Even though subject 2 appears twice:

```text
Unique subjects = {2, 3}
Count = 2
```

---

# ✅ SQL Query

```sql
SELECT
    teacher_id,
    COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;
```

---------------------

# 🔍 Step-by-Step Explanation

---

# 1️⃣ Group Rows by Teacher

```sql
GROUP BY teacher_id
```

Creates groups:

### Teacher 1

| subject_id |
|------------|
| 2 |
| 2 |
| 3 |

---

### Teacher 2

| subject_id |
|------------|
| 1 |
| 2 |
| 3 |

---

# 2️⃣ Count Unique Subjects

```sql
COUNT(DISTINCT subject_id)
```

Removes duplicates before counting.

---

### Teacher 1

Subjects:

```text
2, 2, 3
```

Distinct subjects:

```text
2, 3
```

Count:

```text
2
```

---

### Teacher 2

Subjects:

```text
1, 2, 3
```

Distinct subjects:

```text
1, 2, 3
```

Count:

```text
3
```

---

# ✅ Final Output

| teacher_id | cnt |
|------------|-----|
| 1 | 2 |
| 2 | 3 |

---

# ⏱️ Complexity Analysis

## Time Complexity

```text
O(n)
```

Where:
- `n` = number of rows in Teacher

---

## Space Complexity

```text
O(k)
```

Where:
- `k` = number of distinct subjects per teacher

(used internally by DISTINCT)

---

# 🎯 Important SQL Concepts Used

---

# 1️⃣ GROUP BY

```sql
GROUP BY teacher_id
```

Groups rows teacher-wise.

---

# 2️⃣ COUNT(DISTINCT)

```sql
COUNT(DISTINCT subject_id)
```

Counts unique values only.

---

## Difference

### COUNT()

```sql
COUNT(subject_id)
```

Counts:

```text
2, 2, 3
```

Result:

```text
3
```

---

### COUNT(DISTINCT)

```sql
COUNT(DISTINCT subject_id)
```

Counts:

```text
2, 3
```

Result:

```text
2
```

---

# ⚠️ Common Mistake

Wrong:

```sql
SELECT
    teacher_id,
    COUNT(subject_id)
FROM Teacher
GROUP BY teacher_id;
```

This counts duplicate subjects.

Example:

```text
Teacher 1 → 3
```

Expected:

```text
Teacher 1 → 2
```

---

# 🚀 Interview Insight

This is one of the most common SQL aggregation patterns.

Pattern:

```sql
GROUP BY column
COUNT(DISTINCT column)
```

Frequently used for:

- unique users
- unique products
- unique subjects
- unique visitors

---

# 🚀 Final Takeaway

This problem teaches:

- grouping data
- counting unique values
- DISTINCT with aggregate functions

Core idea:

```text
Group rows
then count distinct values within each group
```