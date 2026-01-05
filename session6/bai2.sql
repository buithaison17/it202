alter table orders
add column totalAmount decimal(10, 2);

UPDATE orders SET totalAmount = 1500000.00 WHERE orderId = 1;
UPDATE orders SET totalAmount = 2200000.00 WHERE orderId = 2;
UPDATE orders SET totalAmount = 1800000.00 WHERE orderId = 3;
UPDATE orders SET totalAmount = 950000.00  WHERE orderId = 4;
UPDATE orders SET totalAmount = 1250000.00 WHERE orderId = 5;
UPDATE orders SET totalAmount = 2000000.00 WHERE orderId = 6;
UPDATE orders SET totalAmount = 1750000.00 WHERE orderId = 7;
UPDATE orders SET totalAmount = 3000000.00 WHERE orderId = 8;
UPDATE orders SET totalAmount = 1450000.00 WHERE orderId = 9;
UPDATE orders SET totalAmount = 2600000.00 WHERE orderId = 10;

-- Hiển thị tổng tiền mà mỗi khách hàng đã chi tiêu 
select c.fullName "Họ tên",
case
	when SUM(o.totalAmount) then SUM(o.totalAmount)
    else 0
end "Tổng tiền"
from orders o
right join customers c on c.customerId = o.customerId
group by c.customerId, c.fullName;

-- Hiển thị giá trị đơn hàng cao nhất của từng khách
select c.fullName, max(o.totalAmount) from orders o
join customers c on c.customerId = o.customerId
group by c.customerId, c.fullName;

-- Sắp xếp danh sách khách hàng theo tổng tiền giảm dần
select c.fullName, max(o.totalAmount) from orders o
inner join customers c on c.customerId = o.customerId
group by c.customerId, c.fullName
order by max(o.totalAmount) desc;