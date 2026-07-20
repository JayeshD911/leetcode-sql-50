# 1517. Find Users With Valid E-Mails

## Problem Statement

Table: `Users`

| Column Name | Type |
|------------|------|
| user_id | int |
| name | varchar |
| mail | varchar |

- `user_id` is the primary key.
- Each row contains a user's email address.

A valid email must satisfy **all** of the following rules:

1. It starts with a **letter** (`a-z` or `A-Z`).
2. The part before `@leetcode.com` may contain only:
    - Letters (`a-z`, `A-Z`)
    - Digits (`0-9`)
    - Underscore (`_`)
    - Period (`.`)
    - Hyphen (`-`)
3. The email domain must be exactly:

```text
@leetcode.com
```

Return all users with valid email addresses.

Return the result table in any order.

---

## Example

### Input

**Users**

| user_id | name | mail |
|---------|------|----------------------|
| 1 | Winston | winston@leetcode.com |
| 2 | Jonathan | jonathanisgreat |
| 3 | Annabelle | bella-@leetcode.com |
| 4 | Sally | sally.come@leetcode.com |
| 5 | Marwan | quarz#2020@leetcode.com |

---

### Output

| user_id | name | mail |
|---------|------|----------------------|
| 1 | Winston | winston@leetcode.com |
| 3 | Annabelle | bella-@leetcode.com |
| 4 | Sally | sally.come@leetcode.com |

---

## Explanation

A valid email must follow the required pattern.

### Winston

```text
winston@leetcode.com
```

- Starts with a letter ✅
- Contains only valid characters ✅
- Ends with `@leetcode.com` ✅

Included.

---

### Jonathan

```text
jonathanisgreat
```

Missing the required domain.

❌ Excluded.

---

### Annabelle

```text
bella-@leetcode.com
```

- Starts with a letter ✅
- Hyphen is allowed ✅
- Valid domain ✅

Included.

---

### Sally

```text
sally.come@leetcode.com
```

- Starts with a letter ✅
- Period is allowed ✅
- Valid domain ✅

Included.

---

### Marwan

```text
quarz#2020@leetcode.com
```

Contains:

```text
#
```

which is **not** an allowed character.

❌ Excluded.

---

## Approach (Most Optimal)

This problem is best solved using a **regular expression (`REGEXP`)**.

The required pattern is:

```text
^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\.com$
```

Let's break it down:

| Regex Part | Meaning |
|------------|---------|
| `^` | Start of the string |
| `[a-zA-Z]` | First character must be a letter |
| `[a-zA-Z0-9_.-]*` | Zero or more allowed characters |
| `@leetcode\.com` | Exact domain (`.` is escaped) |
| `$` | End of the string |

This ensures the entire email matches the required format.

---

## Why this works

Consider:

```text
abc_123@leetcode.com
```

Matches because:

- Starts with a letter
- Contains only valid characters
- Ends with the correct domain

---

Consider:

```text
1abc@leetcode.com
```

Fails because the first character is a digit.

---

Consider:

```text
abc#12@leetcode.com
```

Fails because `#` is not an allowed character.

---

Consider:

```text
abc@leetcode.co
```

Fails because the domain is not exactly:

```text
leetcode.com
```

---

## Optimal MySQL Solution

```sql
SELECT
    user_id,
    name,
    mail
FROM Users
WHERE mail REGEXP '^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\\.com$';
```

---

## Dry Run

Input:

| Email | Valid? |
|-------|--------|
| winston@leetcode.com | ✅ |
| 1abc@leetcode.com | ❌ |
| abc#12@leetcode.com | ❌ |
| bella-@leetcode.com | ✅ |
| sally.come@leetcode.com | ✅ |

Returned rows:

```text
Winston
Annabelle
Sally
```

---

## Complexity Analysis

### Time Complexity

```text
O(n × m)
```

- `n` = number of users
- `m` = average email length

Each email is checked once against the regular expression.

### Space Complexity

```text
O(1)
```

No additional storage is required.

---

## Key SQL Concepts Used

- `REGEXP`
- Character Classes
- Anchors (`^`, `$`)
- Escaping Special Characters
- Pattern Matching

---

## Alternative Solution

Without `REGEXP`, the query becomes lengthy because you would need multiple string checks using functions such as:

- `LIKE`
- `SUBSTRING()`
- `LEFT()`
- `RIGHT()`
- `LOCATE()`

However, validating the allowed characters without regular expressions is cumbersome and error-prone.

Using `REGEXP` is the cleanest and most efficient solution.

---

## Interview Follow-up

### Why escape the period (`.`)?

In regular expressions:

```text
.
```

means **any single character**.

So this pattern:

```text
@leetcode.com
```

would also match:

```text
@leetcodeXcom
@leetcode-com
@leetcode?com
```

To match a literal dot, escape it:

```sql
@leetcode\\.com
```

This ensures only:

```text
@leetcode.com
```

is accepted.

---

### Common Mistakes

#### 1. Using:

```sql
LIKE '%@leetcode.com'
```

This incorrectly accepts:

```text
1abc@leetcode.com
abc#@leetcode.com
```

because it only checks the ending.

---

#### 2. Forgetting `^` and `$`

Without:

```text
^
```

and

```text
$
```

the regex may match only part of a string instead of validating the **entire email address**.

---

#### 3. Not escaping the period

Using:

```sql
@leetcode.com
```

instead of:

```sql
@leetcode\\.com
```

allows invalid domains such as:

```text
@leetcodeXcom
```

The final regex:

```sql
^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\\.com$
```

correctly enforces **all** the problem's rules.