# LeetCode SQL 50 Solutions

> A comprehensive collection of 50 LeetCode-style SQL problems with clean, canonical solutions and detailed explanations.

[![GitHub](https://img.shields.io/badge/GitHub-JayeshD911%2Fleetcode--sql--50-blue?logo=github)](https://github.com/JayeshD911/leetcode-sql-50)
![Problems](https://img.shields.io/badge/Problems-50-brightgreen)
![License](https://img.shields.io/badge/License-MIT-green)

## 📚 Overview

This repository contains a curated collection of **50 SQL problems** commonly found on LeetCode and in SQL interview questions. Each problem includes:

- **MySolution.sql** — A clean, canonical SQL solution 
- **Problem.md** — Complete problem description, table schema, approach explanation, and complexity analysis

The solutions are designed for learning SQL concepts, preparing for technical interviews, and understanding best practices in query optimization.

## 🎯 Problem Categories

The 50 problems cover various SQL topics:

- **Basic Queries** — SELECT, WHERE, ORDER BY, LIMIT
- **Filtering & Conditional Logic** — CASE WHEN, IN, BETWEEN, regex
- **Aggregation** — COUNT, SUM, AVG, MAX, MIN, GROUP BY, HAVING
- **Joins** — INNER JOIN, LEFT JOIN, CROSS JOIN
- **Subqueries** — Correlated subqueries, IN clauses, EXISTS
- **Window Functions** — ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD
- **Advanced Techniques** — CTEs, Self-joins, Complex aggregations

### Complete Problem List

| # | Problem | Difficulty | Topic |
|---|---------|-----------|-------|
| 1 | Article Views I | Easy | Aggregation |
| 2 | Average Selling Price | Easy | JOIN, Aggregation |
| 3 | Average Time of Process per Machine | Easy | Window Functions |
| 4 | Big Countries | Easy | WHERE, OR |
| 5 | Biggest Single Number | Medium | Subquery |
| 6 | Classes With at Least 5 Students | Easy | GROUP BY, HAVING |
| 7 | Confirmation Rate | Easy | JOIN, Aggregation |
| 8 | Consecutive Numbers | Medium | Self-join, DISTINCT |
| 9 | Count Salary Categories | Easy | CASE WHEN |
| 10 | Customer Who Visited but Did Not Make Any Transactions | Easy | LEFT JOIN |
| 11 | Customers Who Bought All Products | Medium | GROUP BY, HAVING, COUNT |
| 12 | Delete Duplicate Emails | Easy | DELETE, Window Functions |
| 13 | Department Top Three Salaries | Hard | Window Functions, RANK |
| 14 | Employee Bonus | Easy | LEFT JOIN, IFNULL |
| 15 | Employees Whose Manager Left the Company | Easy | Self-join |
| 16 | Exchange Seats | Medium | CASE WHEN, ODD/EVEN |
| 17 | Find Customer Referee | Easy | WHERE, NULL |
| 18 | Find Followers Count | Easy | GROUP BY, Aggregation |
| 19 | Find Users With Valid E-Mails | Easy | REGEXP |
| 20 | Fix Names in a Table | Easy | String Functions |
| 21 | Friend Requests II - Who Has the Most Friends | Medium | UNION, Self-join |
| 22 | Game Play Analysis IV | Medium | Window Functions, DATE |
| 23 | Group Sold Products By The Date | Easy | GROUP_CONCAT |
| 24 | Immediate Food Delivery II | Medium | Subquery, Boolean Logic |
| 25 | Invalid Tweets | Easy | String Functions, LENGTH |
| 26 | Investments in 2016 | Medium | Subquery, JOIN |
| 27 | Last Person to Fit in the Bus | Medium | Cumulative SUM |
| 28 | List the Products Ordered in a Period | Easy | WHERE, IN |
| 29 | Managers with at Least 5 Direct Reports | Easy | GROUP BY, HAVING |
| 30 | Monthly Transactions I | Easy | Date Functions, CASE |
| 31 | Movie Rating | Medium | MAX, UNION |
| 32 | Not Boring Movies | Easy | WHERE, MOD |
| 33 | Number of Unique Subjects Taught by Each Teacher | Easy | GROUP BY, COUNT(DISTINCT) |
| 34 | Patients With a Condition | Easy | REGEXP, LIKE |
| 35 | Percentage of Users Attended a Contest | Medium | Aggregation, Math |
| 36 | Primary Department for Each Employee | Medium | Window Functions, ROW_NUMBER |
| 37 | Product Price at a Given Date | Medium | Window Functions, Dates |
| 38 | Product Sales Analysis I | Easy | JOIN, GROUP BY |
| 39 | Product Sales Analysis III | Medium | Window Functions, Dates |
| 40 | Project Employees I | Easy | JOIN, Aggregation |
| 41 | Queries Quality and Percentage | Easy | CASE WHEN, Math |
| 42 | Recyclable and Low Fat Products | Easy | WHERE, AND |
| 43 | Replace Employee ID With The Unique Identifier | Easy | LEFT JOIN |
| 44 | Restaurant Growth | Hard | Window Functions, SUM |
| 45 | Rising Temperature | Easy | Self-join, DATE |
| 46 | Second Highest Salary | Easy | Subquery, OFFSET |
| 47 | Students and Examinations | Easy | CROSS JOIN, GROUP BY |
| 48 | The Number of Employees Which Report to Each Employee | Easy | Aggregation, Self-join |
| 49 | Triangle Judgement | Easy | CASE WHEN |
| 50 | User Activity for the Past 30 Days I | Easy | Date Functions, COUNT |

## 📁 Repository Structure

```
leetcode-sql-50/
├── README.md                                    # This file
├── AGENTS.md                                    # Guidance for automated agents
├── Big Countries/
│   ├── MySolution.sql                           # The SQL solution
│   └── Problem.md                               # Problem statement & explanation
├── Immediate Food Delivery II/
│   ├── MySolution.sql
│   └── Problem.md
├── [48 more problem directories...]
└── .git/                                        # Git repository metadata
```

## 🚀 Getting Started

### 1. **Browse Problems**

Navigate to any problem folder and open `Problem.md` to read:
- Problem statement
- Table schemas
- Example input/output
- Step-by-step approach
- Complexity analysis

### 2. **View Solutions**

Each problem has a `MySolution.sql` file containing the query:

```sql
-- Example: Big Countries (MySolution.sql)
select name, population, area
from World
where area >= 3000000 or population >= 25000000;
```

### 3. **Test on LeetCode**

- Go to the LeetCode problem (link in Problem.md)
- Copy the query from `MySolution.sql`
- Paste into LeetCode's SQL editor
- Run and verify

### 4. **Test Locally**

For local testing with MySQL:

```bash
mysql -u root -p -e "
  CREATE DATABASE leetcode_sql;
  USE leetcode_sql;
  -- Copy table schema from Problem.md
  -- Paste MySolution.sql query
"
```

## 💡 Key Concepts Covered

### Data Retrieval
- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`
- Column aliases and expressions

### Aggregation & Grouping
- `COUNT()`, `SUM()`, `AVG()`, `MAX()`, `MIN()`
- `GROUP BY`, `HAVING`
- `GROUP_CONCAT()`

### Joining Tables
- `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `CROSS JOIN`
- Self-joins
- Multiple joins in single query

### Subqueries & CTEs
- Correlated subqueries
- Subqueries in SELECT, WHERE, FROM
- `IN`, `EXISTS` clauses
- Common Table Expressions (CTEs) with `WITH`

### Window Functions
- `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`
- `LAG()`, `LEAD()`
- `SUM() OVER`, `AVG() OVER`
- Partition and ordering

### String & Date Functions
- `CONCAT()`, `SUBSTRING()`, `UPPER()`, `LOWER()`
- `DATE()`, `DATE_ADD()`, `DATEDIFF()`
- `REGEXP`, `LIKE` for pattern matching

### Advanced Techniques
- `CASE WHEN` for conditional logic
- `DISTINCT` for deduplication
- `UNION` for combining result sets
- Boolean logic and NULL handling

## 🔍 SQL Dialect Notes

### MySQL/LeetCode Compatibility

Most solutions are written for **MySQL** (LeetCode's default SQL environment). Key differences:

**Boolean to Integer Coercion:**
```sql
-- MySQL (automatic coercion)
select round(avg(order_date = customer_pref_delivery_date) * 100, 2) as percentage;

-- Portable (explicit)
select round(avg(case when order_date = customer_pref_delivery_date then 1 else 0 end) * 100, 2) as percentage;
```

### Adapting for Other SQL Engines

| Feature | MySQL | PostgreSQL | SQLite | SQL Server |
|---------|-------|-----------|--------|------------|
| Boolean coercion | ✅ | ❌ Use CASE | ❌ Use CASE | ❌ Use CASE |
| GROUP_CONCAT | ✅ | string_agg() | group_concat() | string_agg() |
| Window Functions | ✅ | ✅ | ✅ | ✅ |
| CTEs | ✅ | ✅ | ✅ | ✅ |
| Date Functions | DATE_ADD | + interval | date() | DATEADD |
| REGEXP | ✅ | ✅ | ⚠️ Limited | ❌ |

## 📋 Conventions

### File Organization

- **MySolution.sql** — Contains exactly one SELECT statement, ends with semicolon, lowercase keywords
- **Problem.md** — Authoritative source for problem details, schema, and explanation

### Coding Style

Solutions follow these conventions for consistency:

1. **Lowercase keywords** — `select`, `where`, `from`, `join`
2. **Readable formatting** — Proper indentation, one clause per line when complex
3. **Clear aliases** — Meaningful column and table aliases
4. **Efficient queries** — Optimized joins, proper indexing considerations

### Example Style

```sql
-- Good ✅
select 
  u.user_id,
  u.user_name,
  count(a.activity_id) as activity_count
from users u
left join activities a on u.user_id = a.user_id
where u.status = 'active'
group by u.user_id, u.user_name
having count(a.activity_id) > 5
order by activity_count desc;

-- Avoid ❌
SELECT U.USER_ID, U.USER_NAME, COUNT(*) FROM USERS U, ACTIVITIES A WHERE U.USER_ID = A.USER_ID;
```

## 🛠️ Contributing

Contributions are welcome! Here's how to contribute:

### Making Changes

1. **Select a problem** to improve or fix
2. **Read `Problem.md`** to understand the schema and requirements
3. **Edit `MySolution.sql`** with your improved query
4. **Test locally** or on LeetCode to verify correctness
5. **Commit with clear message:**
   ```bash
   git commit -m "Improve Big Countries/MySolution.sql — optimize WHERE clause"
   ```

### Contribution Guidelines

- ✅ Update `MySolution.sql` with optimized or correct queries
- ✅ Improve `Problem.md` explanations if needed
- ✅ Add complexity analysis if missing
- ❌ Don't rename files or change directory structure
- ❌ Don't add test harnesses or CI pipelines
- ❌ Don't introduce external dependencies

## 🔗 Related Resources

- **[LeetCode Database Problems](https://leetcode.com/studyplan/top-sql-50/)** — Original problem source
- **[SQL Documentation](https://dev.mysql.com/doc/)** — MySQL reference
- **[Mode Analytics SQL Tutorial](https://mode.com/sql-tutorial/)** — Interactive SQL learning
- **[Window Functions Guide](https://www.postgresql.org/docs/current/functions-window.html)** — Advanced concepts

## 📈 Problem Statistics

- **Total Problems:** 50
- **Difficulty Distribution:**
  - Easy: ~70%
  - Medium: ~20%
  - Hard: ~10%

- **SQL Concepts Frequency:**
  - SELECT/WHERE/FROM: 100%
  - JOIN: 60%
  - GROUP BY/Aggregation: 70%
  - Subqueries: 40%
  - Window Functions: 30%
  - String/Date Functions: 35%

## 💬 FAQ

**Q: Can I use these solutions for LeetCode?**  
A: Yes! These are official LeetCode problems. Use these solutions as reference after attempting the problem yourself.

**Q: Are these solutions optimal?**  
A: Solutions are designed to be correct, readable, and reasonably optimized. There may be multiple valid approaches.

**Q: Can I contribute new solutions?**  
A: Currently, this repo contains only LeetCode's official 50 Database problems. Additional problems are out of scope.

**Q: Why lowercase SQL?**  
A: It's a style choice for readability and consistency. Both uppercase and lowercase are valid.

**Q: Which SQL version should I target?**  
A: MySQL 5.7+ (LeetCode standard). Solutions will include notes if compatibility is needed.

## 📄 License

This repository contains solutions to LeetCode problems. Problem statements and examples remain LeetCode's intellectual property. SQL solutions and explanations are provided for educational purposes.


## 👨‍💻 Author

- **Jayesh D** — [GitHub](https://github.com/JayeshD911)

## 🙋‍♂️ Support

- Found a bug in a solution? Open an issue
- Have a better approach? Submit a pull request
- Questions? Check the problem's `Problem.md` first

---

**Last Updated:** July 2026  
**Total Commits:** Check git log  
**Repository:** [JayeshD911/leetcode-sql-50](https://github.com/JayeshD911/leetcode-sql-50)

