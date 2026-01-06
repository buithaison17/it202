select * from customers c
where c.customerId in (
	select o.customerId from orders o
    group by o.customerId
    having sum(totalAmount) = (
		select max(totalSum) from (
			select sum(o1.totalAmount) as totalSum from orders o1
            group by o1.customerId
        ) as total
    )
)