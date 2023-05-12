select 
	date(payment_date) as day

	,sum(amount)
	,lag(sum(amount)) over(order by date(payment_date) asc) as previous_day
	,lead(sum(amount)) over(order by date(payment_date) asc) as next_day
	,sum(amount) - lag(sum(amount)) over(order by date(payment_date) asc) as difference
	,((sum(amount) - lag(sum(amount)) over(order by date(payment_date) asc))/lag(sum(amount)) over(order by date(payment_date) asc))*100 as perct
from
public.payment
group by 1

select 
	staff_id
	,to_char(payment_date, 'Month') as mth
	,sum(amount) as total
from public.payment
group by
  grouping sets(
  (staff_id),
  (mth),
  (staff_id,mth))




	