select product_name, sum(unit) unit
from Orders o
         join Products p
              on o.product_id = p.product_id
-- where order_date < '2020-03-01' and order_date > '2020-1-31'
where order_date between '2020-02-01' and '2020-02-29'
group by product_name
having  sum(unit) >= 100
;