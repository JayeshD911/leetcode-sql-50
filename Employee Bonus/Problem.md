# Employee Bonus

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

## 📘 Problem Statement

Write an SQL query to report:
- the name of each employee
- the bonus amount

for employees with:
```text
bonus < 1000
```

or employees who do not have a bonus.

Return the result table in any order.

---

## 🧠 Approach

We have two tables:

### `Employee`

| Column Name | Type |
|-------------|------|
| empId       | int  |
| name        | varchar |
| supervisor  | int |
| salary      | int |

---

### `Bonus`

| Column Name | Type |
|-------------|------|
| empId       | int |
| bonus       | int |

---

## 🔍 Key Observation

We must include:
- employees whose bonus is less than 1000 ✅
- employees with no bonus record ✅

👉 This means:
```text
LEFT JOIN
```

because we need all employees even if no matching bonus exists.

---

## ✅ SQL Query

```sql
SELECT 
    e.name,
    b.bonus
FROM Employee e
LEFT JOIN Bonus b
ON e.empId = b.empId
WHERE b.bonus < 1000
OR b.bonus IS NULL;
```

---------------------

## 🔍 Step-by-Step Explanation

---

### 1️⃣ LEFT JOIN

```sql
LEFT JOIN Bonus b
ON e.empId = b.empId
```

Keeps:
- all employees
- matching bonus if available

If no bonus exists:
```text
bonus = NULL
```

---

### 2️⃣ Filter Employees

```sql
WHERE b.bonus < 1000
OR b.bonus IS NULL
```

This includes:
- bonus less than 1000 ✅
- no bonus record ✅

---

## 🧪 Example

### Employee Table

| empId | name   |
|------|--------|
| 1    | Brad |
| 2    | John |
| 3    | Dan |
| 4    | Thomas |

---

### Bonus Table

| empId | bonus |
|------|------|
| 2    | 500 |
| 4    | 2000 |

---

## 🔄 After LEFT JOIN

| name   | bonus |
|--------|------|
| Brad   | NULL |
| John   | 500 |
| Dan    | NULL |
| Thomas | 2000 |

---

## 🔍 Apply Filter

Condition:

```text
bonus < 1000
OR bonus IS NULL
```

### Included:
- Brad ✅
- John ✅
- Dan ✅

### Excluded:
- Thomas ❌ (2000)

---

## ✅ Final Output

| name | bonus |
|------|------|
| Brad | NULL |
| John | 500 |
| Dan  | NULL |

---

## ⏱️ Complexity Analysis

### Time Complexity
```text
O(n + m)
```

Where:
- `n` = Employee rows
- `m` = Bonus rows

(assuming indexed joins)

---

### Space Complexity
```text
O(1)
```

No extra space used.

---

## 🎯 Key SQL Concepts Used

### 1️⃣ LEFT JOIN

Used when:
```text
missing relationships should also be included
```

---

### 2️⃣ NULL Handling

```sql
IS NULL
```

Used because:
```text
NULL cannot be compared using =
```

---

## ⚠️ Important SQL Insight

This is WRONG:

```sql
bonus = NULL
```

Correct syntax:

```sql
bonus IS NULL
```

---

## 🚀 Final Takeaway

This problem teaches:
- LEFT JOIN
- handling missing rows
- filtering with NULL values

Classic SQL interview pattern:

```sql
LEFT JOIN + IS NULL
```

Used to:
- include unmatched rows
- detect missing relationships