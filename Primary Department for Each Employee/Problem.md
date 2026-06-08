# Primary Department for Each Employee

🔗 Problem Link: https://leetcode.com/problems/primary-department-for-each-employee/

---

# 📘 Problem Statement

Each employee belongs to one or more departments.

A department is considered the employee's **primary department** if:

```text
primary_flag = 'Y'
```

However, if an employee belongs to only one department, then that department should be returned even if:

```text
primary_flag = 'N'
```

Return:

| employee_id | department_id |
|------------|---------------|

for every employee.

---

# 🧠 Intuition

There are two possible cases:

### Case 1: Employee belongs to multiple departments

One row will have:

```text
primary_flag = 'Y'
```

Return that department.

---

### Case 2: Employee belongs to exactly one department

Return that department regardless of:

```text
primary_flag
```

---

👉 So we need:

```text
All rows with primary_flag = 'Y'
OR
Employees having only one department
```

This is a classic:

```text
Filtering + Aggregation
```

problem.

---

# 🔍 Table

## `Employee`

| Column Name | Type |
|-------------|------|
| employee_id | int |
| department_id | int |
| primary_flag | varchar |

---

## Example

### Employee

| employee_id | department_id | primary_flag |
|------------|--------------|--------------|
| 1 | 1 | N |
| 2 | 1 | Y |
| 2 | 2 | N |
| 3 | 3 | N |

---

Employee 1:

```text
Only one department
→ return department 1
```

Employee 2:

```text
Multiple departments
Primary department = 1
```

Employee 3:

```text
Only one department
→ return department 3
```

---

# ✅ SQL Query

```sql
SELECT
    employee_id,
    department_id
FROM Employee
WHERE primary_flag = 'Y'

UNION

SELECT
    employee_id,
    department_id
FROM Employee
GROUP BY employee_id
HAVING COUNT(*) = 1;
```

---------------------

# 🔍 Step-by-Step Explanation

---

## 1️⃣ Get Explicit Primary Departments

```sql
SELECT
    employee_id,
    department_id
FROM Employee
WHERE primary_flag = 'Y'
```

---

### Example

| employee_id | department_id |
|------------|--------------|
| 2 | 1 |

Because:

```text
primary_flag = 'Y'
```

---

## 2️⃣ Find Employees Having Only One Department

```sql
GROUP BY employee_id
HAVING COUNT(*) = 1
```

---

### Example

Input:

| employee_id | department_id |
|------------|--------------|
| 1 | 1 |
| 2 | 1 |
| 2 | 2 |
| 3 | 3 |

Counts:

| employee_id | rows |
|------------|------|
| 1 | 1 |
| 2 | 2 |
| 3 | 1 |

Employees:

```text
1
3
```

qualify.

---

### Result

| employee_id | department_id |
|------------|--------------|
| 1 | 1 |
| 3 | 3 |

---

## 3️⃣ Combine Both Results

```sql
UNION
```

Combines:

### Primary Departments

| employee_id | department_id |
|------------|--------------|
| 2 | 1 |

+

### Single Department Employees

| employee_id | department_id |
|------------|--------------|
| 1 | 1 |
| 3 | 3 |

---

### Final Result

| employee_id | department_id |
|------------|--------------|
| 1 | 1 |
| 2 | 1 |
| 3 | 3 |

---

# ✅ Final Output

| employee_id | department_id |
|------------|--------------|
| 1 | 1 |
| 2 | 1 |
| 3 | 3 |

---

# 🎯 Important SQL Concepts Used

---

## 1️⃣ WHERE

```sql
WHERE primary_flag = 'Y'
```

Filters explicit primary departments.

---

## 2️⃣ GROUP BY

```sql
GROUP BY employee_id
```

Groups rows employee-wise.

---

## 3️⃣ COUNT(*)

```sql
COUNT(*)
```

Counts department assignments per employee.

---

## 4️⃣ HAVING

```sql
HAVING COUNT(*) = 1
```

Keeps employees belonging to exactly one department.

---

## 5️⃣ UNION

```sql
UNION
```

Combines results while removing duplicates.

---

# 🧪 Example Walkthrough

### Input

| employee_id | department_id | primary_flag |
|------------|--------------|--------------|
| 1 | 5 | N |
| 2 | 7 | Y |
| 2 | 8 | N |
| 3 | 4 | N |

---

### Query 1

```sql
WHERE primary_flag='Y'
```

Result:

| employee_id | department_id |
|------------|--------------|
| 2 | 7 |

---

### Query 2

Employees with one department:

| employee_id | department_id |
|------------|--------------|
| 1 | 5 |
| 3 | 4 |

---

### UNION

| employee_id | department_id |
|------------|--------------|
| 1 | 5 |
| 2 | 7 |
| 3 | 4 |

---

# ⚠️ Common Mistake

Wrong:

```sql
SELECT employee_id, department_id
FROM Employee
WHERE primary_flag = 'Y';
```

This misses employees who belong to:

```text
only one department
```

and have:

```text
primary_flag = 'N'
```

---

# 🚀 Alternative Solution (Single Query)

A very elegant solution:

```sql
SELECT
    employee_id,
    department_id
FROM Employee
WHERE primary_flag = 'Y'
   OR employee_id IN (
        SELECT employee_id
        FROM Employee
        GROUP BY employee_id
        HAVING COUNT(*) = 1
   );
```

---

# 🚀 Even Better Solution (Window Function)

```sql
SELECT
    employee_id,
    department_id
FROM (
    SELECT *,
           COUNT(*) OVER(
               PARTITION BY employee_id
           ) AS dept_count
    FROM Employee
) e
WHERE dept_count = 1
   OR primary_flag = 'Y';
```

---

# ⏱️ Complexity Analysis

### Time Complexity

```text
O(n)
```

Where:

```text
n = number of rows
```

---

### Space Complexity

```text
O(k)
```

Where:

```text
k = number of employees
```

used during grouping.

---

# 🚀 Interview Pattern

This problem combines two common SQL ideas:

```text
Conditional Filtering
+
Grouping
```

Frequently seen in:

- Primary address selection
- Default payment method selection
- Main account identification
- Preferred category selection

---

# 🚀 Final Takeaway

Core idea:

```text
Return the primary department if it exists.
Otherwise, if the employee belongs to only one department,
return that department.
```

Pattern:

```sql
WHERE condition
UNION
GROUP BY + HAVING
```