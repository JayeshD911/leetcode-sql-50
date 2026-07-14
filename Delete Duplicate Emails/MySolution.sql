-- delete p2 from Person p1
-- join Person p2
-- on p1.email = p2.email and p1.id < p2.id
-- ;

delete p2 from Person p1, Person p2
where p1.email = p2.email and p1.id < p2.id;