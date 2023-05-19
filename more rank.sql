select 
	first_name
	,last_name
	,position_title
	,salary
	,rank() over(partition by position_title order by salary asc )
	,dense_rank() over(partition by position_title order by salary asc )
	,lag(salary,1,0) over(partition by position_title order by salary asc )
	,lead(salary,1,0) over(partition by position_title order by salary asc )
	
	
	,lag(salary,1,0) over(partition by position_title order by salary asc ) - salary
from employees

select
	y.*
from
(select x.*
	,dense_rank() over(partition by position_title order by x.salary desc) as dd
from
(select 
	first_name
	,last_name
	,position_title
	,salary
	,max(salary) over(partition by position_title order by position_title ) as maxi

from employees
group by 1,2,3,4) x) y
where y.dd<2
