create materialized view 
mv_films_category 
as
select 
	fi.title
	,tr1.name
	,fi.length
	
from
(select 

	fc.film_id
	,cat.name

from public.film_category fc
left join
public.category cat
on cat.category_id = fc.category_id) tr1
left join 
public.film fi
on fi.film_id  =  tr1.film_id
order by length desc

select * from mv_films_category
