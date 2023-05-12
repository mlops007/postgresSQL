-- partition by
select customer_id
	   ,staff_id
	   ,sum(amount) over(partition by customer_id, staff_id) as amounts
	   ,avg(amount) over(partition by customer_id, staff_id) as averages
	  from public.payment
	  
with film as(	  
select 
	f.film_id
	,f.title
	,f.length
	from public.film f)

,category as(
select cat.name as category
	   ,fc.film_id
from public.category cat
left join public.film_category fc
on fc.category_id = cat.category_id)

,joined as(select
		f.film_id
		,f.title
		,f.length
		
		,fc.category
		   
		,round(avg(f.length) over(partition by category),2) as average
	
	from film f left join category fc
	on f.film_id = fc.film_id
		  order by f.film_id)
	
	select * from joined

select 
	*
	,count(payment_id) over(partition by amount,customer_id)

from public.payment
	order by payment_id 
	
-- ordrer by	

select 
	*
	,sum(amount) over(partition by customer_id order by payment_date asc,payment_id ) as running_total
from public.payment

-- rank and dense rank 

select 
	*
	,dense_rank() over(partition by name order by length desc)

from
public.mv_films_category

select 
	*
	,lag(name) over(order by sid)
		
from 
public.customer_list
