# Replace Employee ID With The Unique Identifier

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

## 📘 Problem Statement

Write an SQL query to show the unique ID of each user.

If a user does not have a unique ID, show `NULL` instead.

Return the result table in any order.

---

## 🧠 Approach

We have two tables:

### `Employees`

| Column Name | Type |
|------------|------|
| id         | int  |
| name       | varchar |

### `EmployeeUNI`

| Column Name | Type |
|------------|------|
| id         | int  |
| unique_id  | int  |

We need:
- all employees
- matching `unique_id` if available
- otherwise `NULL`

👉 This is a classic **LEFT JOIN** problem.

---

## ✅ SQL Query

```sql
SELECT 
    eu.unique_id,
    e.name
FROM Employees e
LEFT JOIN EmployeeUNI eu
ON e.id = eu.id;
```

---------------------

## 🔍 Why LEFT JOIN?

### Important Insight

We must include:
- employees WITH unique IDs ✅
- employees WITHOUT unique IDs ✅

If we used `INNER JOIN`:
- employees without matches would disappear ❌

`LEFT JOIN` keeps all rows from the left table (`Employees`).

---

## 🧪 Example

### Employees

| id | name  |
|----|------|
| 1  | Alice |
| 7  | Bob   |
| 11 | Meir  |
| 90 | Winston |
| 3  | Jonathan |

### EmployeeUNI

| id | unique_id |
|----|-----------|
| 3  | 1         |
| 11 | 2         |
| 90 | 3         |

---

## 🔄 Join Matching

```text
Employees.id = EmployeeUNI.id
```

### Matches:
- 3 → 1
- 11 → 2
- 90 → 3

### No Match:
- 1 (Alice)
- 7 (Bob)

---

## ✅ Output

| unique_id | name |
|-----------|------|
| NULL      | Alice |
| NULL      | Bob |
| 2         | Meir |
| 3         | Winston |
| 1         | Jonathan |

---

## ⏱️ Complexity Analysis

### Time Complexity
```text
O(n + m)
```

Where:
- `n` = Employees rows
- `m` = EmployeeUNI rows

(assuming indexed joins)

---

### Space Complexity
```text
O(1)
```

No extra space used.

---

## 🎯 Key SQL Concepts Used

### LEFT JOIN

```sql
LEFT JOIN table2
ON condition
```

Returns:
- all rows from left table
- matched rows from right table
- `NULL` if no match

---

## 🚀 Final Takeaway

This problem teaches:
- how joins work
- when to use `LEFT JOIN`
- how missing relationships are handled using `NULL`

Classic interview pattern:

```sql
LEFT JOIN + unmatched rows
```