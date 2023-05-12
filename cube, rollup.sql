
select 
	flight_id
	,departure_airport
	,sum(actual_arrival-scheduled_arrival) over(partition by departure_airport order by flight_id)

from bookings.flights fl

select 
'Q' || date_part('quarter', book_date) as quarter
,date_part('month',book_date) as month
,'Week' || ' ' || to_char(book_date, 'w') as week
,date(book_date) as day
,sum(total_amount) as total
from
bookings.bookings
group by
cube(1,2,3,4)
order by 1,2,3,4



select 
'Q' || date_part('quarter', book_date) as quarter
,date_part('month',book_date) as month
,'Week' || ' ' || to_char(book_date, 'w') as week
,date(book_date) as day
,sum(total_amount) as total
from
bookings.bookings
group by
rollup(1,2,3,4)
order by 1,2,3,4
	