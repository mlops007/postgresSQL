select * from public.payment

create index idx_rental
on payment
(rental_id)


