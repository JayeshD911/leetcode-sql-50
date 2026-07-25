# AGENTS.md — Guidance for AI coding agents

Checklist for this run:
- Understand repository layout (problem folders with `MySolution.sql` + `Problem.md`)
- Follow project naming and SQL conventions (lowercase queries, file names)
- Prefer non-destructive edits: update `MySolution.sql`; leave `Problem.md` unless improving explanation
- Be careful with SQL dialect portability (repo uses MySQL/LeetCode boolean-to-int idioms)

Repository overview
- This repo is a collection of individual LeetCode-style SQL problems. Each problem lives in its own directory (example: `Immediate Food Delivery II/`).
- Typical directory contents:
  - `MySolution.sql` — the canonical SQL answer for that problem (single query file)
  - `Problem.md` — problem statement, table schema, and explanation

Key patterns and conventions (discoverable in the codebase)
- File naming: always use `MySolution.sql` for the solution query in each problem folder. Do not rename existing files; add new solutions by creating or updating `MySolution.sql` in the specific problem folder.
- Markdown: `Problem.md` contains the problem text and the table schema. These are authoritative and used in explanation sections.
- SQL style: queries in `MySolution.sql` are typically written in lowercase and rely on LeetCode/MySQL behaviors. Examples:
  - `select round(avg(order_date = customer_pref_delivery_date) * 100, 2) as immediate_percentage` (see `Immediate Food Delivery II/MySolution.sql`)
  - `select name, population, area from World where area >= 3000000 or population >= 25000000;` (see `Big Countries/MySolution.sql`)

Dialect and portability notes
- The repository commonly relies on MySQL/LeetCode truthiness where boolean expressions evaluate to 1/0 (so `avg(condition)` works). When making changes intended to be portable to other SQL engines, convert boolean expressions to explicit numeric values, e.g.:

  - Non-portable idiom used in repo:

    select round(avg(order_date = customer_pref_delivery_date) * 100, 2) as immediate_percentage

  - Portable equivalent (explicit):

    select round(avg(case when order_date = customer_pref_delivery_date then 1 else 0 end) * 100, 2) as immediate_percentage

- Use `case when ... then ... else ... end` when you need cross-database compatibility.

Editing rules for agents
- Minimal, focused changes: update only the files required for the task. For a solution change, edit `MySolution.sql` only. If you must update the explanation, modify `Problem.md` in the same folder and document why.
- Preserve the single-query-per-file pattern: `MySolution.sql` should contain the final answer query only (no extraneous test harness or binary files).
- Respect folder names: many folders have spaces (e.g., `Immediate Food Delivery II`). When running shell commands refer to them with quotes on Windows PowerShell.

Testing and validation guidance
- There is no CI or test harness included. Typical validation approaches:
  - Run the query on LeetCode's web editor for the problem (primary, authoritative environment).
  - For local testing, use a MySQL instance or a compatible engine. Convert boolean-to-int expressions to `case when` for engines that do not coerce booleans to integers.
- Quick PowerShell hint (escaping folder names):

  sqlite3 "C:\path\to\db.sqlite" ".read 'C:\path\to\Immediate Food Delivery II\MySolution.sql'"

  (This is only a convenience example — local testing requires creating the appropriate schema and data.)

Cross-cutting notes and patterns
- Explanations in `Problem.md` often include the table schema and step-by-step SQL reasoning. Use these as the primary source of truth when refactoring or optimizing queries.
- Avoid changing the problem statement files unless you are clarifying or correcting the original text. If you modify `Problem.md`, add a short note in the file documenting the change.
- The repository assumes LeetCode-style single-query solutions. Do not add stored procedures, scripts, or multi-file test harnesses to replace `MySolution.sql` unless the task explicitly requires them.

Where to look first (key files/directories)
- Root README: `README.md` — minimal project title.
- Example problem folders:
  - `Immediate Food Delivery II/Problem.md` and `.../MySolution.sql` (shows boolean-to-int usage and rounding patterns)
  - `Big Countries/MySolution.sql` (simple selection/filtering pattern)

If you are an automated agent making edits
- Run lightweight static checks: ensure `MySolution.sql` ends with a semicolon and contains a single SELECT query.
- Do not introduce external dependencies or new build steps. This repo is content-oriented, not an application.

Contact / Manual verification
- To validate changes, open the modified `MySolution.sql` in a SQL client or use LeetCode's interface for the specific problem. Mention in your PR description which problem folder you changed and include a short rationale.

EOF

