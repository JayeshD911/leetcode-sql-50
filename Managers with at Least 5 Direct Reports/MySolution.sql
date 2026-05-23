select m.name from Employee e
                       join Employee m
                            on e.managerId = m.id
group by e.managerId
having count(e.id) > 4
;

select m.name from Employee e
                       join Employee m
                            on e.managerId = m.id
group by e.managerId
having count(*) > 4
;