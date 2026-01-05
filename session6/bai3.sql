-- Tính tổng doanh thu theo từng ngày 
select orderDate, sum(totalAmount) from orders
group by orderDate;

-- Tính số lượng đơn hàng theo từng ngày
select orderDate, count(orderId) from orders
group by orderDate;

-- Chỉ hiển thị các ngày có doanh thu > 10.000.000
select orderDate "Ngày đặt", sum(totalAmount) tongDoanhThu from orders
group by orderDate
having tongDoanhThu > 10000000 ;