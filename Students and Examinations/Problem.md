# Students and Examinations

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

## 📘 Problem Statement

Write an SQL query to find:
- each student's name
- each subject name
- the number of times the student attended the exam for that subject

Return the result table ordered by:
```text
student_id, subject_name
```

---

## 🧠 Approach

We need to generate:
```text
Every student × every subject combination
```

Then count:
```text
how many exams the student attended for that subject
```

---

## 🔍 Key Observation

We have 3 tables:

### `Students`

| Column Name | Type |
|-------------|------|
| student_id  | int |
| student_name| varchar |

---

### `Subjects`

| Column Name | Type |
|-------------|------|
| subject_name| varchar |

---

### `Examinations`

| Column Name | Type |
|-------------|------|
| student_id  | int |
| subject_name| varchar |

---

We must:
1. create all possible student-subject pairs
2. match examination records
3. count occurrences

👉 This requires:
- `CROSS JOIN`
- `LEFT JOIN`
- `GROUP BY`

---

## ✅ SQL Query

```sql
SELECT 
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
ON s.student_id = e.student_id
AND sub.subject_name = e.subject_name
GROUP BY 
    s.student_id,
    s.student_name,
    sub.subject_name
ORDER BY 
    s.student_id,
    sub.subject_name;
```

---------------------

# 🔍 Step-by-Step Explanation

---

## 1️⃣ CROSS JOIN

```sql
Students
CROSS JOIN Subjects
```

Creates:

```text
every student × every subject
```

---

### Example

### Students

| student_id | student_name |
|-----------|--------------|
| 1 | Alice |
| 2 | Bob |

### Subjects

| subject_name |
|--------------|
| Math |
| Physics |

---

### CROSS JOIN Result

| student | subject |
|---------|---------|
| Alice | Math |
| Alice | Physics |
| Bob | Math |
| Bob | Physics |

---

## 2️⃣ LEFT JOIN with Examinations

```sql
LEFT JOIN Examinations e
ON s.student_id = e.student_id
AND sub.subject_name = e.subject_name
```

Matches:
```text
student + subject
```

with actual exam attendance records.

---

## 3️⃣ COUNT Exams

```sql
COUNT(e.subject_name)
```

Counts:
```text
number of matching examination rows
```

If no match:
```text
COUNT = 0
```

---

## 🧪 Example

### Examinations

| student_id | subject_name |
|------------|--------------|
| 1 | Math |
| 1 | Math |
| 1 | Physics |
| 2 | Math |

---

## 🔄 Counts

### Alice

- Math → 2
- Physics → 1

### Bob

- Math → 1
- Physics → 0

---

## ✅ Output

| student_id | student_name | subject_name | attended_exams |
|------------|--------------|--------------|----------------|
| 1 | Alice | Math | 2 |
| 1 | Alice | Physics | 1 |
| 2 | Bob | Math | 1 |
| 2 | Bob | Physics | 0 |

---

## ⏱️ Complexity Analysis

### Time Complexity
```text
O(S × Sub + E)
```

Where:
- `S` = number of students
- `Sub` = number of subjects
- `E` = examination rows

---

### Space Complexity
```text
O(1)
```

Ignoring output storage.

---

# 🎯 Key SQL Concepts Used

---

## 1️⃣ CROSS JOIN

```sql
CROSS JOIN
```

Creates:
```text
Cartesian Product
```

(all combinations)

---

## 2️⃣ LEFT JOIN

Used to:
```text
preserve all student-subject combinations
```

even when no exam exists.

---

## 3️⃣ GROUP BY

```sql
GROUP BY student, subject
```

Needed for counting per combination.

---

## 4️⃣ COUNT()

```sql
COUNT(column)
```

Counts non-null matches.

---

# 🚀 Final Takeaway

This is a very important SQL interview problem because it combines:

- CROSS JOIN
- LEFT JOIN
- GROUP BY
- COUNT

Core pattern:

```text
Generate all combinations
then count matches
```