# The Number of Employees Which Report to Each Employee

🔗 Problem Link: https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/

---

# 📘 Problem Statement

Write an SQL query to report for every employee who has at least one direct report:

- `employee_id`
- `name`
- number of employees reporting directly to them (`reports_count`)
- average age of those direct reports (`average_age`)

The average age should be:

```text
rounded down to the nearest integer
```

Return the result ordered by:

```text
employee_id
```

---

# 🧠 Intuition

The table contains both:

```text
employees
and
their managers
```

using:

```text
reports_to
```

If:

| employee_id | reports_to |
|------------|------------|
| 2 | 1 |

Then:

```text
Employee 2 reports to Employee 1
```

To solve:

1. Self-join Employees table.
2. Match manager with employees reporting to them.
3. Count direct reports.
4. Compute average age.
5. Group by manager.

👉 This is a classic:

```text
Self Join + GROUP BY
```

problem.

---

# 🔍 Table

## `Employees`

| Column Name | Type |
|-------------|------|
| employee_id | int |
| name        | varchar |
| reports_to  | int |
| age         | int |

---

# Example

### Employees

| employee_id | name | reports_to | age |
|------------|------|------------|-----|
| 1 | Boss | NULL | 45 |
| 2 | Alice | 1 | 25 |
| 3 | Bob | 1 | 30 |
| 4 | Charlie | 1 | 35 |

---

Hierarchy:

```text
Boss
 ├── Alice
 ├── Bob
 └── Charlie
```

---

# ✅ SQL Query

```sql
SELECT
    e.employee_id,
    e.name,
    COUNT(r.employee_id) AS reports_count,
    ROUND(AVG(r.age), 0) AS average_age
FROM Employees e
JOIN Employees r
ON e.employee_id = r.reports_to
GROUP BY e.employee_id, e.name
ORDER BY e.employee_id;
```

---------------------

# 🔍 Step-by-Step Explanation

---

## 1️⃣ Self Join the Employees Table

```sql
FROM Employees e
JOIN Employees r
ON e.employee_id = r.reports_to
```

Think of:

```text
e = manager
r = reporting employee
```

---

### Example

Employees:

| employee_id | name | reports_to |
|------------|------|------------|
| 1 | Boss | NULL |
| 2 | Alice | 1 |
| 3 | Bob | 1 |

Join Result:

| manager | report |
|----------|--------|
| Boss | Alice |
| Boss | Bob |

---

## 2️⃣ Count Direct Reports

```sql
COUNT(r.employee_id)
```

Counts reporting employees.

---

### Example

Boss:

```text
Alice
Bob
Charlie
```

Count:

```text
3
```

---

## 3️⃣ Compute Average Age

```sql
AVG(r.age)
```

Suppose:

| Employee | Age |
|----------|-----|
| Alice | 25 |
| Bob | 30 |
| Charlie | 35 |

Average:

```text
(25 + 30 + 35) / 3
=
30
```

---

## 4️⃣ Round the Average

```sql
ROUND(AVG(r.age), 0)
```

Example:

```text
29.67 → 30
```

---

## 5️⃣ Group by Manager

```sql
GROUP BY e.employee_id, e.name
```

Creates one result row per manager.

---

# 🧪 Example Walkthrough

### Employees

| employee_id | name | reports_to | age |
|------------|------|------------|-----|
| 1 | Boss | NULL | 50 |
| 2 | Alice | 1 | 20 |
| 3 | Bob | 1 | 30 |
| 4 | Carol | 2 | 40 |

---

### Self Join Result

| Manager | Employee |
|----------|----------|
| Boss | Alice |
| Boss | Bob |
| Alice | Carol |

---

### Aggregation

#### Boss

Employees:

```text
Alice (20)
Bob (30)
```

Count:

```text
2
```

Average Age:

```text
(20 + 30)/2 = 25
```

---

#### Alice

Employees:

```text
Carol (40)
```

Count:

```text
1
```

Average Age:

```text
40
```

---

### Output

| employee_id | name | reports_count | average_age |
|------------|------|--------------|-------------|
| 1 | Boss | 2 | 25 |
| 2 | Alice | 1 | 40 |

---

# 🎯 Important SQL Concepts Used

---

## 1️⃣ Self Join

Joining a table with itself.

```sql
Employees e
JOIN Employees r
```

Used to represent:

```text
Manager ↔ Employee
```

relationships.

---

## 2️⃣ GROUP BY

```sql
GROUP BY e.employee_id, e.name
```

Creates one group per manager.

---

## 3️⃣ COUNT()

```sql
COUNT(r.employee_id)
```

Counts direct reports.

---

## 4️⃣ AVG()

```sql
AVG(r.age)
```

Computes average age.

---

## 5️⃣ ROUND()

```sql
ROUND(AVG(r.age), 0)
```

Rounds average age to nearest integer.

---

# ⚠️ Common Mistake

Wrong:

```sql
COUNT(*)
```

after using a LEFT JOIN.

This may count manager rows even when no reports exist.

Using:

```sql
COUNT(r.employee_id)
```

counts only actual reporting employees.

---

# 🚀 Why Self Join Works

Suppose:

| employee_id | reports_to |
|------------|------------|
| 2 | 1 |
| 3 | 1 |

Meaning:

```text
2 reports to 1
3 reports to 1
```

The join:

```sql
e.employee_id = r.reports_to
```

transforms hierarchical data into tabular data suitable for aggregation.

---

# ⏱️ Complexity Analysis

### Time Complexity

```text
O(n)
```

with indexing on:

```sql
reports_to
```

Otherwise closer to:

```text
O(n²)
```

for the join.

---

### Space Complexity

```text
O(k)
```

where:

```text
k = number of managers
```

---

# 🚀 Interview Pattern

This problem teaches one of the most important SQL patterns:

```text
Self Join
+
Aggregation
```

Common examples:

- Employee → Manager hierarchy
- Organization charts
- Category → Parent Category
- Social network relationships

---

# 🚀 Final Takeaway

Core idea:

```text
Join managers with their direct reports,
then aggregate the reporting employees.
```

Pattern:

```sql
Self Join
+
GROUP BY
+
COUNT()
+
AVG()
```