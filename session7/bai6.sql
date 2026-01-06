select * from customers c
where c.customerId in (
	select o.customerId from orders o
    group by o.customerId
    having sum(o.totalAmount) > (
		select avg(total) from (
			select sum(o1.totalAmount) as total from orders o1
            group by o1.customerId
        ) as temp
    )
);