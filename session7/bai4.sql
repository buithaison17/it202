select c.customerId, c.customerName,
(
	select count(o.orderId) from orders o
    where o.customerId = c.customerId
) as quantityOrder 
from customers c;