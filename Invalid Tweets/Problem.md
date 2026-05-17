# Invalid Tweets

🔗 Problem Link: :contentReference[oaicite:0]{index=0}

---

## 📘 Problem Statement

Write an SQL query to find the IDs of the invalid tweets.

A tweet is considered invalid if the number of characters used in the content exceeds **15 characters**.

Return the result table in any order.

---

## 🧠 Approach

We need to:
- Check the length of each tweet's `content`
- Return the `tweet_id` where content length > 15

### ✅ SQL Functions Used
- `LENGTH()` → returns the number of characters in a string

---

## ✅ SQL Query

```sql
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;
```

---------------------

## 🔍 Example

### Input

| tweet_id | content                           |
|----------|-----------------------------------|
| 1        | Vote for Biden                   |
| 2        | Let us Code                      |
| 3        | More than fifteen chars          |

### Evaluation

- `"Vote for Biden"` → 15 chars ✅ valid
- `"Let us Code"` → 11 chars ✅ valid
- `"More than fifteen chars"` → > 15 chars ❌ invalid

### Output

| tweet_id |
|----------|
| 3        |

---

## ⏱️ Complexity Analysis

### Time Complexity
```text
O(n)
```

We scan each row once.

### Space Complexity
```text
O(1)
```

No extra space used.

---

## 🎯 Key SQL Insight

```sql
LENGTH(column_name)
```

returns the number of characters in the string.

Example:

```sql
SELECT LENGTH('Hello');
```

Output:
```text
5
```

---

## 🚀 Final Takeaway

This problem is a simple filtering problem using:
- `WHERE`
- `LENGTH()`

Very common beginner SQL pattern.

```sql
WHERE LENGTH(column) > value
```