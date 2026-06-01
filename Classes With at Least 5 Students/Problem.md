# Classes With at Least 5 Students

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

# 📘 Problem Statement

Write an SQL query to report all classes that have:

```text
at least 5 students
```

Return:

| class |
|--------|

---

# 🧠 Intuition

Each row represents:

```text
one student enrolled in one class
```

To find classes having at least 5 students:

1. group rows by class
2. count students in each class
3. keep only classes with count ≥ 5

👉 This is a classic:

```text
GROUP BY + HAVING
```

problem.

---

# 🔍 Table

## `Courses`

| Column Name | Type |
|-------------|------|
| student     | varchar |
| class       | varchar |

---

## Example

| student | class |
|----------|--------|
| A | Math |
| B | Math |
| C | Math |
| D | Math |
| E | Math |
| F | Science |

---

### Student Count

| class | students |
|--------|----------|
| Math | 5 |
| Science | 1 |

Only:

```text
Math
```

should be returned.

---

# 🧩 Key Observation

We need to filter based on an aggregate value:

```text
COUNT(*)
```

Since aggregate values are calculated after grouping, we must use:

```sql
HAVING
```

and not:

```sql
WHERE
```

---

# ✅ SQL Query

```sql
SELECT
    class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;
```

---------------------

# 🔍 Step-by-Step Explanation

---

# 1️⃣ Group Rows by Class

```sql
GROUP BY class
```

Creates one group per class.

---

### Example

#### Math

| student |
|----------|
| A |
| B |
| C |
| D |
| E |

---

#### Science

| student |
|----------|
| F |

---

# 2️⃣ Count Students

```sql
COUNT(student)
```

Results:

| class | count |
|--------|------|
| Math | 5 |
| Science | 1 |

---

# 3️⃣ Apply HAVING Filter

```sql
HAVING COUNT(student) >= 5
```

Keeps:

| class |
|--------|
| Math |

Removes:

| class |
|--------|
| Science |

---

# ✅ Final Output

| class |
|--------|
| Math |

---

# ⏱️ Complexity Analysis

## Time Complexity

```text
O(n)
```

Where:
- `n` = rows in Courses

---

## Space Complexity

```text
O(k)
```

Where:
- `k` = number of distinct classes

Used internally for grouping.

---

# 🎯 Important SQL Concepts Used

---

# 1️⃣ GROUP BY

```sql
GROUP BY class
```

Groups rows by class.

---

# 2️⃣ COUNT()

```sql
COUNT(student)
```

Counts students in each class.

---

# 3️⃣ HAVING

```sql
HAVING COUNT(student) >= 5
```

Filters groups after aggregation.

---

# ⚠️ WHERE vs HAVING

A very common interview question.

---

## WHERE

Filters rows **before** grouping.

```sql
SELECT *
FROM Courses
WHERE class = 'Math';
```

---

## HAVING

Filters groups **after** grouping.

```sql
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(*) >= 5;
```

---

### Execution Order

```text
FROM
↓
WHERE
↓
GROUP BY
↓
HAVING
↓
SELECT
↓
ORDER BY
```

Because `COUNT()` is created after grouping:

```sql
WHERE COUNT(*) >= 5 ❌
```

is invalid.

---

# ⚠️ Common Mistake

Wrong:

```sql
SELECT class
FROM Courses
WHERE COUNT(student) >= 5
GROUP BY class;
```

Reason:

```text
COUNT() cannot be used in WHERE
```

Use:

```sql
HAVING COUNT(student) >= 5
```

instead.

---

# 🚀 Alternative Solution

```sql
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(*) >= 5;
```

Since `student` is never NULL in this problem:

```sql
COUNT(student)
```

and

```sql
COUNT(*)
```

produce the same result.

---

# 🎓 COUNT(*) vs COUNT(column)

### COUNT(*)

Counts all rows.

```sql
COUNT(*)
```

---

### COUNT(column)

Counts non-null values.

```sql
COUNT(student)
```

Example:

| student |
|----------|
| A |
| NULL |
| B |

```sql
COUNT(student) = 2
COUNT(*) = 3
```

---

# 🚀 Interview Insight

This is one of the most fundamental SQL aggregation questions.

Pattern:

```sql
GROUP BY column
HAVING aggregate_condition
```

Frequently used for:

- customers with > N orders
- products sold > N times
- classes with > N students
- departments with > N employees

---

# 🚀 Final Takeaway

This problem teaches:

- GROUP BY
- COUNT()
- HAVING

Core idea:

```text
Group rows
Compute aggregate values
Filter groups using HAVING
```