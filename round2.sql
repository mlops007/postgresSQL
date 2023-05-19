

CREATE VIEW v_employees_info
AS
with tr1 as(
select emp.* 
	,mgr.first_name || ' ' || mgr.last_name as manager
	,case
		when emp.end_date is null then true
		else false
	end as is_active
from public.employees emp
left join public.employees mgr
on emp.emp_id = mgr.manager_id)


select * from tr1


select position_title,round(avg(salary),2) from 
public.v_employees_info
where position_title = 'Software Engineer'
group by 1

SELECT 
division,
ROUND(AVG(salary),2)
FROM employees e
LEFT JOIN departments d 
ON e.department_id=d.department_id
GROUP BY division
ORDER BY 2 


