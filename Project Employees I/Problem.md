# Project Employees I

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

## 📘 Problem Statement

Write an SQL query to report:
- the `project_id`
- the average employee experience years for each project

Round the average to 2 decimal places.

Return the result table in any order.

---

## 🧠 Approach

We have two tables:

### `Project`

| Column Name | Type |
|-------------|------|
| project_id  | int |
| employee_id | int |

---

### `Employee`

| Column Name     | Type |
|----------------|------|
| employee_id    | int |
| name           | varchar |
| experience_years | int |

---

## 🔍 Key Observation

- `Project` tells:
```text
which employees belong to which project
```

- `Employee` tells:
```text
employee experience
```

We need:
```text
average experience per project
```

👉 So:
1. join employees with projects
2. compute average experience
3. group by project

---

## ✅ SQL Query

```sql
SELECT 
    p.project_id,
    ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project p
JOIN Employee e
ON p.employee_id = e.employee_id
GROUP BY p.project_id;
```

---------------------

# 🔍 Step-by-Step Explanation

---

## 1️⃣ JOIN Tables

```sql
Project p
JOIN Employee e
ON p.employee_id = e.employee_id
```

This matches:
```text
project employee ↔ employee details
```

---

## 2️⃣ Get Experience Values

After join:

| project_id | employee_id | experience_years |
|------------|-------------|------------------|
| 1 | 1 | 3 |
| 1 | 2 | 2 |
| 1 | 3 | 1 |
| 2 | 1 | 3 |
| 2 | 4 | 2 |

---

## 3️⃣ GROUP BY Project

```sql
GROUP BY p.project_id
```

Creates groups:

### Project 1
```text
3, 2, 1
```

### Project 2
```text
3, 2
```

---

## 4️⃣ Compute Average

```sql
AVG(e.experience_years)
```

### Project 1

```text
(3 + 2 + 1) / 3 = 2.00
```

### Project 2

```text
(3 + 2) / 2 = 2.50
```

---

## 5️⃣ Round Result

```sql
ROUND(value, 2)
```

Rounds to:
```text
2 decimal places
```

---

## 🧪 Example

### Project

| project_id | employee_id |
|------------|-------------|
| 1 | 1 |
| 1 | 2 |
| 1 | 3 |
| 2 | 1 |
| 2 | 4 |

---

### Employee

| employee_id | name | experience_years |
|-------------|------|------------------|
| 1 | Khaled | 3 |
| 2 | Ali | 2 |
| 3 | John | 1 |
| 4 | Doe | 2 |

---

## ✅ Output

| project_id | average_years |
|------------|---------------|
| 1 | 2.00 |
| 2 | 2.50 |

---

## ⏱️ Complexity Analysis

### Time Complexity
```text
O(n + m)
```

Where:
- `n` = Project rows
- `m` = Employee rows

(assuming indexed joins)

---

### Space Complexity
```text
O(1)
```

No extra space used.

---

# 🎯 Key SQL Concepts Used

---

## 1️⃣ INNER JOIN

```sql
JOIN table2
ON condition
```

Combines related rows from multiple tables.

---

## 2️⃣ GROUP BY

```sql
GROUP BY project_id
```

Creates separate groups per project.

---

## 3️⃣ AVG()

```sql
AVG(column)
```

Calculates average values.

---

## 4️⃣ ROUND()

```sql
ROUND(value, decimals)
```

Rounds decimal numbers.

---

# 🚀 Final Takeaway

This problem teaches:
- joins
- aggregation
- grouping
- averaging numeric values

Classic SQL pattern:

```text
JOIN + GROUP BY + AGGREGATE FUNCTION
```