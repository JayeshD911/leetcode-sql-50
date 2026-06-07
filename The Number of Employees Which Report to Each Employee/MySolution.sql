select m.employee_id, m.name, count(*) reports_count, round(avg(e.age)) average_age
from Employees e
join Employees m
on e.reports_to = m.employee_id
group by m.employee_id
order by m.employee_id ;