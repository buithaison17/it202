-- Tổng số đơn hàng của mỗi khách 
select c.customerId, c.fullName, ifnull(sum(o.orderId), 0) totalOrder from customers c
left join orders o on o.customerId = c.customerId
left join orderitems oi on oi.orderId = o.orderId
group by c.customerId, c.fullName;

-- Tổng số tiền đã chi 
select c.customerId, c.fullName, ifnull(sum(oi.quantity * p.price), 0) totalSpent
from customers c
left join orders o on o.customerId = c.customerId
left join orderitems oi on oi.orderId = o.orderId
left join products p on p.productId = oi.productId
group by c.customerId, c.fullName;

-- Giá trị đơn hàng trung bình
select p.productId, p.productName, ifnull(sum(oi.quantity * p.price) / count(o.orderId), 0) as avgOrderValue 
from products p
left join orderItems oi on oi.productId = p.productId
left join orders o on o.orderId = oi.orderId
group by p.productId;

use session6;
select * from orderitems;

-- Khách hàng có từ 3 đơn hàng trở lên
select c.customerId, c.fullName, count(orderId) from customers c
join orders o on o.customerId = c.customerId
group by c.customerId, c.fullName
having count(orderId) >= 3;

-- Và tổng tiền > 10.000.000
select c.customerId, c.fullName, count(o.orderId) from customers c
join orders o on o.customerId = c.customerId
join orderItems oi on oi.orderId = o.orderId
join products p on p.productId = oi.productId
group by c.customerId, c.fullName
having count(o.orderId) >= 3 and sum(oi.quantity * p.price) > 10000000;

-- Sắp xếp theo tổng tiền giảm dần
select p.productId, p.productName, sum(oi.quantity * p.price) as totalAmount 
from products p
left join orderitems oi on oi.productId = p.productId
group by p.productId, p.productName
order by totalAmount desc;