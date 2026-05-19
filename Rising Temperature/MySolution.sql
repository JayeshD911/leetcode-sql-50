select a.id
from Weather a
         left join Weather b
                   on a.recordDate = DATE_ADD(b.recordDate, INTERVAL 1 DAY)
where a.temperature > b.temperature

-- select w1.id
-- from Weather w1, Weather w2
-- where datediff(w1.recordDate, w2.recordDate) = 1 and w1.temperature > w2.temperature;

-- select w1.id from Weather w1
-- join Weather w2
-- on datediff(w1.recordDate , w2.recordDate ) = 1
-- where w1.temperature > w2.temperature;
