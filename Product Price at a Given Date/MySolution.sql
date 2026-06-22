select
    a.product_id,
    coalesce((
                 select b.new_price
                 from Products b
                 where a.product_id = b.product_id and
                     change_date <= "2019-08-16"
                 order by change_date desc
             limit 1
        ) ,10) price
from (
         select distinct product_id
         from Products) a
;