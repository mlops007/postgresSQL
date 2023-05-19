create or replace procedure sp_transfer(tr_amt int, sender int, recipent int)
language plpgsql
as
$$
begin

update acc_balance
set amount = amount + tr_amount
where id = recipient;

update acc_balance
set amount = amount  - tr_amount
where id = sender;

commit;
end;
$$

call sp_transfer(100,1,2)

select * from acc_balance