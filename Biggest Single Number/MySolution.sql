-- This works because aggregate functions like MAX() return NULL when there are no rows.


select max(num) num
from(
        select  num
        from MyNumbers
        group by num
        having count(*) = 1
    ) t
;

-- The below query fails in the edge case where no number appears once,
-- because it returns an empty result set instead of NULL.

-- select  num
-- from MyNumbers
-- group by num
-- having count(*) = 1
-- order by num desc limit 1;

-- To solve this we use aggregation as they return null if the input empty