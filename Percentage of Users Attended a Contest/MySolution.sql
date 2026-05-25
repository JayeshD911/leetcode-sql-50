select contest_id , round(count(r.user_id)/(select count(*) from users) * 100, 2) percentage
from Register r
group by contest_id
order by percentage desc, contest_id  ;
