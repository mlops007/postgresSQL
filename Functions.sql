--Functions


create function rr_rate(min_r decimal(4,2), max_r decimal(4,2))
returns int
language plpgsql
as
$$
declare 
movie_count int;
begin
select count(*)
into movie_count
from film
where rental_rate between min_r and max_r;
return movie_count;
end;
$$

select rr_rate(0,1000.36)

select amount from public.payment pay


create or replace function name_search(f_name varchar, l_name varchar)
returns int
language plpgsql
as
$$
declare 
pay int;
begin
select sum(amount)
into pay
from payment
natural left join customer
where first_name = f_name and last_name = l_name;
return pay;
end;
$$

select
first_name
,last_name
,name_search(first_name
,last_name)
from customer







