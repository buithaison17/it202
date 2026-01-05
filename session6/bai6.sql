select p.productId, p.productName, sum(oi.quantity) as totalSales, 
sum(oi.quantity * p.price) as totalRevenue,
sum(oi.quantity * p.price) / sum(oi.quantity) as avgSellingPrice
from products p
left join orderitems oi on oi.productId = p.productId
group by p.productId;

-- Đã bán ít nhất 10 sản phẩm
select p.productId, p.productName, sum(oi.quantity) as totalQuantity
from products p
join orderitems oi on oi.productId = p.productId
group by p.productId
having totalQuantity > 10;

-- Doanh thu giảm dần
select p.productId, p.productName, sum(oi.quantity * p.price) as totalRevenue
from products p
join orderItems oi on oi.productId = p.productId
group by p.productId
order by totalRevenue desc;
 
-- Chỉ lấy 5 sản phẩm đứng đầu
 select p.productId, p.productName, sum(oi.quantity * p.price) as totalRevenue
from products p
join orderItems oi on oi.productId = p.productId
group by p.productId
order by totalRevenue desc
limit 5;