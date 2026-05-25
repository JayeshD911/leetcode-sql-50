select project_id , round(sum(experience_years) / count(p.employee_id) ,2) average_years
from Project p
         join Employee e
              on p.employee_id = e.employee_id
group by project_id;

