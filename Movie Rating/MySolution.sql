(select u.name results
 from MovieRating r
 join Users u
 on u.user_id = r.user_id
 group by r.user_id
 order by count(*) desc, u.name
 limit 1)
union all
(select m.title
 from MovieRating r
 join Movies m
 on r.movie_id = m.movie_id
 where created_at >= '2020-02-01' and created_at <= '2020-02-29'
 group by r.movie_id
 order by avg(rating) desc , title
 limit 1)
;

