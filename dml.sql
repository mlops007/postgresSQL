select * from customer

alter table customer
add column initials varchar(100)

update customer
set full_name = concat(first_name, ' ',last_name)

update customer
set initials = concat(left(first_name,1), '.', left(last_name,1))

