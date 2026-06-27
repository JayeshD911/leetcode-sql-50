with running_total as (
    select person_name,
    sum(weight) over(order by turn) as Total_Weight
    from Queue
)select person_name
 from running_total
 where Total_Weight = (select max(total_weight)
                       from running_total
                       where total_weight <=1000)

-- with running_total as (
--     select person_name, sum(weight) over(order by turn) as total_weight
--     from Queue
-- )select person_name
--  from running_total
--  where total_weight <=1000
--  order by total_weight desc
--  limit 1;
