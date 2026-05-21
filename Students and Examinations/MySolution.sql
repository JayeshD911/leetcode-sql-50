select st.student_id , st.student_name , su.subject_name , count(e.subject_name ) attended_exams
from Students st
         join Subjects su
         left join examinations e
                   on e.student_id = st.student_id
                       and e.subject_name = su.subject_name
group by st.student_id , su.subject_name
order by st.student_id , su.subject_name
;


-- select st.student_id , st.student_name , su.subject_name , count(e.subject_name ) attended_exams
-- from Students st
-- join Subjects su
-- left join examinations e
-- on e.student_id = st.student_id
-- and e.subject_name = su.subject_name
-- group by student_id , subject_name
-- order by student_id , subject_name
-- ;