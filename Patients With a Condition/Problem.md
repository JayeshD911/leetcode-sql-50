# 1527. Patients With a Condition

## Problem Statement

Table: `Patients`

| Column Name | Type |
|------------|------|
| patient_id | int |
| patient_name | varchar |
| conditions | varchar |

- `patient_id` is the primary key.
- `conditions` contains **zero or more medical condition codes** separated by spaces.

Find all patients whose list of conditions contains the condition:

```text
DIAB1
```

A patient qualifies if:

- `DIAB1` appears as a **complete condition code**.
- It may appear at the **beginning**, **middle**, or **end** of the string.

Return the result table in any order.

---

## Example

### Input

**Patients**

| patient_id | patient_name | conditions |
|------------|--------------|------------|
| 1 | Daniel | YFEV COUGH |
| 2 | Alice | DIAB100 MYOP |
| 3 | Bob | ACNE DIAB100 |
| 4 | George | ACNE DIAB1 |
| 5 | Alain | DIAB1 |

---

### Output

| patient_id | patient_name | conditions |
|------------|--------------|------------|
| 4 | George | ACNE DIAB1 |
| 5 | Alain | DIAB1 |

---

## Explanation

We need patients whose condition list contains the **exact code**:

```text
DIAB1
```

### Patient 1

```text
YFEV COUGH
```

No `DIAB1`.

❌ Exclude.

---

### Patient 2

```text
DIAB100 MYOP
```

Contains:

```text
DIAB100
```

This is **not** the same as `DIAB1`.

❌ Exclude.

---

### Patient 3

```text
ACNE DIAB100
```

Again contains:

```text
DIAB100
```

Not a match.

❌ Exclude.

---

### Patient 4

```text
ACNE DIAB1
```

Contains the exact code:

```text
DIAB1
```

✅ Include.

---

### Patient 5

```text
DIAB1
```

Exact match.

✅ Include.

---

## Approach (Most Optimal)

Since condition codes are separated by spaces, we must match `DIAB1` as a **whole word**.

A regular expression is the cleanest solution.

Pattern:

```text
(^| )DIAB1($| )
```

Meaning:

- Start of string **or** space before `DIAB1`
- End of string **or** space after `DIAB1`

This ensures we match only the complete condition code.

---

## Why this works

Consider:

```text
DIAB1
```

Matches because it is the entire string.

---

Consider:

```text
ACNE DIAB1
```

Matches because `DIAB1` is preceded by a space.

---

Consider:

```text
DIAB1 COUGH
```

Matches because `DIAB1` is followed by a space.

---

Consider:

```text
DIAB100
```

Does **not** match because `DIAB1` is part of a larger word.

---

## Optimal MySQL Solution

```sql
SELECT *
FROM Patients
WHERE conditions REGEXP '(^| )DIAB1($| )';
```

---

## Dry Run

Input:

| conditions |
|------------|
| DIAB100 MYOP |
| ACNE DIAB1 |
| DIAB1 |
| ACNE DIAB100 |

Regex evaluation:

```text
DIAB100 MYOP      ❌
ACNE DIAB1        ✅
DIAB1             ✅
ACNE DIAB100      ❌
```

Output:

| patient_id |
|------------|
| 4 |
| 5 |

---

## Complexity Analysis

### Time Complexity

```text
O(n × m)
```

- `n` = number of rows
- `m` = average length of the condition string

Each string is scanned once by the regex engine.

### Space Complexity

```text
O(1)
```

No extra storage is used.

---

## Key SQL Concepts Used

- `REGEXP`
- Pattern Matching
- String Processing
- Word Boundary Logic

---

## Alternative Solution (Without REGEXP)

We can use `LIKE` to cover all possible positions:

```sql
SELECT *
FROM Patients
WHERE conditions = 'DIAB1'
   OR conditions LIKE 'DIAB1 %'
   OR conditions LIKE '% DIAB1'
   OR conditions LIKE '% DIAB1 %';
```

Although correct, it is longer and harder to maintain than the regex solution.

---

## Interview Follow-up

### Why not use:

```sql
WHERE conditions LIKE '%DIAB1%'
```

Because it matches partial words.

Example:

```text
DIAB100
```

The pattern:

```sql
'%DIAB1%'
```

incorrectly returns:

```text
DIAB100
```

which is **not** the required condition.

The regex:

```sql
(^| )DIAB1($| )
```

ensures `DIAB1` is matched only as a **complete condition code**, making it the preferred interview solution.