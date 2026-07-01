-- SKIPPED
WITH daily AS (
    SELECT
        visited_on,
        SUM(amount) AS daily_amount
    FROM Customer
    GROUP BY visited_on
),
     Sum7D AS (
         SELECT
             visited_on,
             SUM(daily_amount) OVER (
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS amountSum,
             ROW_NUMBER() OVER (ORDER BY visited_on) AS Week
         FROM daily
     )

SELECT
    visited_on,
    amountSum AS amount,
    ROUND(amountSum / 7.0, 2) AS average_amount
FROM Sum7D
WHERE Week >= 7
ORDER BY visited_on;