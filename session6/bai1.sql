create database session6;
use session6;

create table customers(
	customerId int primary key,
    fullName varchar(255),
    city varchar(255)
);

create table orders(
	orderId int primary key,
    customerId int,
    orderDate date,
    status enum("pending", "completed", "cancelled"),
    
    foreign key (customerId) references customers(customerId)
);

insert into customers (customerId, fullName, city) values
(1, 'Nguyễn Văn A', 'Hà Nội'),
(2, 'Trần Thị B', 'TP. Hồ Chí Minh'),
(3, 'Lê Văn C', 'Đà Nẵng'),
(4, 'Phạm Thị D', 'Hà Nội'),
(5, 'Hoàng Văn E', 'Cần Thơ');

insert into orders (orderId, customerId, orderDate, status) values
(1, 1, '2025-01-01', 'completed'),
(2, 1, '2025-01-02', 'pending'),
(3, 2, '2025-01-03', 'completed'),
(4, 2, '2025-01-04', 'cancelled'),
(5, 3, '2025-01-05', 'completed'),
(6, 3, '2025-01-06', 'pending'),
(7, 1, '2025-01-07', 'completed'),
(8, 2, '2025-01-08', 'pending'),
(9, 3, '2025-01-09', 'completed'),
(10, 1, '2025-01-10', 'cancelled');

-- Hiển thị danh sách đơn hàng kèm tên khách hàng 
select c.customerId, c.fullName, o.orderId, o.orderDate from orders o
inner join customers c on c.customerId = o.customerId;

-- Hiển thị mỗi khách hàng đã đặt bao nhiêu đơn hàng 
select c.fullName "Họ tên", count(o.orderId) as "Số đơn hàng" from orders o
right join customers c on c.customerId = o.customerId
group by c.customerId, c.fullName;

-- Chỉ hiển thị các khách hàng có ít nhất 1 đơn hàng
select c.fullName "Họ tên", count(o.orderId) as totalOrders from orders o
left join customers c on c.customerId = o.customerId
group by c.customerId, c.fullName