-- Q1

select distinct min(replacement_cost) as dis from public.film

--Q2

with transformed as(
select replacement_cost
	,case
		when replacement_cost between 9.99 and 19.99 then 'low'
		when replacement_cost between 20.00 and 24.99 then 'medium'
		when replacement_cost between 25.00 and 29.99 then 'high'
		else 'Unspecified'
	end as ranges
	
	from  public.film)
select count(ranges)
from transformed
where ranges = 'low'

--Q3


with transformed_1 as(
select
  cat.category_id
  ,cat.name
  ,fcat.film_id
  
  from public.category cat left join public.film_category fcat
  on cat.category_id = fcat.category_id)
  
,transformed_2 as(
select
	f.film_id
	,f.title
	,f.length
	
	,tr.name
	
from public.film f left join transformed_1 tr
	on f.film_id = tr.film_id
	where tr.name in('Drama', 'Sports')
)
select name, max(length) as longest
from transformed_2 
group by 1


--Q4

with transformed_1 as(
select
  cat.category_id
  ,cat.name
  ,fcat.film_id
  
  from public.category cat left join public.film_category fcat
  on cat.category_id = fcat.category_id)
  
,transformed_2 as(
select
	f.film_id
	,f.title
	,f.length
	
	,tr.name
	
from public.film f left join transformed_1 tr
	on f.film_id = tr.film_id

)

select name, count(title) as cnt
from transformed_2
group by 1
order by 2 desc


--Q5


select *  from public.film
select * from public.film_actor

with transformed_1 as(
select   
  fact.film_id
  
  ,act.actor_id
  ,concat(act.first_name, ' ' ,act.last_name) as name

  from public.actor act left join public.film_actor fact
  	on act.actor_id = fact.film_id)
, transformed_2 as(	
select 
	f.film_id
	,f.title
	
	,tr.name
	,count(f.*) as counter
from public.film f left join transformed_1 tr
	 on f.film_id = tr.film_id
	group by 1,2,3
order by 4 desc)
	 
select * from transformed_2

--Q6

select cu.* 
       ,ad.*
from public.address ad
left join
 public.customer cu
on ad.address_id = cu.address_id
where cu.customer_id is null


--Q7

select
  tr2.city
  ,coalesce(sum(tr2.amount), 0) as amt
from
(
select 
  ct.*
  ,tr.*

from public.city ct
left join
(select jn.*
	   ,ad.*
from  public.address ad
left join
(select pay.*
	   ,cus.*
from public.payment pay
left join
public.customer cus
on pay.customer_id = cus.customer_id) jn
on ad.address_id = jn.address_id) tr
on ct.city_id = tr.city_id) tr2
group by 1
order by 2 desc

--Q8

with transformed_1 as(
select 
       ad.city_id
	   ,cu.customer_id
from public.address ad
left join
public.customer cu
on cu.address_id = ad.address_id)

,transformed_2 as(
	select 
	   cu.customer_id
	   ,pay.amount   
from
public.payment pay
left join public.customer cu
on cu.customer_id = pay.customer_id
)

,transformed_3 as(
select 
    ci.city_id
	,co.country
	,ci.city


from public.country co
left join

public.city ci
on ci.country_id = co.country_id)


,joined_1 as(
	select tr1.city_id
			,tr2.amount
	from transformed_1 tr1
	left join transformed_2 tr2
	on tr1.customer_id = tr2.customer_id

)
,joined_2 as(
	select
	    tr3.country
	    ,tr3.city
	    
	    ,j1.amount
	
	from transformed_3 tr3
	left join joined_1 j1
	on j1.city_id = tr3.city_id
)
select country,city, sum(amount) as amt from joined_2
group by 1,2
order by 3 asc


--Q9

select
	staff_id
	,avg(sums) as average
from
(select staff_id
	   ,customer_id
	   ,sum(amount) as sums
from 
public.payment
group by 1,2) sums
group by 1

--Q10

select
 dt
 ,avg(total)
from
(select  
 date(payment_date)
 ,case 
 	when extract(dow from payment_date) = 0 then 'Sun'
 	when extract(dow from payment_date) = 1 then 'Mon'
 	when extract(dow from payment_date) = 2 then 'Tue'
 	when extract(dow from payment_date) = 3 then 'Wed'
 	when extract(dow from payment_date) = 4 then 'Thurs'
 	when extract(dow from payment_date) = 5 then 'Fri'
 	when extract(dow from payment_date) = 6 then 'Sat'
 end as dt
 ,sum(amount) as total
	  
from public.payment
where
extract(dow from payment_date) = 0
group by 1,2) d
group by 1


--Q11

select
	title
	,length
from

(select title
       ,length
	   ,replacement_cost
	   ,avg(length) over(partition by replacement_cost) as average
from
public.film
group by 1,2,3) len
where length > average
order by length asc

--Q12

select
	district
	,round(avg(amt.amounts),2) as amt
from
(select
	cu.district
    ,cu.customer_id
	,sum(pu.amount) as amounts


from public.payment pu
left join
(select 
	ad.district
	,cu.*	
from
public.address ad
left join
public.customer cu
on ad.address_id = cu.address_id) cu
on pu.customer_id = cu.customer_id
group by 1,2) amt
group by 1
order by 2 desc

--Q13

select 
	pay.payment_id
	,ren.*
	,pay.amount
from public.payment pay
left join public.rental ren
on pay.rental_id = pay.rental_id
