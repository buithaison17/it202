select * from orders
where totalAmount > (
	select avg(totalAmount) from orders
);