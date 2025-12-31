create table orders(
	orderId int primary key,
    customerId int,
    totalAmount decimal(10, 2) not null,
    orderDate date not null,
    status enum("pending", "completed", "cancelled"),
    
    foreign key (customerId) references customers(customerId)
);

insert into orders(orderId, customerId, totalAmount, orderDate, status) values
(1, 1, 2500000.00, '2025-01-05', 'completed'),
(2, 2, 1800000.00, '2025-01-06', 'pending'),
(3, 3, 3200000.00, '2025-01-07', 'completed'),
(4, 4, 950000.00,  '2025-01-08', 'cancelled'),
(5, 5, 4100000.00, '2025-01-09', 'completed'),
(6, 6, 1250000.00, '2025-01-10', 'pending'),
(7, 7, 2750000.00, '2025-01-11', 'completed'),
(8, 8, 860000.00,  '2025-01-12', 'cancelled'),
(9, 9, 1990000.00, '2025-01-13', 'completed'),
(10, 10, 3450000.00, '2025-01-14', 'pending');

-- Lấy đơn có tổng hơn 5 triệu
select * from orders
where totalAmount > 5000000;

-- Hiển thị 5 đơn hàng mới nhất
select * from orders
order by orderDate desc
limit 5;

-- Lấy danh sách đơn hàng đã hoàn thành 
select * from orders
where status = "completed";

-- Hiển thị các đơn hàng đã hoàn thành, sắp xếp theo tổng tiền giảm dần 
select * from orders
where status = "completed"
order by orderDate desc;