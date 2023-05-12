--Q13

select
	
	 name
	,sum(amount) as total
from
(select
	
	tr4.payment_id
	,nme.name
	,tr4.title
	,tr4.amount
from public.category nme
left join
(select
    cat.*
	,tr3.payment_id
	,tr3.title
	,tr3.amount
from public.film_category cat
left join
(
select
	fi.title
	,tr2.*
from public.film fi
left join
(select
	tr1.*
	,inv.*

from public.inventory inv
left join
(select 
	re.inventory_id
	,pay.payment_id
	,pay.amount

from public.payment pay
left join
rental re
on re.rental_id = pay.rental_id) tr1
on tr1.inventory_id = inv.inventory_id) tr2
on tr2.film_id = fi.film_id) tr3
on cat.film_id = tr3.film_id) tr4
on nme.category_id = tr4.category_id
order by name asc) tr5
where name ='Action'
group by 1
--order by payment_id

--Q14

create view  q14
as
select
	
	 name
	 ,title
	,sum(amount) as total
from
(select
	
	tr4.payment_id
	,nme.name
	,tr4.title
	,tr4.amount
from public.category nme
left join
(select
    cat.*
	,tr3.payment_id
	,tr3.title
	,tr3.amount
from public.film_category cat
left join
(
select
	fi.title
	,tr2.*
from public.film fi
left join
(select
	tr1.*
	,inv.*

from public.inventory inv
left join
(select 
	re.inventory_id
	,pay.payment_id
	,pay.amount

from public.payment pay
left join
rental re
on re.rental_id = pay.rental_id) tr1
on tr1.inventory_id = inv.inventory_id) tr2
on tr2.film_id = fi.film_id) tr3
on cat.film_id = tr3.film_id) tr4
on nme.category_id = tr4.category_id
order by name asc) tr5
where name  = 'Animation'
group by 1,2
order by total desc

select * from q14